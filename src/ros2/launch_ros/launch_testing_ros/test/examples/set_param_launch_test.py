# Copyright 2021 Open Source Robotics Foundation, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import os
import sys
import unittest

import launch
import launch.actions
import launch_ros.actions
import launch_testing.actions
import launch_testing.markers
import pytest
from rcl_interfaces.srv import SetParameters
import rclpy


@pytest.mark.launch_test
@launch_testing.markers.keep_alive
def generate_test_description():
    path_to_test = os.path.dirname(__file__)

    return launch.LaunchDescription([
        launch_ros.actions.Node(
            executable=sys.executable,
            arguments=[os.path.join(path_to_test, 'parameter_blackboard.py')],
            additional_env={'PYTHONUNBUFFERED': '1'},
            name='demo_node_1',
        ),
        launch_testing.actions.ReadyToTest()
    ])


class TestFixture(unittest.TestCase):

    def setUp(self):
        rclpy.init()
        self.node = rclpy.create_node('test_node')

    def tearDown(self):
        self.node.destroy_node()
        rclpy.shutdown()

    def test_set_parameter(self, proc_output):
        parameters = [rclpy.Parameter('demo_parameter_1', value=True).to_parameter_msg()]

        client = self.node.create_client(SetParameters, 'demo_node_1/set_parameters')
        try:
            ready = client.wait_for_service(timeout_sec=15.0)
            if not ready:
                raise RuntimeError('Wait for service timed out')

            request = SetParameters.Request()
            request.parameters = parameters
            future = client.call_async(request)
            rclpy.spin_until_future_complete(self.node, future, timeout_sec=15.0)

            assert future.done(), 'Client request timed out'

            assert future.result().results[0].successful, 'Could not set parameter!'
        finally:
            self.node.destroy_client(client)

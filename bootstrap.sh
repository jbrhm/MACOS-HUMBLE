echo "source ~/.ros2rc" >> ~/.zshrc
url -o ~/.ros2rc -LO https://raw.githubusercontent.com/jbrhm/MACOS-HUMBLE/refs/heads/main/.ros2rc
brew install cmake cppcheck eigen pcre poco python3 tinyxml wget asio tinyxml2 opencv log4cxx qt@5 freetype assimp python@3.10 bullet ninja git git-lfs glfw
source ~/.zshrc
git lfs install
mkdir -p ros2_humble
cd ros2_humble
python3.10 -m venv .venv
source .venv/bin/activate
python3 -m pip install argcomplete catkin_pkg colcon-common-extensions coverage empy==3.3.4 flake8 flake8-blind-except flake8-builtins flake8-class-newline flake8-comprehensions flake8-deprecated flake8-docstrings flake8-import-order flake8-quotes lark-parser mock nose pep8 pydocstyle pyparsing setuptools vcstool numpy
curl -o ./macos-humble.tar.gz -LO https://github.com/jbrhm/MACOS-HUMBLE/archive/refs/tags/v1.0.1.tar.gz 
tar -xzvf macos-humble.tar.gz --strip-components=1 
colcon build --symlink-install --packages-skip-by-dep python_qt_binding
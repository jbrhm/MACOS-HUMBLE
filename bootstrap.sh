echo "source ~/.ros2rc" >> ~/.zshrc
curl -o ~/.ros2rc -LO https://raw.githubusercontent.com/jbrhm/MACOS-HUMBLE/refs/heads/main/.ros2rc
curl -O https://raw.githubusercontent.com/Homebrew/homebrew-core/b4e46db74e74a8c1650b38b1da222284ce1ec5ce/Formula/c/cmake.rb
curl -O https://raw.githubusercontent.com/Homebrew/homebrew-core/502489d3a4c1ca0a3854830eb5da2327b6feb54d/Formula/a/asio.rb
brew install ./asio.rb
brew install ./cmake.rb
brew install qt@5 cppcheck eigen pcre poco python3 tinyxml2 wget tinyxml2 opencv log4cxx freetype assimp python@3.10 bullet ninja git git-lfs glfw
source ~/.zshrc
git lfs install
mkdir -p ros2_humble
cd ros2_humble
python3.10 -m venv .venv
source .venv/bin/activate
python3 -m pip install argcomplete catkin_pkg colcon-common-extensions coverage empy==3.3.4 flake8 flake8-blind-except flake8-builtins flake8-class-newline flake8-comprehensions flake8-deprecated flake8-docstrings flake8-import-order flake8-quotes lark-parser mock nose pep8 pydocstyle pyparsing setuptools==75.6.0 vcstool numpy
curl -o ./macos-humble.tar.gz -LO https://github.com/jbrhm/MACOS-HUMBLE/archive/refs/tags/v1.0.1.tar.gz 
tar -xzvf macos-humble.tar.gz --strip-components=1 
colcon build --symlink-install --packages-skip-by-dep python_qt_binding
cd
mkdir -p ros2_ws/src
git clone git@github.com:umrover/mrover-ros2 ros2_ws/src/mrover
cd ros2_ws/src/mrover
git submodule update --init
./scripts/build_dawn.sh

# MACOS-HUMBLE
Slightly altered git repository for building ROS2 humble on mac arm64 chipsets

# Installation:

1. Disable SIP:
You must [disable system protection](https://developer.apple.com/documentation/security/disabling-and-enabling-system-integrity-protection)

2. Install xcode
> [!IMPORTANT]  
> You must have installed xcode (the entire editor not just command line tools)

3. Install [brew](https://brew.sh)

4. Run `curl -o ./bootstrap.sh -LO https://raw.githubusercontent.com/jbrhm/MACOS-HUMBLE/refs/heads/main/bootstrap.sh && chmod +x bootstrap.sh &&./bootstrap.sh`

# replace 9C33-6BBD to your SD card ID.
# should using gnu sed, macOS sed is not working
sed -i "s/XXXX-XXXX/9C33-6BBD/g" `grep XXXX-XXXX -rl ./`
# or
find ./ -type f -exec sed -i -e 's/XXXX-XXXX/9C33-6BBD/g' {} \;
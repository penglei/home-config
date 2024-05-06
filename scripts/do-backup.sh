cd ../secrets
passage superkey
cd local-build
rm -rf recovery/passage
cp -R ~/.passage recovery/passage
tar cz ./recovery | age -p >recovery.enc
mv recovery.enc ..

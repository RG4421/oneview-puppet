cd ..
mkdir puppet_backup
cd puppet_backup
git clone https://github.com/HewlettPackard/oneview-puppet oneview
cd oneview
cp Gemfile ${1}/oneview
cp Rakefile ${1}/oneview
cp .robocop.yml ${1}/oneview
cp .travis.yml ${1}/oneview
cp .gitignore ${1}/oneview
cp .gitattributes ${1}/oneview
cp metadata.json ${1}/oneview
cp .pdkignore ${1}/oneview
cp spec/spec_helper.rb ${1}/oneview/spec
cd ../..
rm -rf puppet_backup

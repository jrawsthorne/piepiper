# Team 10

## Usage

```bash
git clone https://github.com/COM1001-ComputerScience-Sheffield/team-10.git
cd team-10
```
If error occurs with bcrypt:
```bash
gem uninstall bcrypt
gem install bcrypt --platform=ruby

bundle exec rake
rackup -p 4567
```

To deploy
```bash
bundle exec rake deploy
```

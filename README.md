# Linux Developer Setup

Automated setup script for configuring a new development machine.

## Features

- Installation profiles
- Interactive menu
- Auto resume
- Colored logs
- Progress bar
- Streaming logs

---

## Quick Install

Run:
curl -s https://github.com/sm-28/LinuxMintDeveloperSetup/blob/main/bootstrap.sh | bash


---

## Profiles

Core tools


./setup.sh --core


AI stack


./setup.sh --ai


Infrastructure tools


./setup.sh --infra


Full setup


./setup.sh --full


---

## Resume Interrupted Install

Just run:


./setup.sh


Completed steps will be skipped.

---

## Logs

Logs are stored in:


logs/setup.log

FROM python:3

# Update Software repository
RUN apt-get update
RUN apt install git -y

# Set up dev environment
WORKDIR /bot
RUN git clone https://github.com/Drakkar-Software/Octobot /bot/octobot
WORKDIR /bot/octobot
RUN git checkout dev

# install dependencies
RUN bash ./docs/install/linux_installer.sh

# configuration
RUN cp ./config/default_config.json ./config/config.json
RUN cp ./config/default_evaluator_config.json ./config/evaluator_config.json

# python libs
RUN pip3 install -U setuptools
RUN pip3 install -r requirements.txt

# install evaluators
RUN python start.py -p install all

# entry point
ENTRYPOINT ["python"]
CMD ["start.py"]

# Salt module to make it easy for Linux beginners to setup Fedora 40 with working Nvidia drivers + SecureBoot ✅

## List of contents and short introduction

- **[How to install salt-minion and copy the module to make the commands work](https://github.com/KebabGarva/salt-nvidia-secureboot/blob/main/README.md#how-to-install-salt-minion-and-copy-the-module-to-make-the-commands-work)**
  
  - **[Step 1: Install the salt-minion](https://github.com/KebabGarva/salt-nvidia-secureboot/blob/main/README.md#step-1-install-the-salt-minion)**
    
  - **[Step 2: Make the states work](https://github.com/KebabGarva/salt-nvidia-secureboot/blob/main/README.md#step-2-install-the-module)**
    
  - **[Step 3: Test if the module works](https://github.com/KebabGarva/salt-nvidia-secureboot/blob/main/README.md#step-3-test-if-the-module-works)**


- **[How to use the module step-by-step](https://github.com/KebabGarva/salt-nvidia-secureboot/blob/main/README.md#how-to-use-the-module-step-by-step)**

  - **[Step 1: Initial Setup](https://github.com/KebabGarva/salt-nvidia-secureboot/blob/main/README.md#step-1)**
    
  - **[Step 2: Adding repos and reboot](https://github.com/KebabGarva/salt-nvidia-secureboot/blob/main/README.md#step-2)**
    
  - **[Step 3: Generating and importing key](https://github.com/KebabGarva/salt-nvidia-secureboot/blob/main/README.md#step-3)**
    
  - **[Step 4: Installing Nvidia drivers](https://github.com/KebabGarva/salt-nvidia-secureboot/blob/main/README.md#step-4)**
    
  - **[Step 5: Check that the built modules run kernel & boot image status](https://github.com/KebabGarva/salt-nvidia-secureboot/blob/main/README.md#step-5)**
    
  - **[(OPTIONAL) Step 6: Install user-experience enhancing programs](https://github.com/KebabGarva/salt-nvidia-secureboot/blob/main/README.md#step-6)**

- **[Quick summary to what the module actually does](https://github.com/KebabGarva/salt-nvidia-secureboot/blob/main/README.md#quick-summary-to-what-the-module-actually-does)**

- **[Why Fedora 40 and not Nobara](https://github.com/KebabGarva/salt-nvidia-secureboot/blob/main/README.md#why-fedora-40-and-not-nobara)**

- **[Testing the module](https://github.com/KebabGarva/salt-nvidia-secureboot/blob/main/README.md#testing-the-module)**

This is a module that is heavily inspired by roworu's guide to install Nvidia drivers that work with SecureBoot on. If you want to star this module, please show some love for them by [starring their guide](https://github.com/roworu/nvidia-fedora-secureboot)!

The module was done as the final work for [Tero Karvinen's Saltstack course](https://terokarvinen.com/2024/configuration-management-2024-spring/). The module was finalized on May 12 2024. You can access the module by clicking [this link](https://github.com/KebabGarva/salt-nvidia-secureboot). 

The biggest motive for me to make this is because even though I know how to operate Linux on an intermediate level, it was super hard for me to setup my computer to run games on Linux. And because my GPU is Nvidia based, setuping was much harder and I had to do a lot of tweaks to make my gpu work without any hiccups.

Even though it's easier than over 10 years ago to operate Nvidia GPUs in Linux, it's still hard compared to Windows even though it should not be!

If you don't know what Torvalds had to say regarding Nvidia over 10 years ago, [watch this!](https://youtu.be/xPh-5P4XH6o?si=uBH4jZ1_EcIGYfA_&t=77)

This readme will be transferred to the right repository (the repo where the module is) in the future. The point of this module is to show that Salt can be used as a fault-proof way to automatize individual configuration much better than bash scripts.

If you're a beginner to Linux and you want to make your games run smoothly, you've come to the right place! Follow these steps to get started!

## How to install salt-minion and copy the module to make the commands work

**NOTE: If you want to get to know Salt and about its operation, click [this link](https://docs.saltproject.io/en/latest/topics/index.html) to see introduction to Salt. I learned to use Salt via the documentation that includes the hyperlinked introduction. I highly recommend to get to know [Salt state modules](https://docs.saltproject.io/en/latest/ref/states/all/index.html) first, because that's where I started first.**

Feel free to copy-paste these commands, because I explain what these commands do.

And for you, absolute Linux beginners, you use `sudo` when you need to run commands with administrator privileges. 

### Step 1: Install the salt-minion

This installs the salt using Fedora's default package manager dnf. The option "-y" means that it automatically accepts the installation without having to press the y button manually.

```
sudo dnf install -y salt-minion
```
### Step 2: Install the module

First command makes sure that your user is in their home directory. The second command clones my repository using git, which is hands-down the best version manager software and installed ready with your Fedora 40. The third command makes a new directory with "-p" option that will create the directory regardless if directory `/srv/` doesn't exist yet. The fourth command copies the cloned repository to the salt-directory. The "-r" option means that the command copies the directory recursively.

```
cd
```
```
git clone https://github.com/KebabGarva/salt-nvidia-secureboot.git
```
```
sudo mkdir -p /srv/salt
```
```
sudo cp -r salt-nvidia-secureboot/* /srv/salt/
```

### Step 3: Test if the module works

Run this following command to make sure that the module works as intended. The specified state makes a `helloworld.txt` file in `/home/` folder. If the file is there, you're good to go. Salt will let you know if the file has been made, if it already exists or the module doesn't work.

```
sudo salt-call --local -l info state.apply test
```
This is what should happen if you've followed :

![image](https://github.com/user-attachments/assets/254a7000-ebef-4bc1-93ab-97bca0efaf9f)


## How to use the module step-by-step

***FIRST NOTE: If you have tried manually installing NVIDIA drivers e.g. from their website ([example website](https://www.nvidia.com/Download/index.aspx)) and running the installation file... STOP NOW!! Back up your most valuable data before installing Fedora 40 again***

### Step 1

Run the following command in the terminal:

```
sudo salt-call --local -l info state.apply step1
```

This will delete all older Nvidia packages that could potentially conflict with the setup process. This will also make sure if SecureBoot is on and nvidia packages are uninstalled.

Copy-paste this command to make sure that you have no enrolled keys in MOK.

```
sudo mokutil --delete /etc/pki/akmods/certs/public_key.der
```
If you have no keys, it will look like this:

![image](https://github.com/user-attachments/assets/414a770b-e85b-4de6-8a07-d81936e9a713)



If you don't have any keys, good!! If you didn't even have nvidia packages installed before, even better!! But because we want to be 120% sure, let's reboot:

```
sudo systemctl reboot
```

If you have enrolled keys, you'll be asked to input your password. If you don't remember the password, feel free to try a few times. If it seems hopeless, don't worry! Installing Fedora 40 again will not take too long, and you can make a new partition where you can move your important files or just back-up them in the cloud. 🫶🫶🫶

If you are using a laptop with optimus, check that you have dynamic graphics selected via UEFI before booting to Linux. If it's not selected, the screen will go so dark that it seems like it's not even on.

If you need to delete the key, copy paste the contents in the first box and follow the instructions below:

```
sudo systemctl reboot
```
Select Delete Mok -> Select Continue -> type your password -> Reboot or Continue boot

After you've done that proceed to the next step

### Step 2

```
sudo salt-call --local -l info state.apply step2
```

This will add the rpmfusion repos, refresh list before upgrading and then upgrading the system. Copy-paste the command and run it in the terminal.

If it seems like it takes forever, press `ctrl+c` and try the command again.

This is what it should look like.

![image](https://github.com/user-attachments/assets/89f6c336-2310-41d4-9663-c6764cf2d6b6)



After you've successfully run the command, reboot the system again.

```
sudo systemctl reboot
```

### Step 3

```
sudo salt-call --local -l info state.apply step3
```

This will install signing modules, generate a key and import the key. BEFORE you run the command, you can set your own password if you want. The default password is `1234wohoo`. If you want to change the password, you can edit the `init.sls` -file.

```
sudoedit /srv/salt/step3/init.sls
```

The command `printf '1234wohoo\n1234wohoo\n'` is the one in the question. Don't remove any one of the two `\n` newlines because they act as ENTER -keys! The command will not work then! Be careful!

If you have problems with running the state, you can try to run this command seperately before running step3.:

```
sudo kmodgenca -a
```
It worked for me at least.

After successfully running step 3 command, reboot the system

```
sudo systemctl reboot
```
After this, you are inside MOK manager. Follow the instructions below:

Select Enroll Mok -> Select Continue -> Select Yes -> type your password -> Reboot

If you pressed accidentally Continue boot, run the step3 again.

After this, you're ready to install NVIDIA drivers

### Step 4

```
sudo salt-call --local -l info state.apply step4
```
This will install Nvidia drivers. **It WILL take a while!**

If you want to install CUDA support to your CUDA-compatible GPU, copy-paste the command below:

```
sudo dnf -y install xorg-x11-drv-nvidia-cuda
```

**NOTE: Check if xwayland is installed, because xorg will not work as it's intended in the future**

```
sudo dnf -y install xorg-x11-server-Xwayland
```

**NOW WAIT!!** The modules take some time to load. I recommend waiting at least 5 minutes and 10 minutes is recommended. You can check if the process is done by checking if terminal returns the driver version. If it prints something else, **HOLD STILL! THE MODULES ARE STILL BUILDING!**

It's good if it prints something like this:

![image](https://github.com/user-attachments/assets/436b26d6-d5c8-4bee-8f09-33c17e9e7db3)


```
modinfo -F version nvidia
```

**Wait even though it recognized the driver!!**

You can be absolutely sure that the modules have been built at this point. Continue to the final mandatory step.

## Step 5

```
sudo salt-call --local -l info state.apply step5
```
This will check akmods packages and will build them if needed. It will also overwrite the existing initramfs file.

After this is done, reboot again and you can enjoy your new working drivers!

```
sudo systemctl reboot
```
If you have optimus laptop (district and dynamic graphics) remember to enable district graphics in the UEFI.

If you want to make sure if your setup worked, type the command below:

```
nvidia-smi
```

This will return driver info if driver has installed properly.

Next I'll include an optional step to install not mandatory, but **SUPER USEFUL APPS** to enhance your Linux experience.

## Step 6

This will not use Salt, but I wanted to include this step so you can take a look at the Software app for something nice to download.

Here are my recommendations:

 - Vesktop
   - Discord client that actually works
 - Gnome Extension manager
   - get to customize your desktop enviroment to look exactly how you want it
   - Check [this Youtube video](https://www.youtube.com/watch?v=AE1-W2bMVEs) to help you pick extensions.
 - Gnome Tweaks
 - Steam
 - ProtonUp-Qt GUI to install Wine- and Proton-based compability tools
 - Lutris universal game launcher
 - Mangohud overlay for monitoring FPS
 - Goverlay GUI to customize the Mangohud config file

## Quick summary to what the module actually does

This is to explain to my lecturer and peer students how the module works in a nutshell.

### Initial setup

- Make sure that SecureBoot is on
  - If it's not on, the user turns it on via BIOS settings.
- All older Nvidia installations have been uninstalled
- Reboot

### Adding repos and reboot

- Adding rpmfusion repos
  - free
  - nonfree
- Full update of system
- Reboot

### Generating and importing key

- Generating the key
- Importing the key
  - Uses the pre-determined password using printf
  - Highly recommended to change the password via the step3 init.sls -file
- Reboot
  - After reboot, user enrolls the key in MOK manager

### Installing Nvidia drivers 

- Uses pkg.installed state function to install the packages
- Waiting period of 5-10 minutes because the modules need to build before rebooting

### Check that the built modules run kernel & boot image status

- Run akmods and dracut by force
- Reboot

## Why Fedora 40 and not Nobara.

### TL;DR

Use this module if you think Nobara isn't for you but you still want to have the option to play games on Linux with SecureBoot on without stressful tinkering for a long time. 

#### Longer explanation

Even though Nobara makes it easy to setup Linux for gaming without any tinkering, the reasons are very self-explanatory at least for me:

- ***SecureBoot needs to be turned OFF for Nobara***
- Nobara is directed heavily towards people who just want to use the distro for gaming only
  - Not an universal solution for everyone
  - "Too gamer-distro for regular user"
- Fedora 40 is more
  - secure
  - supported
  - **universally faster**

The point of the module is to automatically make sure that all preconditions for setuping Fedora properly for gaming have been met and then doing all necessary installations and commands.
This will save beginners a lot of time and from massive headaches.

## Testing the module

This is to make sure that the module works following my instructions. I started from Fresh install of Fedora 40. I made a seperate partition to test my modules natively to make it 100% clear that this works. This is a screenshot as a proof that I started from a fresh install of Fedora 40.

![image](https://github.com/user-attachments/assets/7358cd17-b8ae-400e-8ef4-bd808f41666d)

![image](https://github.com/user-attachments/assets/cdcb7fda-a39e-404a-975b-e5b42045c9b3)


### Installing salt-minion and states

![image](https://github.com/user-attachments/assets/099de919-3cfd-4178-8822-0df1d200ccfd)


![image](https://github.com/user-attachments/assets/635d2595-504e-48a4-9b53-7574125636be)


![image](https://github.com/user-attachments/assets/f454c864-a503-4d45-836a-75509a410975)



### Step 1

![image](https://github.com/user-attachments/assets/38b00b97-58ed-4a52-bb3a-b19f83f07862)


![image](https://github.com/user-attachments/assets/1c166d80-09e6-4315-b925-ea453b417e7a)


### Step 2

At this point I had to make some changes to the states, because there was a typo. If you run these commands, it will 100% work.

![image](https://github.com/user-attachments/assets/a2b822b5-2c01-44db-b956-0edc6b7f04b3)


### Step 3

I forgot to commit to here before rebooting so this is after the reboot. Apologies! 

![image](https://github.com/user-attachments/assets/b45324b3-426e-41a2-aa97-7f83f8c904e8)


### Step 4

Yep... A lot of packages :D 

![image](https://github.com/user-attachments/assets/09143bc4-81dc-42b7-a80b-3209e7e509ec)


Now it's time to wait.


### Step 5

![image](https://github.com/user-attachments/assets/97d9bc7f-7017-4e6d-8328-93dfc0d6734a)


I switched to discrete graphics on my Laptop by smashing F2 on my keyboard. I didn't even have to switch to nouveau manually because it did it by itself!















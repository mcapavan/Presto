Install Data Lake Starter (DLS) with Loom into virtual machine
==========================

This module provisions DLS with Loom into a virtual machine.

The Prerequisites
--------------
* Vagrant installed
* VirtualBox installed
* Teradata VPN connected
* InternalAssets checked out

The Command
--------

To install DLS and Loom run

    $> ./install.sh [-e|--environment ENV]

The script will load configuration properties from "install.properties". And if -e parameter is present will also
overload properties from env/install-[ENV].properties.

The Process behind the Command
--------

01. Creates "/var/dls" directory
02. Downloads "packer" into "/tmp/dls/packer.zip". Packer is required to convert OVA files to Vagrant BOX files. Will skip download if file is already present.
03. Installs "packer" if not already installed.
04. Downloads sandbox into "/tmp/dls/Sandbox.ova" from Hortonworks. Will skip download if file is already present.
05. Converts "/tmp/dls/Sandbox.ova" to "ˇ/Sandbox.box" with help of Packer. Will skip conversion if "/tmp/dls/Sandbox.box" is already present.
06. Calls `vagrant up` to create VM and further configure with Vagrant.
07. Vagrant config will:
    01. Share two directories with VM: InternalAssets and maven repo.
    02. Forward two ports: 8083 for Loom and 8282 for Pipeline jobs.
    03. Set up Teradata DNS name server
    04. Install required packages: RPM, RPM-BUILD, TREE
    05. Download and install Loom. Will skip if Loom is already downloaded.
    06. Create MySql database
    07. Download and install Maven. Will skip if Maven is already downloaded.
    08. Build/package DLS with Maven
    09. Install DLS RPM 
    10. Start Loom
    11. Configure and start DLS pipeline
08. Logs into VM with private-public key pair
    
    
The process should be designed to be repeatable. If it fails at any stage one should be able to "restart" the process with:

    $> vagrant halt
    $> vagrant up
    $> vagrant provision
    

Once DLS and Loom are started
-----

* SSH into VM with password: `ssh -p 2222 root@127.0.0.1` with password `hadoop` or
* SSH into VM with key pair: `ssh -i ~/.ssh/dls -p 2222 root@127.0.0.1` without password prompt
* Start/stop/status Loom: `service loom [start|stop|status]`
* Loom logs: `tail -f /var/log/loom/loom.out`
* View Loom in browser: `http://127.0.0.1:8083/` with user `dluser` and password `thinkbig`
* Start/stop/status pipeline application: `/etc/init.d/pipeline-application [start|stop|status]`
* Pipeline logs: `tail -f /var/log/pipeline-application/pipeline-application.log`
* View Pipeline Jobs in browser: `http://127.0.0.1:8282/`
* Land some data in drop zone: `/opt/tba/pipeline-application/test-data/copyFilesToDropzone.sh`


Future Work Items
-------
1. Externalize more moving parts into install.properties
2. Add system test which lands test data in drop zone and verifies results in Loom and Pipeline
3. Extend system test for different DLS modes, e.g. STANDALONE vs BUFFER_NODE vs EDGE_NODE etc
4. Extend system test for different providers, e.g. Hortonworks, Cloudera, AWS etc



 ## forward port for Presto - for local development
    config.vm.network :forwarded_port, host:8084, guest:8084

    ## Spark
    config.vm.network :forwarded_port, host:4040, guest:4040

    ## Spark History Server
    config.vm.network :forwarded_port, host:18080, guest:18080





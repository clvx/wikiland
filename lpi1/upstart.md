Upstart
=======

init is the parent of all processes on the system, it is executed by the kernel and is responsible for starting all other processes; it is the parent of all processes whose natural parents have died and it is responsible for reaping those when they die.
    • upstart is the first process to start and still launches system services but launch processes in parallel, instead of SysV init which launches processes sequentially.
        ∘ SysV init used to use bash scripts to launch services.
    • upstart is an event-based init daemon. This means that jobs will be automatically started and stopped by changes that occur to the system state, including as a result of jobs starting and stopping.
        ∘ This is different to dependency-based init daemons which start a specified set of goal jobs, and resolve the order in which they should be started and other jobs required by iterating their dependencies.
    • Processes managed by init are known as jobs and are defined by files in the `/etc/init` directory, and watches for future changes to these files using inotify(7).
        ∘ Files ending in .conf are called configuration files.
        ∘ Files ending .override are called override files which it takes precedence over those equivalent named stanzas in the corresponding configuration file contents for a particular job.
        ∘ Each configuration file defines the template for a single service(daemon) or task (short-lived process)
            ‣ A configuration file is a description of a environment a job could be run in. 
            ‣ A job is the runtime embodiment of a configuration file.
    • Each job may have one or more different processes run as part of its lifecycle, with the most common known as the main process.
    • The main process is defined using either exec or script stanzas. These specify the executable or shell script that will be run when the job is considered to be running. Once this process terminates, the job stops.
            ‣ Jobs can be started and stopped automatically by the init(8) daemon by specifying which events should cause your job to be started or stopped. 
    • Also, Jobs can be manually started and stopped at any time using the start(8) and stop(8) tools.
            ‣ When first started , the init(8) daemon will emit the startup(7) event. This will activate jobs that implement System V compatibility and the runlevel(7) event.
    • start on EVENT, defines the set of events that will cause the job to be automatically started.
    • stop on EVENT, defines the set of events that will cause the job to be automatically stopped.


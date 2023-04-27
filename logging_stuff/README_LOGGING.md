# Logging Stuff

## start logging 
Okay so use the `start_loggin.sh` script to start logging. It will create a log file in the `~/terminal_logs` directory with a timestamped name. 

## clean logs
Now to make sure the logs dont take up too much space, we use the `remove_old_logs.sh` script to remove logs once the directory size is over 1GB.

## anacron job to clean logs

To run the `remove_old_logs.sh` script periodically, I have set up a anacron job as follows:

```bash
$ cat /etc/anacrontab
# /etc/anacrontab: configuration file for anacron

# See anacron(8) and anacrontab(5) for details.

# stuff removed for privacy...

# These replace cron's entries
# stuff removed for privacy...
1       5       cleanlogs.daily /path/to/remove_old_logs.sh
```

That last line is what you need. MAKE SURE YOU FIX THE PATH TO THE SCRIPT.
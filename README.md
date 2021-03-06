## Systemtap tapset files for OpenJdk9

Provides tapset files for OpenJDK9, the **D** script program files for posix in OpenJDK9 can be found at **hotspot/src/os/posix/dtrace**, there are 3 script program files found at this location, namely *hotspot.d, hs_private.d and hotspot_jni.d*.

Tapset files will be placed in tapset-1.9.0 directory, to make use of tapset we need to have OpenJDK9 build with Systemtap enabled.
Below are the steps which needs to be done before tapset are ready to be used (in future we will be having auto scripts which will do things for us).

#### Using script 
* Run **create-tapset.sh** by passing libjvm.so path of server and client (second parameter is optional).
* After script is run, tapset files can be found in directory **systemtap-tapset**

#### Systemtap usage in OpenJDK
OpenJDK uses user space probing using **compiled-in instrumentation**, in which embedded markers are placed in OpenJDK source code and expose selected names and there values only to systemtap scripts. This makes OpenJDK unnecessary to maintain a tapset script, and instead involves adding calls to macros from <sys/sdt.h> in source code. These calls are source compatible with dtrace on other platforms, so the same source code compiled on a system that doesn't have systemtap available, but does have a dtrace implementation will be able to discover the same probe locations. The GNU Debugger (GDB) has also been extended to allow users to set breakpoints on such probes if available.


#### Manually
* You may want to copy tapset-1.9.0 directory in some location.
* Replace @ABS_CLIENT_LIBJVM_SO@ and @ABS_SERVER_LIBJVM_SO@ with jre/lib/[arch]/[client|server]/libjvm.so respectively.
* hotspot.object_alloc (which is defined in hotspot-1.9.0.stp) contains __HEADWORD_SIZE, please replace this with 8 if its 64 bit or 4 when its 32 bit.

#### Example
Below is an example of probing thread_start and thread_stop for simple HelloWorld application.

<pre>
sudo stap -I <PATH>/systemtap-tapset-openjdk9/tapset-1.9.0 -e 'probe hotspot.thread_* {log(probestr)}' -c 'JAVA_HOME_OPENJDK_9/bin/java -XX:+ExtendedDTraceProbes HelloWorld'
</pre>

When we run above in command prompt and if things are configured correctly then we will be getting output as below (sample).

<pre>
thread_start(thread_name='Reference Handler',id=2,native_id=14773,is_daemon=1)
thread_start(thread_name='Finalizer',id=3,native_id=14774,is_daemon=1)
thread_start(thread_name='Signal Dispatcher',id=4,native_id=14775,is_daemon=1)
thread_start(thread_name='C2 CompilerThread0',id=5,native_id=14776,is_daemon=1)
thread_start(thread_name='C2 CompilerThread1',id=6,native_id=14777,is_daemon=1)
thread_start(thread_name='C1 CompilerThread2',id=7,native_id=14778,is_daemon=1)
thread_start(thread_name='Sweeper thread',id=8,native_id=14779,is_daemon=1)
thread_start(thread_name='Service Thread',id=9,native_id=14780,is_daemon=1)
thread_stop(thread_name='Signal Dispatcher',id=4,native_id=14775,is_daemon=1)
</pre>

#### References
- [Hotspot Serviceability Doc](http://openjdk.java.net/groups/hotspot/docs/Serviceability.html)
-  Directory tapset-1.8.0 contains tapset taken from [pkgs.fedoraproject](http://pkgs.fedoraproject.org/repo/pkgs/java-1.8.0-openjdk/systemtap-tapset.tar.gz/94ca5a45c3cb3b85c4577d0891166007/systemtap-tapset.tar.gz)
-  Tapset from IceaTea7 can be found at [icedtea7] (http://icedtea.classpath.org/hg/icedtea7/file/tip/tapset)

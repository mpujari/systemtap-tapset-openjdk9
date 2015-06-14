# systemtap-tapset-openjdk9

Tapset files for OpenJdk9

Need to replace @ABS_CLIENT_LIBJVM_SO@ and @ABS_SERVER_LIBJVM_SO@ with jre/lib/[arch]/[client|server]/libjvm.so respectively.

NOTE: hotspot.object_alloc contains hardcoded value of 8 to HeapWordSize (for 64 bit), when its 32 bit need to be replaced with 4.

Directory tapset-1.8.0 contains tapset taken from http://pkgs.fedoraproject.org/repo/pkgs/java-1.8.0-openjdk/systemtap-tapset.tar.gz/94ca5a45c3cb3b85c4577d0891166007/systemtap-tapset.tar.gz.

Tapset from IceaTea7 can be found at http://icedtea.classpath.org/hg/icedtea7/file/tip/tapset

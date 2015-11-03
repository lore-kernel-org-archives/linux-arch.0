From: Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC PATCH 16/28] lkl tools: host lib: add lkl_strerror and lkl_printf
Date: Tue,  3 Nov 2015 22:20:47 +0200
Message-ID: <1446582059-17355-17-git-send-email-octavian.purdila@intel.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, thehajime@gmail.com, Octavian Purdila <octavian.purdila@intel.com>
List-Id: linux-arch.vger.kernel.org

Add basic utility functions for getting a string from a kernel error
code and a fprintf like function that uses the host print
operation. The latter is useful for informing the user about errors
that occur in the host library.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 tools/lkl/include/lkl.h      |   8 ++
 tools/lkl/include/lkl_host.h |   7 ++
 tools/lkl/lib/utils.c        | 177 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 192 insertions(+)
 create mode 100644 tools/lkl/lib/utils.c

diff --git a/tools/lkl/include/lkl.h b/tools/lkl/include/lkl.h
index 2de5ed4..958614d 100644
--- a/tools/lkl/include/lkl.h
+++ b/tools/lkl/include/lkl.h
@@ -12,4 +12,12 @@ static inline long lkl_sys_lseek(unsigned int fd, __lkl__kernel_loff_t off,
 	return lkl_sys_llseek(fd, off >> 32, off & 0xffffffff, res, whence);
 }
 
+/**
+ * lkl_strerror - returns a string describing the given error code
+ *
+ * @err - error code
+ * @returns - string for the given error code
+ */
+const char *lkl_strerror(int err);
+
 #endif
diff --git a/tools/lkl/include/lkl_host.h b/tools/lkl/include/lkl_host.h
index 8ee9ba0..9f1c270 100644
--- a/tools/lkl/include/lkl_host.h
+++ b/tools/lkl/include/lkl_host.h
@@ -6,4 +6,11 @@
 
 extern struct lkl_host_operations lkl_host_ops;
 
+/**
+ * lkl_printf - print a message via the host print operation
+ *
+ * @fmt - printf like format string
+ */
+int lkl_printf(const char *fmt, ...);
+
 #endif
diff --git a/tools/lkl/lib/utils.c b/tools/lkl/lib/utils.c
new file mode 100644
index 0000000..f8b676f
--- /dev/null
+++ b/tools/lkl/lib/utils.c
@@ -0,0 +1,177 @@
+#include <stdarg.h>
+#include <stdio.h>
+#include <lkl_host.h>
+
+static const char * const lkl_err_strings[] = {
+	"Success",
+	"Operation not permitted",
+	"No such file or directory",
+	"No such process",
+	"Interrupted system call",
+	"I/O error",
+	"No such device or address",
+	"Argument list too long",
+	"Exec format error",
+	"Bad file number",
+	"No child processes",
+	"Try again",
+	"Out of memory",
+	"Permission denied",
+	"Bad address",
+	"Block device required",
+	"Device or resource busy",
+	"File exists",
+	"Cross-device link",
+	"No such device",
+	"Not a directory",
+	"Is a directory",
+	"Invalid argument",
+	"File table overflow",
+	"Too many open files",
+	"Not a typewriter",
+	"Text file busy",
+	"File too large",
+	"No space left on device",
+	"Illegal seek",
+	"Read-only file system",
+	"Too many links",
+	"Broken pipe",
+	"Math argument out of domain of func",
+	"Math result not representable",
+	"Resource deadlock would occur",
+	"File name too long",
+	"No record locks available",
+	"Invalid system call number",
+	"Directory not empty",
+	"Too many symbolic links encountered",
+	"Bad error code", /* EWOULDBLOCK is EAGAIN */
+	"No message of desired type",
+	"Identifier removed",
+	"Channel number out of range",
+	"Level 2 not synchronized",
+	"Level 3 halted",
+	"Level 3 reset",
+	"Link number out of range",
+	"Protocol driver not attached",
+	"No CSI structure available",
+	"Level 2 halted",
+	"Invalid exchange",
+	"Invalid request descriptor",
+	"Exchange full",
+	"No anode",
+	"Invalid request code",
+	"Invalid slot",
+	"Bad error code", /* EDEADLOCK is EDEADLK */
+	"Bad font file format",
+	"Device not a stream",
+	"No data available",
+	"Timer expired",
+	"Out of streams resources",
+	"Machine is not on the network",
+	"Package not installed",
+	"Object is remote",
+	"Link has been severed",
+	"Advertise error",
+	"Srmount error",
+	"Communication error on send",
+	"Protocol error",
+	"Multihop attempted",
+	"RFS specific error",
+	"Not a data message",
+	"Value too large for defined data type",
+	"Name not unique on network",
+	"File descriptor in bad state",
+	"Remote address changed",
+	"Can not access a needed shared library",
+	"Accessing a corrupted shared library",
+	".lib section in a.out corrupted",
+	"Attempting to link in too many shared libraries",
+	"Cannot exec a shared library directly",
+	"Illegal byte sequence",
+	"Interrupted system call should be restarted",
+	"Streams pipe error",
+	"Too many users",
+	"Socket operation on non-socket",
+	"Destination address required",
+	"Message too long",
+	"Protocol wrong type for socket",
+	"Protocol not available",
+	"Protocol not supported",
+	"Socket type not supported",
+	"Operation not supported on transport endpoint",
+	"Protocol family not supported",
+	"Address family not supported by protocol",
+	"Address already in use",
+	"Cannot assign requested address",
+	"Network is down",
+	"Network is unreachable",
+	"Network dropped connection because of reset",
+	"Software caused connection abort",
+	"Connection reset by peer",
+	"No buffer space available",
+	"Transport endpoint is already connected",
+	"Transport endpoint is not connected",
+	"Cannot send after transport endpoint shutdown",
+	"Too many references: cannot splice",
+	"Connection timed out",
+	"Connection refused",
+	"Host is down",
+	"No route to host",
+	"Operation already in progress",
+	"Operation now in progress",
+	"Stale file handle",
+	"Structure needs cleaning",
+	"Not a XENIX named type file",
+	"No XENIX semaphores available",
+	"Is a named type file",
+	"Remote I/O error",
+	"Quota exceeded",
+	"No medium found",
+	"Wrong medium type",
+	"Operation Canceled",
+	"Required key not available",
+	"Key has expired",
+	"Key has been revoked",
+	"Key was rejected by service",
+	"Owner died",
+	"State not recoverable",
+	"Operation not possible due to RF-kill",
+	"Memory page has hardware error",
+};
+
+const char *lkl_strerror(int err)
+{
+	if (err < 0)
+		err = -err;
+
+	if (err >= sizeof(lkl_err_strings) / sizeof(const char *))
+		return "Bad error code";
+
+	return lkl_err_strings[err];
+}
+
+int lkl_printf(const char *fmt, ...)
+{
+	char *buffer;
+	va_list args, copy;
+	int n;
+
+	va_start(args, fmt);
+	va_copy(copy, args);
+	n = vsnprintf(NULL, 0, fmt, copy);
+	va_end(copy);
+
+	buffer = lkl_host_ops.mem_alloc(n + 1);
+	if (!buffer) {
+		va_end(args);
+		return 0;
+	}
+	vsnprintf(buffer, n + 1, fmt, args);
+	va_end(args);
+
+	lkl_host_ops.print(buffer, n);
+
+	lkl_host_ops.mem_free(buffer);
+
+	return n;
+}
-- 
2.1.0

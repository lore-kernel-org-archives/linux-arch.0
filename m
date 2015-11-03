From: Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC PATCH 15/28] lkl tools: skeleton for host side library, tests and tools
Date: Tue,  3 Nov 2015 22:20:46 +0200
Message-ID: <1446582059-17355-16-git-send-email-octavian.purdila@intel.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, thehajime@gmail.com, Octavian Purdila <octavian.purdila@intel.com>
List-Id: linux-arch.vger.kernel.org

This patch adds the skeleton for the host library, tests and
application examples.

The host library is implementing the host operations needed by LKL and
is split into host dependent (depends on a specific host, e.g. POSIX
hosts) and host independent parts (will work on all supported hosts).

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 MAINTAINERS                  |  1 +
 tools/lkl/.gitignore         |  0
 tools/lkl/Makefile           | 28 ++++++++++++++++++++++++++++
 tools/lkl/include/.gitignore |  1 +
 tools/lkl/include/lkl.h      | 15 +++++++++++++++
 tools/lkl/include/lkl_host.h |  9 +++++++++
 tools/lkl/lib/.gitignore     |  3 +++
 7 files changed, 57 insertions(+)
 create mode 100644 tools/lkl/.gitignore
 create mode 100644 tools/lkl/Makefile
 create mode 100644 tools/lkl/include/.gitignore
 create mode 100644 tools/lkl/include/lkl.h
 create mode 100644 tools/lkl/include/lkl_host.h
 create mode 100644 tools/lkl/lib/.gitignore

diff --git a/MAINTAINERS b/MAINTAINERS
index e2a737f..4e78669 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6359,6 +6359,7 @@ LINUX KERNEL LIBRARY
 M:	Octavian Purdila <octavian.purdila@intel.com>
 S:	Maintained
 F:	arch/lkl/
+F:	tools/lkl/
 
 LINUX SECURITY MODULE (LSM) FRAMEWORK
 M:	Chris Wright <chrisw@sous-sol.org>
diff --git a/tools/lkl/.gitignore b/tools/lkl/.gitignore
new file mode 100644
index 0000000..e69de29
diff --git a/tools/lkl/Makefile b/tools/lkl/Makefile
new file mode 100644
index 0000000..b13472b
--- /dev/null
+++ b/tools/lkl/Makefile
@@ -0,0 +1,28 @@
+CFLAGS := -Iinclude -Wall -g
+
+ifdef CROSS_COMPILE
+CC=$(CROSS_COMPILE)gcc
+AR=$(CROSS_COMPILE)ar
+endif
+
+lib_source = $(filter-out %-host.c,$(wildcard lib/*.c))
+lib_objs = $(patsubst %.c,%.o, $(lib_source)) lib/lkl.o
+
+all: lib/liblkl.a
+
+lib/liblkl.a: $(lib_objs)
+	$(AR) -rc $@ $^
+
+lib/lkl.o:
+	$(MAKE) -C ../.. ARCH=lkl defconfig
+	$(MAKE) -C ../.. ARCH=lkl install INSTALL_PATH=$(PWD)
+
+%: %.o
+	$(CC) -o $@ $^ $(LDFLAGS)
+
+$(lib_objs): lib/lkl.o
+$(objs): lib/lkl.o
+$(execs): lib/liblkl.a
+
+clean:
+	-rm -rf include/lkl/ lib/liblkl.a $(lib_objs)
diff --git a/tools/lkl/include/.gitignore b/tools/lkl/include/.gitignore
new file mode 100644
index 0000000..c41a463
--- /dev/null
+++ b/tools/lkl/include/.gitignore
@@ -0,0 +1 @@
+lkl/
\ No newline at end of file
diff --git a/tools/lkl/include/lkl.h b/tools/lkl/include/lkl.h
new file mode 100644
index 0000000..2de5ed4
--- /dev/null
+++ b/tools/lkl/include/lkl.h
@@ -0,0 +1,15 @@
+#ifndef _LKL_H
+#define _LKL_H
+
+#include <lkl/asm/unistd.h>
+
+/**
+ * lkl_sys_lseek - wrapper for lkl_sys_llseek
+ */
+static inline long lkl_sys_lseek(unsigned int fd, __lkl__kernel_loff_t off,
+				 __lkl__kernel_loff_t *res, unsigned int whence)
+{
+	return lkl_sys_llseek(fd, off >> 32, off & 0xffffffff, res, whence);
+}
+
+#endif
diff --git a/tools/lkl/include/lkl_host.h b/tools/lkl/include/lkl_host.h
new file mode 100644
index 0000000..8ee9ba0
--- /dev/null
+++ b/tools/lkl/include/lkl_host.h
@@ -0,0 +1,9 @@
+#ifndef _LKL_HOST_H
+#define _LKL_HOST_H
+
+#include <lkl/asm/host_ops.h>
+#include <lkl.h>
+
+extern struct lkl_host_operations lkl_host_ops;
+
+#endif
diff --git a/tools/lkl/lib/.gitignore b/tools/lkl/lib/.gitignore
new file mode 100644
index 0000000..427ae02
--- /dev/null
+++ b/tools/lkl/lib/.gitignore
@@ -0,0 +1,3 @@
+lkl.o
+liblkl.a
+
-- 
2.1.0

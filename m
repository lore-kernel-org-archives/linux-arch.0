From: Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC PATCH 28/28] lkl tools: add support for Windows host
Date: Tue,  3 Nov 2015 22:20:59 +0200
Message-ID: <1446582059-17355-29-git-send-email-octavian.purdila@intel.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:34871 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965038AbbKCUXa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 3 Nov 2015 15:23:30 -0500
In-Reply-To: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, thehajime@gmail.com, Octavian Purdila <octavian.purdila@intel.com>

Add host operations for Windows host and virtio disk support.

Trivial changes to the generic virtio host code are made since mingw %p
format is different then what the MMIO virtion driver expects.

The boot test is updated to support Window hosts as well.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 tools/lkl/Makefile      |   5 +-
 tools/lkl/include/lkl.h |   5 +-
 tools/lkl/lib/nt-host.c | 227 ++++++++++++++++++++++++++++++++++++++++++++++++
 tools/lkl/lib/virtio.c  |   4 +-
 tools/lkl/lib/virtio.h  |   8 ++
 tools/lkl/tests/boot.c  |  26 ++++++
 6 files changed, 270 insertions(+), 5 deletions(-)
 create mode 100644 tools/lkl/lib/nt-host.c

diff --git a/tools/lkl/Makefile b/tools/lkl/Makefile
index 4084609..d3d0e0b 100644
--- a/tools/lkl/Makefile
+++ b/tools/lkl/Makefile
@@ -14,6 +14,9 @@ lib_source += lib/posix-host.c
 LDFLAGS += -lpthread -lrt
 source += $(wildcard *.c)
 execs =  cpfromfs
+else ifeq ($(shell $(LD) -r -print-output-format),pe-i386)
+lib_source += lib/nt-host.c
+KOPT="KALLSYMS_EXTRA_PASS=1"
 endif
 
 lib_objs = $(patsubst %.c,%.o, $(lib_source)) lib/lkl.o
@@ -27,7 +30,7 @@ lib/liblkl.a: $(lib_objs)
 
 lib/lkl.o:
 	$(MAKE) -C ../.. ARCH=lkl defconfig
-	$(MAKE) -C ../.. ARCH=lkl install INSTALL_PATH=$(PWD)
+	$(MAKE) -C ../.. ARCH=lkl $(KOPT) install INSTALL_PATH=$(PWD)
 
 %: %.o
 	$(CC) -o $@ $^ $(LDFLAGS)
diff --git a/tools/lkl/include/lkl.h b/tools/lkl/include/lkl.h
index e6a9c77..aebd635 100644
--- a/tools/lkl/include/lkl.h
+++ b/tools/lkl/include/lkl.h
@@ -23,11 +23,12 @@ const char *lkl_strerror(int err);
 /**
  * lkl_disk_backstore - host dependend disk backstore
  *
- * @fd - an open file descriptor that can be used by preadv/pwritev; used by
- * POSIX hosts
+ * @fd - a POSIX file descriptor that can be used by preadv/pwritev
+ * @handle - an NT file handle that can be used by ReadFile/WriteFile
  */
 union lkl_disk_backstore {
 	int fd;
+	void *handle;
 };
 
 /**
diff --git a/tools/lkl/lib/nt-host.c b/tools/lkl/lib/nt-host.c
new file mode 100644
index 0000000..9ac2dd7
--- /dev/null
+++ b/tools/lkl/lib/nt-host.c
@@ -0,0 +1,227 @@
+#include <windows.h>
+#include <assert.h>
+#include <unistd.h>
+#include <lkl_host.h>
+#include "iomem.h"
+
+static void *sem_alloc(int count)
+{
+	return CreateSemaphore(NULL, count, 100, NULL);
+}
+
+static void sem_up(void *sem)
+{
+	ReleaseSemaphore(sem, 1, NULL);
+}
+
+static void sem_down(void *sem)
+{
+	WaitForSingleObject(sem, INFINITE);
+}
+
+static void sem_free(void *sem)
+{
+	CloseHandle(sem);
+}
+
+static int thread_create(void (*fn)(void *), void *arg)
+{
+	DWORD WINAPI (*win_fn)(LPVOID arg) = (DWORD WINAPI (*)(LPVOID))fn;
+
+	return CreateThread(NULL, 0, win_fn, arg, 0, NULL) ? 0 : -1;
+}
+
+static void thread_exit(void)
+{
+	ExitThread(0);
+}
+
+
+/*
+ * With 64 bits, we can cover about 583 years at a nanosecond resolution.
+ * Windows counts time from 1601 so we do have about 100 years before we
+ * overflow.
+ */
+static unsigned long long time_ns(void)
+{
+	SYSTEMTIME st;
+	FILETIME ft;
+	LARGE_INTEGER li;
+
+	GetSystemTime(&st);
+	SystemTimeToFileTime(&st, &ft);
+	li.LowPart = ft.dwLowDateTime;
+	li.HighPart = ft.dwHighDateTime;
+
+	return li.QuadPart*100;
+}
+
+struct timer {
+	HANDLE queue;
+	void (*callback)(void *);
+	void *arg;
+};
+
+static void *timer_alloc(void (*fn)(void *), void *arg)
+{
+	struct timer *t;
+
+	t = malloc(sizeof(*t));
+	if (!t)
+		return NULL;
+
+	t->queue = CreateTimerQueue();
+	if (!t->queue) {
+		free(t);
+		return NULL;
+	}
+
+	t->callback = fn;
+	t->arg = arg;
+
+	return t;
+}
+
+static void CALLBACK timer_callback(void *arg, BOOLEAN TimerOrWaitFired)
+{
+	struct timer *t = (struct timer *)arg;
+
+	if (TimerOrWaitFired)
+		t->callback(t->arg);
+}
+
+static int timer_set_oneshot(void *timer, unsigned long ns)
+{
+	struct timer *t = (struct timer *)timer;
+	HANDLE tmp;
+
+	return !CreateTimerQueueTimer(&tmp, t->queue, timer_callback, t,
+				      ns / 1000000, 0, 0);
+}
+
+static void timer_free(void *timer)
+{
+	struct timer *t = (struct timer *)timer;
+	HANDLE completion;
+
+	completion = CreateEvent(NULL, FALSE, FALSE, NULL);
+	DeleteTimerQueueEx(t->queue, completion);
+	WaitForSingleObject(completion, INFINITE);
+	free(t);
+}
+
+static void panic(void)
+{
+	int *x = NULL;
+
+	*x = 1;
+	assert(0);
+}
+
+static void print(const char *str, int len)
+{
+	write(1, str, len);
+}
+
+static void *mem_alloc(unsigned long size)
+{
+	return malloc(size);
+}
+
+struct lkl_host_operations lkl_host_ops = {
+	.panic = panic,
+	.thread_create = thread_create,
+	.thread_exit = thread_exit,
+	.sem_alloc = sem_alloc,
+	.sem_free = sem_free,
+	.sem_up = sem_up,
+	.sem_down = sem_down,
+	.time = time_ns,
+	.timer_alloc = timer_alloc,
+	.timer_set_oneshot = timer_set_oneshot,
+	.timer_free = timer_free,
+	.print = print,
+	.mem_alloc = mem_alloc,
+	.mem_free = free,
+	.ioremap = lkl_ioremap,
+	.iomem_access = lkl_iomem_access,
+	.virtio_devices = lkl_virtio_devs,
+};
+
+int handle_get_capacity(union lkl_disk_backstore bs, unsigned long long *res)
+{
+	LARGE_INTEGER tmp;
+
+	if (!GetFileSizeEx(bs.handle, &tmp))
+		return -1;
+
+	*res = tmp.QuadPart;
+	return 0;
+}
+
+void handle_do_rw(union lkl_disk_backstore bs, unsigned int type,
+		  unsigned int prio, unsigned long long sector,
+		  struct lkl_dev_buf *bufs, int count)
+{
+	unsigned long long offset = sector * 512;
+	OVERLAPPED ov = { 0, };
+	int err = 0, ret;
+
+	switch (type) {
+	case LKL_DEV_BLK_TYPE_READ:
+	case LKL_DEV_BLK_TYPE_WRITE:
+	{
+		int i;
+
+		for (i = 0; i < count; i++) {
+			DWORD res;
+
+			ov.Offset = offset & 0xffffffff;
+			ov.OffsetHigh = offset >> 32;
+
+			if (type == LKL_DEV_BLK_TYPE_READ)
+				ret = ReadFile(bs.handle, bufs[i].addr,
+					       bufs[i].len, &res, &ov);
+			else
+				ret = WriteFile(bs.handle, bufs[i].addr,
+						bufs[i].len, &res, &ov);
+			if (!ret) {
+				lkl_printf("%s: I/O error: %d\n", __func__,
+					   GetLastError());
+				err = -1;
+				goto out;
+			}
+
+			if (res != bufs[i].len) {
+				lkl_printf("%s: I/O error: short: %d %d\n",
+					   res, bufs[i].len);
+				err = -1;
+				goto out;
+			}
+
+			offset += bufs[i].len;
+		}
+		break;
+	}
+	case LKL_DEV_BLK_TYPE_FLUSH:
+	case LKL_DEV_BLK_TYPE_FLUSH_OUT:
+		ret = FlushFileBuffers(bs.handle);
+		if (!ret)
+			err = 1;
+		break;
+	default:
+		lkl_dev_blk_complete(bufs, LKL_DEV_BLK_STATUS_UNSUP, 0);
+		return;
+	}
+
+out:
+	if (err < 0)
+		lkl_dev_blk_complete(bufs, LKL_DEV_BLK_STATUS_IOERR, 0);
+	else
+		lkl_dev_blk_complete(bufs, LKL_DEV_BLK_STATUS_OK, err);
+}
+
+struct lkl_dev_blk_ops lkl_dev_blk_ops = {
+	.get_capacity = handle_get_capacity,
+	.request = handle_do_rw,
+};
diff --git a/tools/lkl/lib/virtio.c b/tools/lkl/lib/virtio.c
index 034152e..17522b2 100644
--- a/tools/lkl/lib/virtio.c
+++ b/tools/lkl/lib/virtio.c
@@ -350,8 +350,8 @@ int virtio_dev_setup(struct virtio_dev *dev, int queues, int num_max)
 		lkl_host_ops.mem_free(dev->queue);
 
 	avail = sizeof(lkl_virtio_devs) - (devs - lkl_virtio_devs);
-	devs += snprintf(devs, avail, " virtio_mmio.device=%d@%p:%d",
-			 mmio_size, dev, dev->irq);
+	devs += snprintf(devs, avail, " virtio_mmio.device=%d@0x%lx:%d",
+			 mmio_size, (uintptr_t)dev, dev->irq);
 
 	return ret;
 }
diff --git a/tools/lkl/lib/virtio.h b/tools/lkl/lib/virtio.h
index 1bacbe6..b76b18b 100644
--- a/tools/lkl/lib/virtio.h
+++ b/tools/lkl/lib/virtio.h
@@ -81,6 +81,14 @@ void virtio_dev_complete(struct virtio_dev_req *req, uint32_t len);
 #define container_of(ptr, type, member) \
 	(type *)((char *)(ptr) - __builtin_offsetof(type, member))
 
+#ifndef __MINGW32__
 #include <endian.h>
+#else
+#define le32toh(x) (x)
+#define le16toh(x) (x)
+#define htole32(x) (x)
+#define htole16(x) (x)
+#define le64toh(x) (x)
+#endif
 
 #endif /* _LKL_LIB_VIRTIO_H */
diff --git a/tools/lkl/tests/boot.c b/tools/lkl/tests/boot.c
index f5945aa..8b401b7 100644
--- a/tools/lkl/tests/boot.c
+++ b/tools/lkl/tests/boot.c
@@ -4,10 +4,17 @@
 #include <time.h>
 #include <stdlib.h>
 #include <stdint.h>
+#ifndef __MINGW32__
+#include <argp.h>
+#endif
 #include <lkl.h>
 #include <lkl_host.h>
+#ifndef __MINGW32__
 #include <sys/stat.h>
 #include <fcntl.h>
+#else
+#include <windows.h>
+#endif
 
 static struct cl_args {
 	int printk;
@@ -60,6 +67,7 @@ static void do_test(char *name, int (*fn)(char *, int))
 
 #define sleep_ns 87654321
 
+#ifndef __MINGW32__
 int test_nanosleep(char *str, int len)
 {
 	struct lkl_timespec ts = {
@@ -84,6 +92,7 @@ int test_nanosleep(char *str, int len)
 
 	return 0;
 }
+#endif
 
 int test_getpid(char *str, int len)
 {
@@ -270,8 +279,14 @@ static int disk_id = -1;
 
 int test_disk_add(char *str, int len)
 {
+#ifdef __MINGW32__
+	bs.handle = CreateFile(cla.disk_filename, GENERIC_READ | GENERIC_WRITE,
+			       0, NULL, OPEN_EXISTING, 0, NULL);
+	if (!bs.handle)
+#else
 	bs.fd = open(cla.disk_filename, O_RDWR);
 	if (bs.fd < 0)
+#endif
 		goto out_unlink;
 
 	disk_id = lkl_disk_add(bs);
@@ -281,9 +296,18 @@ int test_disk_add(char *str, int len)
 	goto out;
 
 out_close:
+#ifdef __MINGW32__
+	CloseHandle(bs.handle);
+#else
 	close(bs.fd);
+#endif
+
 out_unlink:
+#ifdef __MINGW32__
+	DeleteFile(cla.disk_filename);
+#else
 	unlink(cla.disk_filename);
+#endif
 
 out:
 	snprintf(str, len, "%x %d", bs.fd, disk_id);
@@ -472,7 +496,9 @@ int main(int argc, char **argv)
 	TEST(fstat64);
 	TEST(mkdir);
 	TEST(stat64);
+#ifndef __MINGW32__
 	TEST(nanosleep);
+#endif
 	TEST(mount);
 	TEST(chdir);
 	TEST(opendir);
-- 
2.1.0

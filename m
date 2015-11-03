From: Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC PATCH 21/28] lkl tools: host lib: posix host operations
Date: Tue,  3 Nov 2015 22:20:52 +0200
Message-ID: <1446582059-17355-22-git-send-email-octavian.purdila@intel.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, thehajime@gmail.com, Octavian Purdila <octavian.purdila@intel.com>
List-Id: linux-arch.vger.kernel.org

Implement LKL host operations for POSIX hosts.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 tools/lkl/Makefile         |   6 ++
 tools/lkl/lib/posix-host.c | 206 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 212 insertions(+)
 create mode 100644 tools/lkl/lib/posix-host.c

diff --git a/tools/lkl/Makefile b/tools/lkl/Makefile
index b13472b..cf97d27 100644
--- a/tools/lkl/Makefile
+++ b/tools/lkl/Makefile
@@ -3,9 +3,15 @@ CFLAGS := -Iinclude -Wall -g
 ifdef CROSS_COMPILE
 CC=$(CROSS_COMPILE)gcc
 AR=$(CROSS_COMPILE)ar
+LD=$(CROSS_COMPILE)ld
 endif
 
 lib_source = $(filter-out %-host.c,$(wildcard lib/*.c))
+ifneq (,$(filter $(shell $(LD) -r -print-output-format),elf64-x86-64 elf32-i386))
+lib_source += lib/posix-host.c
+LDFLAGS += -lpthread -lrt
+endif
+
 lib_objs = $(patsubst %.c,%.o, $(lib_source)) lib/lkl.o
 
 all: lib/liblkl.a
diff --git a/tools/lkl/lib/posix-host.c b/tools/lkl/lib/posix-host.c
new file mode 100644
index 0000000..4bc1de7
--- /dev/null
+++ b/tools/lkl/lib/posix-host.c
@@ -0,0 +1,206 @@
+#include <pthread.h>
+#include <malloc.h>
+#include <sys/time.h>
+#include <time.h>
+#include <signal.h>
+#include <assert.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+#include <time.h>
+#include <execinfo.h>
+#include <stdint.h>
+#include <sys/uio.h>
+#include <lkl_host.h>
+#include "iomem.h"
+
+static void print(const char *str, int len)
+{
+	write(STDOUT_FILENO, str, len);
+}
+
+struct pthread_sem {
+	pthread_mutex_t lock;
+	int count;
+	pthread_cond_t cond;
+};
+
+static void *sem_alloc(int count)
+{
+	struct pthread_sem *sem;
+
+	sem = malloc(sizeof(*sem));
+	if (!sem)
+		return NULL;
+
+	pthread_mutex_init(&sem->lock, NULL);
+	sem->count = count;
+	pthread_cond_init(&sem->cond, NULL);
+
+	return sem;
+}
+
+static void sem_free(void *sem)
+{
+	free(sem);
+}
+
+static void sem_up(void *_sem)
+{
+	struct pthread_sem *sem = (struct pthread_sem *)_sem;
+
+	pthread_mutex_lock(&sem->lock);
+	sem->count++;
+	if (sem->count > 0)
+		pthread_cond_signal(&sem->cond);
+	pthread_mutex_unlock(&sem->lock);
+}
+
+static void sem_down(void *_sem)
+{
+	struct pthread_sem *sem = (struct pthread_sem *)_sem;
+
+	pthread_mutex_lock(&sem->lock);
+	while (sem->count <= 0)
+		pthread_cond_wait(&sem->cond, &sem->lock);
+	sem->count--;
+	pthread_mutex_unlock(&sem->lock);
+}
+
+static int thread_create(void (*fn)(void *), void *arg)
+{
+	pthread_t thread;
+
+	return pthread_create(&thread, NULL, (void* (*)(void *))fn, arg);
+}
+
+static void thread_exit(void)
+{
+	pthread_exit(NULL);
+}
+
+static unsigned long long time_ns(void)
+{
+	struct timeval tv;
+
+	gettimeofday(&tv, NULL);
+
+	return tv.tv_sec * 1000000000ULL + tv.tv_usec * 1000ULL;
+}
+
+static void *timer_alloc(void (*fn)(void *), void *arg)
+{
+	int err;
+	timer_t timer;
+	struct sigevent se =  {
+		.sigev_notify = SIGEV_THREAD,
+		.sigev_value = {
+			.sival_ptr = arg,
+		},
+		.sigev_notify_function = (void (*)(union sigval))fn,
+	};
+
+	err = timer_create(CLOCK_REALTIME, &se, &timer);
+	if (err)
+		return NULL;
+
+	return (void *)(long)timer;
+}
+
+static int timer_set_oneshot(void *_timer, unsigned long ns)
+{
+	timer_t timer = (timer_t)(long)_timer;
+	struct itimerspec ts = {
+		.it_value = {
+			.tv_sec = ns / 1000000000,
+			.tv_nsec = ns % 1000000000,
+		},
+	};
+
+	if (!ts.it_value.tv_nsec)
+		ts.it_value.tv_nsec++;
+
+	return timer_settime(timer, 0, &ts, NULL);
+}
+
+static void timer_free(void *_timer)
+{
+	timer_t timer = (timer_t)(long)_timer;
+
+	timer_delete(timer);
+}
+
+static void panic(void)
+{
+	assert(0);
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
+	.mem_alloc = malloc,
+	.mem_free = free,
+	.ioremap = lkl_ioremap,
+	.iomem_access = lkl_iomem_access,
+	.virtio_devices = lkl_virtio_devs,
+};
+
+int fd_get_capacity(union lkl_disk_backstore bs, unsigned long long *res)
+{
+	off_t off;
+
+	off = lseek(bs.fd, 0, SEEK_END);
+	if (off < 0)
+		return -1;
+
+	*res = off;
+	return 0;
+}
+
+void fd_do_rw(union lkl_disk_backstore bs, unsigned int type, unsigned int prio,
+	      unsigned long long sector, struct lkl_dev_buf *bufs, int count)
+{
+	int err = 0;
+	struct iovec *iovec = (struct iovec *)bufs;
+
+	if (count > 1)
+		lkl_printf("%s: %d\n", __func__, count);
+
+	/* TODO: handle short reads/writes */
+	switch (type) {
+	case LKL_DEV_BLK_TYPE_READ:
+		err = preadv(bs.fd, iovec, count, sector * 512);
+		break;
+	case LKL_DEV_BLK_TYPE_WRITE:
+		err = pwritev(bs.fd, iovec, count, sector * 512);
+		break;
+	case LKL_DEV_BLK_TYPE_FLUSH:
+	case LKL_DEV_BLK_TYPE_FLUSH_OUT:
+		err = fdatasync(bs.fd);
+		break;
+	default:
+		lkl_dev_blk_complete(bufs, LKL_DEV_BLK_STATUS_UNSUP, 0);
+		return;
+	}
+
+	if (err < 0)
+		lkl_dev_blk_complete(bufs, LKL_DEV_BLK_STATUS_IOERR, 0);
+	else
+		lkl_dev_blk_complete(bufs, LKL_DEV_BLK_STATUS_OK, err);
+}
+
+struct lkl_dev_blk_ops lkl_dev_blk_ops = {
+	.get_capacity = fd_get_capacity,
+	.request = fd_do_rw,
+};
-- 
2.1.0

From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v3 24/26] um lkl: add UML network driver for lkl
Date: Wed,  5 Feb 2020 16:30:33 +0900
Message-ID: <5caf8fee4ed563f2fc074d9a1f2bc43d7d1492bd.1580882335.git.thehajime@gmail.com>
References: <cover.1580882335.git.thehajime@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f179.google.com ([209.85.215.179]:33690 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgBEHbr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 02:31:47 -0500
Received: by mail-pg1-f179.google.com with SMTP id 6so541357pgk.0
        for <linux-arch@vger.kernel.org>; Tue, 04 Feb 2020 23:31:46 -0800 (PST)
In-Reply-To: <cover.1580882335.git.thehajime@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-um@lists.infradead.org
Cc: Octavian Purdila <tavi.purdila@gmail.com>, Akira Moroo <retrage01@gmail.com>, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, Hajime Tazaki <thehajime@gmail.com>

This commit adds the use of the UML drivers of network interfaces which
should be able to use any backend configured by boot command line
parameters.  Currently slirp and tuntap backends are tested.

Since the UML drivers use LKL irq infrastructure, the build system only
picks required object files of UML, and LKL adds trivial glue code and
ifdefs into UML code so that existing driver codes can be used for LKL
as-is.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 .circleci/config.yml                    |  2 ++
 arch/um/drivers/Makefile                |  2 ++
 arch/um/kernel/Makefile                 |  4 +++
 arch/um/kernel/irq.c                    |  4 +++
 arch/um/lkl/Kconfig                     |  2 ++
 arch/um/lkl/Makefile                    |  2 ++
 arch/um/lkl/include/uapi/asm/host_ops.h |  6 +++++
 arch/um/lkl/kernel/asm-offsets.c        |  1 +
 arch/um/lkl/kernel/irq.c                | 16 ++++++++++++
 arch/um/lkl/kernel/setup.c              |  4 +++
 arch/um/lkl/mm/bootmem.c                | 33 +++++++++++++++++++++++++
 arch/um/os-Linux/Makefile               |  5 ++++
 arch/um/os-Linux/file.c                 |  9 +++++++
 tools/lkl/Makefile.autoconf             |  2 ++
 tools/lkl/include/lkl.h                 |  9 +++++++
 tools/lkl/include/lkl_host.h            |  1 +
 tools/lkl/lib/Build                     |  1 +
 tools/lkl/lib/config.c                  |  6 +++++
 tools/lkl/lib/posix-host.c              |  3 +++
 tools/lkl/lib/um/Build                  |  2 ++
 tools/lkl/lib/um/um_glue.c              | 33 +++++++++++++++++++++++++
 tools/lkl/lib/um/um_net.c               | 25 +++++++++++++++++++
 tools/lkl/tests/net-setup.sh            |  1 +
 tools/lkl/tests/net-test.c              | 14 +++++++----
 tools/lkl/tests/net.sh                  | 18 ++++++++++++++
 tools/lkl/tests/run.py                  |  1 +
 26 files changed, 201 insertions(+), 5 deletions(-)
 create mode 100644 tools/lkl/lib/um/Build
 create mode 100644 tools/lkl/lib/um/um_glue.c
 create mode 100644 tools/lkl/lib/um/um_net.c

diff --git a/.circleci/config.yml b/.circleci/config.yml
index 5bdf059014c0..df1554078a4b 100644
--- a/.circleci/config.yml
+++ b/.circleci/config.yml
@@ -43,6 +43,8 @@ do_steps: &do_steps
   - run:
       name: run tests
       command: |
+        sudo apt-get update
+        sudo apt-get install -y slirp
         mkdir -p ~/junit
         make -C tools/lkl run-tests tests="--junit-dir ~/junit"
       no_output_timeout: "90m"
diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index a290821e355c..3cce6c81079e 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -37,7 +37,9 @@ $(obj)/vde.o: $(obj)/vde_kern.o $(obj)/vde_user.o
 # When the above is fixed, don't forget to add this too!
 #targets += $(obj)/pcap.o
 
+ifeq ($(UMMODE),kernel)
 obj-y := stdio_console.o fd.o chan_kern.o chan_user.o line.o
+endif
 obj-$(CONFIG_SSL) += ssl.o
 obj-$(CONFIG_STDERR_CONSOLE) += stderr_console.o
 
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 5aa882011e04..78b49eb9bf81 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -12,12 +12,16 @@ CPPFLAGS_vmlinux.lds := -DSTART=$(LDS_START)		\
                         -DELF_ARCH=$(LDS_ELF_ARCH)	\
                         -DELF_FORMAT=$(LDS_ELF_FORMAT)	\
 			$(LDS_EXTRA)
+ifeq ($(UMMODE),kernel)
 extra-y := vmlinux.lds
 
 obj-y = config.o exec.o exitcode.o irq.o ksyms.o mem.o \
 	physmem.o process.o ptrace.o reboot.o sigio.o \
 	signal.o syscall.o sysrq.o time.o tlb.o trap.o \
 	um_arch.o umid.o maccess.o kmsg_dump.o skas/
+else ifeq ($(UMMODE),library)
+obj-y = irq.o
+endif
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 3577118bb4a5..580a889c2277 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -406,6 +406,7 @@ int deactivate_all_fds(void)
 	return 0;
 }
 
+#ifdef CONFIG_UMMODE_KERN
 /*
  * do_IRQ handles all normal device IRQs (the special
  * SMP cross-CPU interrupts have their own specific
@@ -420,6 +421,7 @@ unsigned int do_IRQ(int irq, struct uml_pt_regs *regs)
 	set_irq_regs(old_regs);
 	return 1;
 }
+#endif /* !CONFIG_UMMODE_KERN */
 
 void um_free_irq(unsigned int irq, void *dev)
 {
@@ -446,6 +448,7 @@ int um_request_irq(unsigned int irq, int fd, int type,
 
 EXPORT_SYMBOL(um_request_irq);
 
+#ifdef CONFIG_UMMODE_KERN
 /*
  * irq_chip must define at least enable/disable and ack when
  * the edge handler is used.
@@ -597,3 +600,4 @@ unsigned long from_irq_stack(int nested)
 	return mask & ~1;
 }
 
+#endif /* !CONFIG_UMMODE_KERN */
diff --git a/arch/um/lkl/Kconfig b/arch/um/lkl/Kconfig
index f72b423fad5b..3568f33d5ccf 100644
--- a/arch/um/lkl/Kconfig
+++ b/arch/um/lkl/Kconfig
@@ -81,3 +81,5 @@ config HZ
         default 100
 
 endmenu
+
+source "arch/um/drivers/Kconfig"
diff --git a/arch/um/lkl/Makefile b/arch/um/lkl/Makefile
index e1161fa3fb63..17ff6d00d1db 100644
--- a/arch/um/lkl/Makefile
+++ b/arch/um/lkl/Makefile
@@ -4,6 +4,8 @@ include $(LKL_DIR)/auto.conf
 
 # fixup CFLAGS of um build
 KBUILD_CFLAGS := $(subst $(CFLAGS),,$(KBUILD_CFLAGS))
+# XXX
+KBUILD_CFLAGS	+= -DTIMER_IRQ=0 -DUM_ETH_IRQ=5 -DLAST_IRQ=15
 
 SRCARCH := um/lkl
 ARCH_INCLUDE += -I$(srctree)/$(LKL_DIR)/um/include
diff --git a/arch/um/lkl/include/uapi/asm/host_ops.h b/arch/um/lkl/include/uapi/asm/host_ops.h
index fe4382c3050a..0230885f4f64 100644
--- a/arch/um/lkl/include/uapi/asm/host_ops.h
+++ b/arch/um/lkl/include/uapi/asm/host_ops.h
@@ -17,6 +17,10 @@ struct lkl_jmp_buf {
  * These operations must be provided by a host library or by the application
  * itself.
  *
+ * @um_devices - string containg the list of UML devices in command line
+ * format. This string is appended to the kernel command line and
+ * is provided here for convenience to be implemented by the host library.
+ *
  * @print - optional operation that receives console messages
  *
  * @panic - called during a kernel panic
@@ -74,6 +78,8 @@ struct lkl_jmp_buf {
  * @jmp_buf_longjmp - perform a jump back to the saved jump buffer
  */
 struct lkl_host_operations {
+	const char *um_devices;
+
 	void (*print)(const char *str, int len);
 	void (*panic)(void);
 
diff --git a/arch/um/lkl/kernel/asm-offsets.c b/arch/um/lkl/kernel/asm-offsets.c
index 6be0763698dc..6fdca6df21a2 100644
--- a/arch/um/lkl/kernel/asm-offsets.c
+++ b/arch/um/lkl/kernel/asm-offsets.c
@@ -1,2 +1,3 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Dummy asm-offsets.c file. Required by kbuild and ready to be used - hint! */
+#include <sysdep/kernel-offsets.h>
diff --git a/arch/um/lkl/kernel/irq.c b/arch/um/lkl/kernel/irq.c
index e3b59e46ca50..7de65b8f699d 100644
--- a/arch/um/lkl/kernel/irq.c
+++ b/arch/um/lkl/kernel/irq.c
@@ -11,6 +11,10 @@
 #include <asm/host_ops.h>
 #include <asm/cpu.h>
 
+#if defined(__linux) && (defined(__i386) || defined(__x86_64))
+#include <os.h>
+#endif
+
 /*
  * To avoid much overhead we use an indirect approach: the irqs are marked using
  * a bitmap (array of longs) and a summary of the modified bits is kept in a
@@ -184,6 +188,10 @@ void init_IRQ(void)
 	for (i = 0; i < NR_IRQS; i++)
 		irq_set_chip_and_handler(i, &dummy_irq_chip, handle_simple_irq);
 
+#if defined(__linux) && (defined(__i386) || defined(__x86_64))
+	/* Initialize EPOLL Loop */
+	os_setup_epoll();
+#endif
 	pr_info("lkl: irqs initialized\n");
 }
 
@@ -191,3 +199,11 @@ void cpu_yield_to_irqs(void)
 {
 	cpu_relax();
 }
+
+#if defined(__linux) && (defined(__i386) || defined(__x86_64))
+unsigned int do_IRQ(int irq, struct uml_pt_regs *regs)
+{
+	lkl_trigger_irq(irq);
+	return 1;
+}
+#endif
diff --git a/arch/um/lkl/kernel/setup.c b/arch/um/lkl/kernel/setup.c
index 36c199d3aa22..39b7b7c79581 100644
--- a/arch/um/lkl/kernel/setup.c
+++ b/arch/um/lkl/kernel/setup.c
@@ -61,6 +61,10 @@ int __init lkl_start_kernel(struct lkl_host_operations *ops, const char *fmt,
 	ret = vsnprintf(boot_command_line, COMMAND_LINE_SIZE, fmt, ap);
 	va_end(ap);
 
+	if (ops->um_devices)
+		strscpy(boot_command_line + ret, ops->um_devices,
+			COMMAND_LINE_SIZE - ret);
+
 	memcpy(cmd_line, boot_command_line, COMMAND_LINE_SIZE);
 
 	init_sem = lkl_ops->sem_alloc(0);
diff --git a/arch/um/lkl/mm/bootmem.c b/arch/um/lkl/mm/bootmem.c
index 39dd0d22b44e..3175dadee13f 100644
--- a/arch/um/lkl/mm/bootmem.c
+++ b/arch/um/lkl/mm/bootmem.c
@@ -64,3 +64,36 @@ void free_mem(void)
 {
 	lkl_ops->mem_free((void *)_memory_start);
 }
+
+void *uml_kmalloc(int size, int flags)
+{
+	return kmalloc(size, flags);
+}
+
+char *uml_strdup(const char *string)
+{
+	return kstrdup(string, GFP_KERNEL);
+}
+
+void free_stack(unsigned long stack, int order)
+{
+	free_pages(stack, order);
+}
+
+unsigned long alloc_stack(int order, int atomic)
+{
+	unsigned long page;
+	gfp_t flags = GFP_KERNEL;
+
+	if (atomic)
+		flags = GFP_ATOMIC;
+	page = __get_free_pages(flags, order);
+
+	return page;
+}
+
+int __cant_sleep(void)
+{
+	return in_atomic() || irqs_disabled() || in_interrupt();
+	/* Is in_interrupt() really needed? */
+}
diff --git a/arch/um/os-Linux/Makefile b/arch/um/os-Linux/Makefile
index 839915b8c31c..a74a2486e178 100644
--- a/arch/um/os-Linux/Makefile
+++ b/arch/um/os-Linux/Makefile
@@ -6,9 +6,14 @@
 # Don't instrument UML-specific code
 KCOV_INSTRUMENT                := n
 
+ifeq ($(UMMODE),kernel)
 obj-y = execvp.o file.o helper.o irq.o main.o mem.o process.o \
 	registers.o sigio.o signal.o start_up.o time.o tty.o \
 	umid.o user_syms.o util.o drivers/ skas/
+else
+obj-y = execvp.o file.o helper.o irq.o drivers/
+endif
+
 
 obj-$(CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA) += elf_aux.o
 
diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
index 5133e3afb96f..6656a2ec418a 100644
--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -397,6 +397,14 @@ int os_pipe(int *fds, int stream, int close_on_exec)
 	return err;
 }
 
+static void sig_handler(int sig)
+{
+	if (sig != SIGIO)
+		return;
+
+	sigio_handler(sig, NULL, NULL);
+}
+
 int os_set_fd_async(int fd)
 {
 	int err, flags;
@@ -413,6 +421,7 @@ int os_set_fd_async(int fd)
 		return err;
 	}
 
+	signal(SIGIO, sig_handler);
 	if ((fcntl(fd, F_SETSIG, SIGIO) < 0) ||
 	    (fcntl(fd, F_SETOWN, os_getpid()) < 0)) {
 		err = -errno;
diff --git a/tools/lkl/Makefile.autoconf b/tools/lkl/Makefile.autoconf
index 268c367d9962..d2dcaa3b85f2 100644
--- a/tools/lkl/Makefile.autoconf
+++ b/tools/lkl/Makefile.autoconf
@@ -41,6 +41,8 @@ define posix_host
   $(if $(strip $(call find_include,archive.h)),$(call set_autoconf_var,ARCHIVE,y))
   $(if $(filter $(1),elf64-x86-64-freebsd),$(call set_autoconf_var,NEEDS_LARGP,y))
   $(if $(filter $(1),elf32-i386),$(call set_autoconf_var,I386,y))
+  $(if $(filter $(1),elf64-x86-64),$(call set_autoconf_var,UML_DEV,y))
+  $(if $(filter $(1),elf32-i386),$(call set_autoconf_var,UML_DEV,y))
 endef
 
 define do_autoconf
diff --git a/tools/lkl/include/lkl.h b/tools/lkl/include/lkl.h
index 1f4291ad9455..952d11e30868 100644
--- a/tools/lkl/include/lkl.h
+++ b/tools/lkl/include/lkl.h
@@ -731,6 +731,15 @@ struct lkl_netdev_args {
 	unsigned int offload;
 };
 
+#ifdef LKL_HOST_CONFIG_UML_DEV
+struct lkl_netdev *lkl_um_netdev_create(const char *ifparams);
+#else
+static inline struct lkl_netdev *lkl_um_netdev_create(const char *ifparams)
+{
+	return NULL;
+}
+#endif
+
 /*
  * lkl_register_dbg_handler- register a signal handler that loads a debug lib.
  *
diff --git a/tools/lkl/include/lkl_host.h b/tools/lkl/include/lkl_host.h
index 4e6d6e031498..7ac30bdcaf0a 100644
--- a/tools/lkl/include/lkl_host.h
+++ b/tools/lkl/include/lkl_host.h
@@ -10,6 +10,7 @@ extern "C" {
 #include <lkl.h>
 
 extern struct lkl_host_operations lkl_host_ops;
+extern char lkl_um_devs[4096];
 
 /**
  * lkl_printf - print a message via the host print operation
diff --git a/tools/lkl/lib/Build b/tools/lkl/lib/Build
index 0e711e260a3a..ad8a4b806375 100644
--- a/tools/lkl/lib/Build
+++ b/tools/lkl/lib/Build
@@ -10,3 +10,4 @@ liblkl-y += dbg.o
 liblkl-y += dbg_handler.o
 liblkl-y += ../../perf/pmu-events/jsmn.o
 liblkl-y += config.o
+liblkl-$(LKL_HOST_CONFIG_UML_DEV) += um/
diff --git a/tools/lkl/lib/config.c b/tools/lkl/lib/config.c
index 37f8ac4d942a..db3af68446d3 100644
--- a/tools/lkl/lib/config.c
+++ b/tools/lkl/lib/config.c
@@ -470,6 +470,12 @@ static int lkl_config_netdev_create(struct lkl_config *cfg,
 	memset(&nd_args, 0, sizeof(struct lkl_netdev_args));
 
 	if (!nd && iface->iftype && iface->ifparams) {
+		if ((strcmp(iface->iftype, "um") == 0)) {
+			nd = lkl_um_netdev_create(iface->ifparams);
+			iface->nd = nd;
+			/* um_netdev doesn't use virtio device */
+			return 0;
+		}
 	}
 
 	if (nd) {
diff --git a/tools/lkl/lib/posix-host.c b/tools/lkl/lib/posix-host.c
index 4be1611a8942..d6394d41e125 100644
--- a/tools/lkl/lib/posix-host.c
+++ b/tools/lkl/lib/posix-host.c
@@ -346,6 +346,9 @@ struct lkl_host_operations lkl_host_ops = {
 	.print = print,
 	.mem_alloc = (void *)malloc,
 	.mem_free = free,
+#ifdef LKL_HOST_CONFIG_UML_DEV
+	.um_devices = lkl_um_devs,
+#endif
 	.gettid = _gettid,
 	.jmp_buf_set = jmp_buf_set,
 	.jmp_buf_longjmp = jmp_buf_longjmp,
diff --git a/tools/lkl/lib/um/Build b/tools/lkl/lib/um/Build
new file mode 100644
index 000000000000..09a60975ecd6
--- /dev/null
+++ b/tools/lkl/lib/um/Build
@@ -0,0 +1,2 @@
+liblkl-y += um_glue.o
+liblkl-y += um_net.o
diff --git a/tools/lkl/lib/um/um_glue.c b/tools/lkl/lib/um/um_glue.c
new file mode 100644
index 000000000000..10ca8524e682
--- /dev/null
+++ b/tools/lkl/lib/um/um_glue.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <errno.h>
+
+
+
+char lkl_um_devs[4096];
+
+/* from sigio.c */
+void maybe_sigio_broken(int fd, int read)
+{
+}
+
+/* from process.c */
+int os_getpid(void)
+{
+	return getpid();
+}
+
+
+/* from chan_kern.c */
+void free_irqs(void)
+{
+}
+
+/* from sigio.c */
+int ignore_sigio_fd(int fd)
+{
+	return 0;
+}
diff --git a/tools/lkl/lib/um/um_net.c b/tools/lkl/lib/um/um_net.c
new file mode 100644
index 000000000000..edd0c65fc08e
--- /dev/null
+++ b/tools/lkl/lib/um/um_net.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <lkl_host.h>
+
+static int registered_net_dev_idx;
+
+struct lkl_netdev *lkl_um_netdev_create(const char *ifparams)
+{
+	struct lkl_netdev *nd;
+
+	nd = lkl_host_ops.mem_alloc(sizeof(struct lkl_netdev));
+	if (!nd)
+		return NULL;
+
+	memset(nd, 0, sizeof(struct lkl_netdev));
+
+	nd->id = registered_net_dev_idx++;
+	/* concat strings */
+	snprintf(lkl_um_devs + strlen(lkl_um_devs), sizeof(lkl_um_devs),
+		 " eth%d=%s", nd->id, ifparams);
+
+	return nd;
+}
diff --git a/tools/lkl/tests/net-setup.sh b/tools/lkl/tests/net-setup.sh
index 0cfc42a30a54..fa390fb904b5 100644
--- a/tools/lkl/tests/net-setup.sh
+++ b/tools/lkl/tests/net-setup.sh
@@ -8,6 +8,7 @@ TEST_IP6_NETMASK=64
 TEST_MAC0="aa:bb:cc:dd:ee:ff"
 TEST_MAC1="aa:bb:cc:dd:ee:aa"
 TEST_NETSERVER_PORT=11223
+TEST_UM_SLIRP_PARMS="slirp,,`which slirp`"
 
 # $1 - count
 # $2 - netcount
diff --git a/tools/lkl/tests/net-test.c b/tools/lkl/tests/net-test.c
index edc37150270b..c3f818742263 100644
--- a/tools/lkl/tests/net-test.c
+++ b/tools/lkl/tests/net-test.c
@@ -22,9 +22,10 @@
 
 enum {
 	BACKEND_NONE,
+	BACKEND_UM,
 };
 
-const char *backends[] = { "loopback", NULL };
+const char *backends[] = { "loopback", "um", NULL };
 static struct {
 	int backend;
 	const char *ifname;
@@ -164,12 +165,17 @@ static int lkl_test_icmp(void)
 }
 
 static struct lkl_netdev *nd;
+static int nd_id;
 
 static int lkl_test_nd_create(void)
 {
 	switch (cla.backend) {
 	case BACKEND_NONE:
 		return TEST_SKIP;
+	case BACKEND_UM:
+		nd = lkl_um_netdev_create(cla.ifname);
+		nd_id = nd->id;
+		break;
 	}
 
 	if (!nd) {
@@ -180,11 +186,9 @@ static int lkl_test_nd_create(void)
 	return TEST_SUCCESS;
 }
 
-static int nd_id;
-
 static int lkl_test_nd_add(void)
 {
-	if (cla.backend == BACKEND_NONE)
+	if (cla.backend == BACKEND_NONE || cla.backend == BACKEND_UM)
 		return TEST_SKIP;
 
 	return TEST_SUCCESS;
@@ -192,7 +196,7 @@ static int lkl_test_nd_add(void)
 
 static int lkl_test_nd_remove(void)
 {
-	if (cla.backend == BACKEND_NONE)
+	if (cla.backend == BACKEND_NONE || cla.backend == BACKEND_UM)
 		return TEST_SKIP;
 
 	return TEST_SUCCESS;
diff --git a/tools/lkl/tests/net.sh b/tools/lkl/tests/net.sh
index 32e8452b0406..089ebfb332da 100755
--- a/tools/lkl/tests/net.sh
+++ b/tools/lkl/tests/net.sh
@@ -13,6 +13,8 @@ cleanup_backend()
     case "$1" in
     "loopback")
         ;;
+    "um")
+        ;;
     esac
 }
 
@@ -47,6 +49,16 @@ setup_backend()
     case "$1" in
     "loopback")
         ;;
+    "um")
+	# only intel arch is capable with um-net backent
+	if [ -z "$LKL_HOST_CONFIG_UML_DEV" ]; then
+            return $TEST_SKIP
+	fi
+	# slirp's helper process doesn't work with valgrind
+	if [ -n "$VALGRIND" ]; then
+            return $TEST_SKIP
+	fi
+        ;;
     *)
         echo "don't know how to setup backend $1"
         return $TEST_FAILED
@@ -60,6 +72,12 @@ run_tests()
     "loopback")
         lkl_test_exec $script_dir/net-test --dst 127.0.0.1
         ;;
+    "um")
+        lkl_test_exec $script_dir/net-test --backend um \
+                      --ifname $TEST_UM_SLIRP_PARMS \
+                      --ip 10.0.2.15 --netmask-len 8 \
+                      --dst 10.0.2.2
+        ;;
     esac
 }
 
diff --git a/tools/lkl/tests/run.py b/tools/lkl/tests/run.py
index b72299aaabee..23d5c5489e2c 100755
--- a/tools/lkl/tests/run.py
+++ b/tools/lkl/tests/run.py
@@ -54,6 +54,7 @@ tests = [
     'disk.sh -t vfat',
     'disk.sh -t btrfs',
     'net.sh -b loopback',
+    'net.sh -b um',
     'lklfuse.sh -t ext4',
     'lklfuse.sh -t vfat',
     'lklfuse.sh -t btrfs',
-- 
2.21.0 (Apple Git-122.2)

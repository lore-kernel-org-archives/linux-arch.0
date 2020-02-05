Return-Path: <linux-doc-owner@vger.kernel.org>
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [RFC PATCH v9 27/27] x86/cet/shstk: Add arch_prctl functions for
 Shadow Stack
Date: Wed,  5 Feb 2020 10:19:35 -0800
Message-ID: <20200205181935.3712-28-yu-cheng.yu@intel.com>
In-Reply-To: <20200205181935.3712-1-yu-cheng.yu@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Sender: linux-doc-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200205181935.sYUnhknwEw9EbSrJOvcKci6476MmyfEkacIcgIfPYlc@z>

arch_prctl(ARCH_X86_CET_STATUS, unsigned long *addr)
    Return CET feature status.

    The parameter 'addr' is a pointer to a user buffer.  On returning to
    the caller, the kernel fills the following information:

    *addr =3D SHSTK/IBT status
    *(addr + 1) =3D SHSTK base address
    *(addr + 2) =3D SHSTK size

arch_prctl(ARCH_X86_CET_DISABLE, unsigned long features)
    Disable CET features specified in 'features'.  Return -EPERM if CET i=
s
    locked.

arch_prctl(ARCH_X86_CET_LOCK)
    Lock in CET feature.

arch_prctl(ARCH_X86_CET_ALLOC_SHSTK, unsigned long *addr)
    Allocate a new SHSTK.

    The parameter 'addr' is a pointer to a user buffer and indicates the
    desired SHSTK size to allocate.  On returning to the caller the buffe=
r
    contains the address of the new SHSTK.

There is no CET enabling arch_prctl function.  By design, CET is enabled
automatically if the binary and the system can support it.

The parameters passed are always unsigned 64-bit.  When an IA32 applicati=
on
passing pointers, it should only use the lower 32 bits.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/asm/cet.h        |  4 ++
 arch/x86/include/uapi/asm/prctl.h |  5 ++
 arch/x86/kernel/Makefile          |  2 +-
 arch/x86/kernel/cet.c             | 29 +++++++++++
 arch/x86/kernel/cet_prctl.c       | 84 +++++++++++++++++++++++++++++++
 arch/x86/kernel/process.c         |  4 +-
 6 files changed, 125 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/kernel/cet_prctl.c

diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index 9a3e2da9c1c4..b64f6d810ae0 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -14,16 +14,20 @@ struct sc_ext;
 struct cet_status {
 	unsigned long	shstk_base;
 	unsigned long	shstk_size;
+	unsigned int	locked:1;
 	unsigned int	shstk_enabled:1;
 };

 #ifdef CONFIG_X86_INTEL_CET
+int prctl_cet(int option, unsigned long arg2);
 int cet_setup_shstk(void);
 int cet_setup_thread_shstk(struct task_struct *p);
+int cet_alloc_shstk(unsigned long *arg);
 void cet_disable_free_shstk(struct task_struct *p);
 int cet_restore_signal(bool ia32, struct sc_ext *sc);
 int cet_setup_signal(bool ia32, unsigned long rstor, struct sc_ext *sc);
 #else
+static inline int prctl_cet(int option, unsigned long arg2) { return -EI=
NVAL; }
 static inline int cet_setup_thread_shstk(struct task_struct *p) { return=
 0; }
 static inline void cet_disable_free_shstk(struct task_struct *p) {}
 static inline int cet_restore_signal(bool ia32, struct sc_ext *sc) { ret=
urn -EINVAL; }
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/as=
m/prctl.h
index 5a6aac9fa41f..d962f0ec9ccf 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -14,4 +14,9 @@
 #define ARCH_MAP_VDSO_32	0x2002
 #define ARCH_MAP_VDSO_64	0x2003

+#define ARCH_X86_CET_STATUS		0x3001
+#define ARCH_X86_CET_DISABLE		0x3002
+#define ARCH_X86_CET_LOCK		0x3003
+#define ARCH_X86_CET_ALLOC_SHSTK	0x3004
+
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index b8c1ea4ab7eb..69a19957e200 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -142,7 +142,7 @@ obj-$(CONFIG_UNWINDER_ORC)		+=3D unwind_orc.o
 obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+=3D unwind_frame.o
 obj-$(CONFIG_UNWINDER_GUESS)		+=3D unwind_guess.o

-obj-$(CONFIG_X86_INTEL_CET)		+=3D cet.o
+obj-$(CONFIG_X86_INTEL_CET)		+=3D cet.o cet_prctl.o

 ###
 # 64 bit specific files
diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
index 5b45abda80a1..01aa24c40a5d 100644
--- a/arch/x86/kernel/cet.c
+++ b/arch/x86/kernel/cet.c
@@ -145,6 +145,35 @@ static int create_rstor_token(bool ia32, unsigned lo=
ng ssp,
 	return 0;
 }

+int cet_alloc_shstk(unsigned long *arg)
+{
+	unsigned long len =3D *arg;
+	unsigned long addr;
+	unsigned long token;
+	unsigned long ssp;
+
+	addr =3D alloc_shstk(len);
+
+	if (IS_ERR((void *)addr))
+		return PTR_ERR((void *)addr);
+
+	/* Restore token is 8 bytes and aligned to 8 bytes */
+	ssp =3D addr + len;
+	token =3D ssp;
+
+	if (!in_ia32_syscall())
+		token |=3D TOKEN_MODE_64;
+	ssp -=3D 8;
+
+	if (write_user_shstk_64(ssp, token)) {
+		vm_munmap(addr, len);
+		return -EINVAL;
+	}
+
+	*arg =3D addr;
+	return 0;
+}
+
 int cet_setup_shstk(void)
 {
 	unsigned long addr, size;
diff --git a/arch/x86/kernel/cet_prctl.c b/arch/x86/kernel/cet_prctl.c
new file mode 100644
index 000000000000..6cf8f87e3d98
--- /dev/null
+++ b/arch/x86/kernel/cet_prctl.c
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/errno.h>
+#include <linux/uaccess.h>
+#include <linux/prctl.h>
+#include <linux/compat.h>
+#include <linux/mman.h>
+#include <linux/elfcore.h>
+#include <asm/processor.h>
+#include <asm/prctl.h>
+#include <asm/cet.h>
+
+/* See Documentation/x86/intel_cet.rst. */
+
+static int handle_get_status(unsigned long arg2)
+{
+	struct cet_status *cet =3D &current->thread.cet;
+	unsigned int features =3D 0;
+	unsigned long buf[3];
+
+	if (cet->shstk_enabled)
+		features |=3D GNU_PROPERTY_X86_FEATURE_1_SHSTK;
+
+	buf[0] =3D (unsigned long)features;
+	buf[1] =3D cet->shstk_base;
+	buf[2] =3D cet->shstk_size;
+	return copy_to_user((unsigned long __user *)arg2, buf,
+			    sizeof(buf));
+}
+
+static int handle_alloc_shstk(unsigned long arg2)
+{
+	int err =3D 0;
+	unsigned long arg;
+	unsigned long addr =3D 0;
+	unsigned long size =3D 0;
+
+	if (get_user(arg, (unsigned long __user *)arg2))
+		return -EFAULT;
+
+	size =3D arg;
+	err =3D cet_alloc_shstk(&arg);
+	if (err)
+		return err;
+
+	addr =3D arg;
+	if (put_user(addr, (unsigned long __user *)arg2)) {
+		vm_munmap(addr, size);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+int prctl_cet(int option, unsigned long arg2)
+{
+	struct cet_status *cet =3D &current->thread.cet;
+
+	if (!cpu_x86_cet_enabled())
+		return -EINVAL;
+
+	switch (option) {
+	case ARCH_X86_CET_STATUS:
+		return handle_get_status(arg2);
+
+	case ARCH_X86_CET_DISABLE:
+		if (cet->locked)
+			return -EPERM;
+		if (arg2 & GNU_PROPERTY_X86_FEATURE_1_SHSTK)
+			cet_disable_free_shstk(current);
+
+		return 0;
+
+	case ARCH_X86_CET_LOCK:
+		cet->locked =3D 1;
+		return 0;
+
+	case ARCH_X86_CET_ALLOC_SHSTK:
+		return handle_alloc_shstk(arg2);
+
+	default:
+		return -EINVAL;
+	}
+}
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 7098618142f2..63dc88070923 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -998,7 +998,7 @@ long do_arch_prctl_common(struct task_struct *task, i=
nt option,
 		return get_cpuid_mode();
 	case ARCH_SET_CPUID:
 		return set_cpuid_mode(task, cpuid_enabled);
+	default:
+		return prctl_cet(option, cpuid_enabled);
 	}
-
-	return -EINVAL;
 }
--=20
2.21.0

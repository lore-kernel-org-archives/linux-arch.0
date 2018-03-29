From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 001/109] syscalls: define and explain goal to not call syscalls in the kernel
Date: Thu, 29 Mar 2018 13:22:38 +0200
Message-ID: <20180329112426.23043-2-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

The syscall entry points to the kernel defined by SYSCALL_DEFINEx()
and COMPAT_SYSCALL_DEFINEx() should only be called from userspace
through kernel entry points, but not from the kernel itself. This
will allow cleanups and optimizations to the entry paths *and* to
the parts of the kernel code which currently need to pretend to be
userspace in order to make use of syscalls.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 Documentation/process/adding-syscalls.rst | 32 +++++++++++++++++++++++++++++++
 include/linux/syscalls.h                  |  7 +++++++
 2 files changed, 39 insertions(+)

diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/process/adding-syscalls.rst
index 8cc25a06f353..556613744556 100644
--- a/Documentation/process/adding-syscalls.rst
+++ b/Documentation/process/adding-syscalls.rst
@@ -487,6 +487,38 @@ patchset, for the convenience of reviewers.
 The man page should be cc'ed to linux-man@vger.kernel.org
 For more details, see https://www.kernel.org/doc/man-pages/patches.html
 
+
+Do not call System Calls in the Kernel
+--------------------------------------
+
+System calls are, as stated above, interaction points between userspace and
+the kernel.  Therefore, system call functions such as ``sys_xyzzy()`` or
+``compat_sys_xyzzy()`` should only be called from userspace via the syscall
+table, but not from elsewhere in the kernel.  If the syscall functionality is
+useful to be used within the kernel, needs to be shared between an old and a
+new syscall, or needs to be shared between a syscall and its compatibility
+variant, it should be implemented by means of a "helper" function (such as
+``kern_xyzzy()``).  This kernel function may then be called within the
+syscall stub (``sys_xyzzy()``), the compatibility syscall stub
+(``compat_sys_xyzzy()``), and/or other kernel code.
+
+At least on 64-bit x86, it will be a hard requirement from v4.17 onwards to not
+call system call functions in the kernel.  It uses a different calling
+convention for system calls where ``struct pt_regs`` is decoded on-the-fly in a
+syscall wrapper which then hands processing over to the actual syscall function.
+This means that only those parameters which are actually needed for a specific
+syscall are passed on during syscall entry, instead of filling in six CPU
+registers with random user space content all the time (which may cause serious
+trouble down the call chain).
+
+Moreover, rules on how data may be accessed may differ between kernel data and
+user data.  This is another reason why calling ``sys_xyzzy()`` is generally a
+bad idea.
+
+Exceptions to this rule are only allowed in architecture-specific overrides,
+architecture-specific compatibility wrappers, or other code in arch/.
+
+
 References and Sources
 ----------------------
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a78186d826d7..0526286a0314 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -941,4 +941,11 @@ asmlinkage long sys_pkey_free(int pkey);
 asmlinkage long sys_statx(int dfd, const char __user *path, unsigned flags,
 			  unsigned mask, struct statx __user *buffer);
 
+
+/*
+ * Kernel code should not call syscalls (i.e., sys_xyzyyz()) directly.
+ * Instead, use one of the functions which work equivalently, such as
+ * the ksys_xyzyyz() functions prototyped below.
+ */
+
 #endif
-- 
2.16.3

From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 0/3] syscalls: clean up stub naming convention
Date: Sun, 8 Apr 2018 21:59:52 +0200
Message-ID: <20180408195952.GA27462@light.dominikbrodowski.net>
References: <20180407074651.29014-1-linux@dominikbrodowski.net>
 <20180408083550.32d65b6ra6yca5p7@gmail.com>
 <20180408091536.GA10120@light.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180408091536.GA10120@light.dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andi Kleen <ak@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, Maninder Singh <maninder1.s@samsung.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Sun, Apr 08, 2018 at 11:15:36AM +0200, Dominik Brodowski wrote:
> On a somewhat related note: I'll try to prepare a patch this evening which
> lets us build just the __ia32_sys and __x32_compat_sys stubs we actually
> need. We have that information already in entry/syscalls/syscall_{32,64}.tbl,
> it just needs to be extracted into another header file (in the form of
> 	#define NEED_IA32_sys_xyzzz 1
> ) and then tested within the stubs. After some randconfig testing, this
> might be worthwile to add on top of the patches already in tip-asm and the
> three renaming patches currently under discussion.

So this got a bit more complicated than I though, for a -5k text size
decrease. I have my doubts whether the increased code complexity is really
worth that minor size decrease. I'll send another patch shortly, though,
which fixes up the naming of a few macros in <asm/syscall_wrapper.h>.

--------------------------------------------------------------------------
From: Dominik Brodowski <linux@dominikbrodowski.net>
Date: Sun, 8 Apr 2018 21:38:54 +0200
Subject: [PATCH] syscalls/x86: only build stubs which are actually needed

A new script arch/x86/entry/syscalls/syscallstubs.sh generates
defines in <asm/syscall_stubs.h>

	for all __ia32_sys_ stubs which are actually needed for
	IA32_EMULATION,

and

	for all __x32_compat_sys_ stubs which are actually needed
	for X32.

By omitting to build the remaining stubs (which are defined as
__SYSCALL_STUBx_UNUSED), there is a measurable decrease in kernel
size (-5k):

    text    data      bss      dec     hex filename
12892057 7094202 13570252 33556511 200081f vmlinux-orig
12886397 7087514 13570252 33544163 1ffd7e3 vmlinux

Further size cuttings could be achieved by not building stubs for
syscalls and compat_syscalls which are not referenced in the syscall
tables, such as (at least)

	sys_gethostname
	sys_sync_file_range2
	sys_send
	sys_recv
	compat_sys_mbind
	compat_sys_set_mempolicy
	compat_sys_migrate_pages
	compat_sys_sendtimedop
	compat_sys_msgrcv
	compat_sys_semctl
	compat_sys_send
	compat_sys_recv

Not-yet-signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

diff --git a/arch/x86/entry/syscalls/Makefile b/arch/x86/entry/syscalls/Makefile
index 6fb9b57ed5ba..036199136513 100644
--- a/arch/x86/entry/syscalls/Makefile
+++ b/arch/x86/entry/syscalls/Makefile
@@ -11,6 +11,7 @@ syscall64 := $(srctree)/$(src)/syscall_64.tbl
 
 syshdr := $(srctree)/$(src)/syscallhdr.sh
 systbl := $(srctree)/$(src)/syscalltbl.sh
+sysstubs := $(srctree)/$(src)/syscallstubs.sh
 
 quiet_cmd_syshdr = SYSHDR  $@
       cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@' \
@@ -20,6 +21,11 @@ quiet_cmd_syshdr = SYSHDR  $@
 quiet_cmd_systbl = SYSTBL  $@
       cmd_systbl = $(CONFIG_SHELL) '$(systbl)' $< $@
 
+quiet_cmd_sysstubs = SYSSTUBS  $@
+      cmd_sysstubs = $(CONFIG_SHELL) '$(sysstubs)' \
+		   '$(syscall32)' '$(syscall64)' \
+		    $@
+
 quiet_cmd_hypercalls = HYPERCALLS $@
       cmd_hypercalls = $(CONFIG_SHELL) '$<' $@ $(filter-out $<,$^)
 
@@ -51,6 +57,9 @@ $(out)/syscalls_32.h: $(syscall32) $(systbl)
 $(out)/syscalls_64.h: $(syscall64) $(systbl)
 	$(call if_changed,systbl)
 
+$(out)/syscall_stubs.h:  $(syscall32) $(syscall64) $(sysstubs)
+	$(call if_changed,sysstubs)
+
 $(out)/xen-hypercalls.h: $(srctree)/scripts/xen-hypercalls.sh
 	$(call if_changed,hypercalls)
 
@@ -60,6 +69,7 @@ uapisyshdr-y			+= unistd_32.h unistd_64.h unistd_x32.h
 syshdr-y			+= syscalls_32.h
 syshdr-$(CONFIG_X86_64)		+= unistd_32_ia32.h unistd_64_x32.h
 syshdr-$(CONFIG_X86_64)		+= syscalls_64.h
+syshdr-$(CONFIG_X86_64)		+= syscall_stubs.h
 syshdr-$(CONFIG_XEN)		+= xen-hypercalls.h
 
 targets	+= $(uapisyshdr-y) $(syshdr-y)
diff --git a/arch/x86/entry/syscalls/syscallstubs.sh b/arch/x86/entry/syscalls/syscallstubs.sh
new file mode 100644
index 000000000000..4db64d4db75a
--- /dev/null
+++ b/arch/x86/entry/syscalls/syscallstubs.sh
@@ -0,0 +1,110 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+in32="$1"
+in64="$2"
+out="$3"
+
+emit_stub() {
+    entry="$1"
+    if [ "${entry}" != "${entry#__ia32_sys_}" ]; then
+	# We need a stub named __ia32_sys which is common to 64-bit
+	# except for a different pt_regs layout.
+	stubname=${entry#__ia32_sys_}
+	echo "#define __IA32_SYS_STUBx_${stubname} __IA32_SYS_STUBx"
+	echo "#define ASM_X86_HAS__ia32_sys_${stubname} 1"
+    elif [ "$entry" != "${entry#__x32_compat_sys}" ]; then
+	# We need a stub named __x32_compat_sys_ which decodes a
+	# 64-bit pt_regs and then calls the real syscall function 
+	stubname="${entry%%/*}" # handle qualifier
+	stubname=${stubname#__x32_compat_sys_} # handle prefix
+	echo "#define __X32_COMPAT_SYS_STUBx_${stubname} __X32_COMPAT_SYS_STUBx"
+	echo "#define ASM_X86_HAS__x32_compat_sys_${stubname} 1"
+    elif [ "$entry" != "${entry#__ia32_compat_sys_x86}" ]; then
+	# The compat entry starts with __ia32_compat_sys_x86, so it
+	# is a specific x86 compat syscall; no need for __ia32_sys_*()
+	stubname=${entry#__ia32_compat_sys_x86_}
+	echo "#define __IA32_SYS_STUBx_${stubname} __SYSCALL_STUBx_UNUSED"
+	echo "#define ASM_X86_HAS__ia32_sys_${stubname} 1"
+    elif [ "$entry" != "${entry#__ia32_compat_sys_}" ]; then
+	# The compat entry starts with __ia32_compat_sys, so it is
+	# is a generic x86 compat syscall; no need for __ia32_sys_*()
+	stubname=${entry#__ia32_compat_sys_}
+	echo "#define __IA32_SYS_STUBx_${stubname} __SYSCALL_STUBx_UNUSED"
+	echo "#define ASM_X86_HAS__ia32_sys_${stubname} 1"
+    fi;
+}
+
+# First, we need to check which stubs we *need*. While at it, we can determine
+# quite many ia32 stubs we do *not* need as the syscall is handled by a compat
+# syscall
+grep '^[0-9]' "$in32" | sort -n | (
+    while read nr abi name entry compat; do
+	abi=`echo "$abi" | tr '[a-z]' '[A-Z]'`
+	if [ "$abi" = "I386" -a -n "$compat" ]; then
+	    emit_stub "$compat"
+	fi
+    done
+) > "$out"
+
+grep '^[0-9]' "$in64" | sort -n | (
+    while read nr abi name entry compat; do
+	abi=`echo "$abi" | tr '[a-z]' '[A-Z]'`
+	if [ "$abi" = "X32" -a -n "$entry" ]; then
+	    emit_stub "$entry"
+	fi
+    done
+) >> "$out"
+
+# Then, we need to determine all (remaining) stubs we *do not* need.
+grep '^[0-9]' "$in64" | sort -n | (
+    while read nr abi name entry compat; do
+	abi=`echo "$abi" | tr '[a-z]' '[A-Z]'`
+	if [ "$abi" = "COMMON" -o "$abi" = "64" ]; then
+	    if [ -n "$entry" -a "$entry" != "${entry#__x64_sys_}" ]; then
+		# what's the actual stubname?
+		stubname="${entry%%/*}" # handle qualifier
+		stubname="${stubname#__x64_sys_}" # handle prefix
+
+		# syscalls only referenced for 64-bit do not need a stub for
+		# IA32_EMULATION
+		echo "#ifndef ASM_X86_HAS__ia32_sys_${stubname}"
+		echo "#define __IA32_SYS_STUBx_${stubname} __SYSCALL_STUBx_UNUSED"
+		echo "#endif"
+
+		# A number of compat syscalls are built in even though they are
+		# completely unused -- e.g. mbind set_mempolicy migrate_pages
+		# sendtimedop msgrcv semctl. We probably define more compat
+		# syscalls than exist, but better be safe than sorry...
+		echo "#ifndef ASM_X86_HAS__x32_compat_sys_${stubname}"
+		echo "#define __X32_COMPAT_SYS_STUBx_${stubname} __SYSCALL_STUBx_UNUSED"
+		echo "#endif"
+	    fi
+	fi
+    done
+) >> "$out"
+
+grep '^[0-9]' "$in32" | sort -n | (
+    while read nr abi name entry compat; do
+	abi=`echo "$abi" | tr '[a-z]' '[A-Z]'`
+	if [ "$abi" = "I386" -a -n "$compat" ]; then
+	    if [ "$compat" != "${compat#__ia32_compat_sys}" ]; then
+		stubname="${compat#__ia32_compat_sys_}"
+		# If a compat syscall is not needed for x32 (see above),
+		# we need to assert that the stub is defined as unused
+		echo "#ifndef ASM_X86_HAS__x32_compat_sys_${stubname}"
+		echo "#define __X32_COMPAT_SYS_STUBx_${stubname} __SYSCALL_STUBx_UNUSED"
+		echo "#endif"
+	    fi
+	fi
+    done
+) >> "$out"
+
+# FIXME: These syscalls get build even though they are completely unused on x86
+( for unused_syscall in gethostname sync_file_range2 send recv; do
+    echo "#define __IA32_SYS_STUBx_${unused_syscall} __SYSCALL_STUBx_UNUSED"
+done ) >> "$out"
+( for unused_compat_syscall in send recv; do
+    echo "#define __X32_COMPAT_SYS_STUBx_${unused_compat_syscall} __SYSCALL_STUBx_UNUSED"
+done ) >> "$out"
+
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index de690c2d2e33..3aeb3a794da4 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -5,6 +5,7 @@ generated-y += syscalls_64.h
 generated-y += unistd_32_ia32.h
 generated-y += unistd_64_x32.h
 generated-y += xen-hypercalls.h
+generated-y += syscall_stubs.h
 
 generic-y += dma-contiguous.h
 generic-y += early_ioremap.h
diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index bad0295739bf..0b847f422bf6 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -4,7 +4,10 @@
  */
 
 #ifndef _ASM_X86_SYSCALL_WRAPPER_H
-#define _ASM_X86_SYSCALL_WRAPPER_H
+#define _ASM_X86_SYSCALL_WRAPPER_H 1
+
+#define __SYSCALL_STUBx_UNUSED(x, name, ...)
+#include <asm/syscall_stubs.h>
 
 /* Mapping of registers to parameters for syscalls on x86-64 and x32 */
 #define SC_X86_64_REGS_TO_ARGS(x, ...)					\
@@ -28,15 +31,15 @@
  * kernel/sys_ni.c and SYS_NI in kernel/time/posix-stubs.c to cover this
  * case as well.
  */
-#define COMPAT_SC_IA32_STUBx(x, name, ...)				\
+#define __IA32_COMPAT_SYS_STUBx(x, name, ...)				\
 	asmlinkage long __ia32_compat_sys##name(const struct pt_regs *regs);\
 	ALLOW_ERROR_INJECTION(__ia32_compat_sys##name, ERRNO);		\
 	asmlinkage long __ia32_compat_sys##name(const struct pt_regs *regs)\
 	{								\
 		return __do_compat_sys##name(SC_IA32_REGS_TO_ARGS(x,__VA_ARGS__));\
-	}								\
+	}
 
-#define SC_IA32_WRAPPERx(x, name, ...)					\
+#define __IA32_SYS_STUBx(x, name, ...)					\
 	asmlinkage long __ia32_sys##name(const struct pt_regs *regs);	\
 	ALLOW_ERROR_INJECTION(__ia32_sys##name, ERRNO);			\
 	asmlinkage long __ia32_sys##name(const struct pt_regs *regs)	\
@@ -64,8 +67,8 @@
 	SYSCALL_ALIAS(__ia32_sys_##name, sys_ni_posix_timers)
 
 #else /* CONFIG_IA32_EMULATION */
-#define COMPAT_SC_IA32_STUBx(x, name, ...)
-#define SC_IA32_WRAPPERx(x, fullname, name, ...)
+#define __IA32_COMPAT_SYS_STUBx(x, name, ...)
+#define __IA32_SYS_STUBx(x, name, ...)
 #endif /* CONFIG_IA32_EMULATION */
 
 
@@ -75,7 +78,7 @@
  * of the x86-64-style parameter ordering of x32 syscalls. The syscalls common
  * with x86_64 obviously do not need such care.
  */
-#define COMPAT_SC_X32_STUBx(x, name, ...)				\
+#define __X32_COMPAT_SYS_STUBx(x, name, ...)				\
 	asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs);\
 	ALLOW_ERROR_INJECTION(__x32_compat_sys##name, ERRNO);		\
 	asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs)\
@@ -84,7 +87,7 @@
 	}								\
 
 #else /* CONFIG_X86_X32 */
-#define COMPAT_SC_X32_STUBx(x, name, ...)
+#define __X32_COMPAT_SYS_STUBx(x, name, ...)
 #endif /* CONFIG_X86_X32 */
 
 
@@ -97,8 +100,8 @@
 #define COMPAT_SYSCALL_DEFINEx(x, name, ...)					\
 	static long __do_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
 	static inline long __in_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
-	COMPAT_SC_IA32_STUBx(x, name, __VA_ARGS__)				\
-	COMPAT_SC_X32_STUBx(x, name, __VA_ARGS__)				\
+	__IA32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)				\
+	__X32_COMPAT_SYS_STUBx##name(x, name, __VA_ARGS__)			\
 	static long __do_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
 	{									\
 		return __in_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));\
@@ -120,7 +123,6 @@
 
 #endif /* CONFIG_COMPAT */
 
-
 /*
  * Instead of the generic __SYSCALL_DEFINEx() definition, this macro takes
  * struct pt_regs *regs as the only argument of the syscall stub named
@@ -163,7 +165,7 @@
 	{								\
 		return __do_sys##name(SC_X86_64_REGS_TO_ARGS(x,__VA_ARGS__));\
 	}								\
-	SC_IA32_WRAPPERx(x, name, __VA_ARGS__)				\
+	__IA32_SYS_STUBx##name(x, name, __VA_ARGS__)			\
 	static long __do_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
 	{								\
 		long ret = __in_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));\

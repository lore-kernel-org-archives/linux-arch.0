From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Writable sys_call_table (was: Re: [uClinux-dev] [PATCH] m68k: Merge mmu and non-mmu versions of sys_call_table)
Date: Tue, 19 Apr 2011 09:48:36 +0200
Message-ID: <201104190948.36517.arnd@arndb.de>
References: <BANLkTimbHgmUvisE7+TCkgthejNi_zdojQ@mail.gmail.com> <201104181649.31492.arnd@arndb.de> <m2y637bkep.fsf@igel.home>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <m2y637bkep.fsf@igel.home>
Sender: linux-m68k-owner@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@snapgear.com>, Gavin Lambert <gavinl@compacsort.com>, uClinux development list <uclinux-dev@uclinux.org>, Philippe De Muyter <phdm@macqel.be>, Linux/m68k <linux-m68k@lists.linux-m68k.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Monday 18 April 2011, Andreas Schwab wrote:
> >  
> > -void *sys_call_table[__NR_syscalls] = {
> > +const void *sys_call_table[__NR_syscalls] = {
> 
> That's not making it read-only.  You need to move the const to the other
> side of the pointer.

D'oh!

8<--------
[PATCH] mark sys_call_table as const

There is no reason to have sys_call_table writable, and putting
it into the rodata section can make it harder for malicious users
to overwrite the entry points.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
diff --git a/arch/score/kernel/sys_call_table.c b/arch/score/kernel/sys_call_table.c
index 287369b..6d61120 100644
--- a/arch/score/kernel/sys_call_table.c
+++ b/arch/score/kernel/sys_call_table.c
@@ -7,6 +7,6 @@
 #undef __SYSCALL
 #define __SYSCALL(nr, call) [nr] = (call),
 
-void *sys_call_table[__NR_syscalls] = {
+void *const sys_call_table[__NR_syscalls] = {
 #include <asm/unistd.h>
 };
diff --git a/arch/tile/include/asm/syscalls.h b/arch/tile/include/asm/syscalls.h
index 3b5507c..c0d6914 100644
--- a/arch/tile/include/asm/syscalls.h
+++ b/arch/tile/include/asm/syscalls.h
@@ -25,9 +25,9 @@
 #include <linux/compat.h>
 
 /* The array of function pointers for syscalls. */
-extern void *sys_call_table[];
+extern void *const sys_call_table[];
 #ifdef CONFIG_COMPAT
-extern void *compat_sys_call_table[];
+extern void *const compat_sys_call_table[];
 #endif
 
 /*
diff --git a/arch/tile/kernel/compat.c b/arch/tile/kernel/compat.c
index dbc213a..aedf769 100644
--- a/arch/tile/kernel/compat.c
+++ b/arch/tile/kernel/compat.c
@@ -166,7 +166,7 @@ long tile_compat_sys_msgrcv(int msqid,
  * Note that we can't include <linux/unistd.h> here since the header
  * guard will defeat us; <asm/unistd.h> checks for __SYSCALL as well.
  */
-void *compat_sys_call_table[__NR_syscalls] = {
+void *const compat_sys_call_table[__NR_syscalls] = {
 	[0 ... __NR_syscalls-1] = sys_ni_syscall,
 #include <asm/unistd.h>
 };
diff --git a/arch/tile/kernel/sys.c b/arch/tile/kernel/sys.c
index e2187d2..1fb2480 100644
--- a/arch/tile/kernel/sys.c
+++ b/arch/tile/kernel/sys.c
@@ -122,7 +122,7 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
  * Note that we can't include <linux/unistd.h> here since the header
  * guard will defeat us; <asm/unistd.h> checks for __SYSCALL as well.
  */
-void *sys_call_table[__NR_syscalls] = {
+void *const sys_call_table[__NR_syscalls] = {
 	[0 ... __NR_syscalls-1] = sys_ni_syscall,
 #include <asm/unistd.h>
 };
diff --git a/arch/unicore32/kernel/sys.c b/arch/unicore32/kernel/sys.c
index 3afe60a..00f3046 100644
--- a/arch/unicore32/kernel/sys.c
+++ b/arch/unicore32/kernel/sys.c
@@ -120,7 +120,7 @@ SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
 #define __SYSCALL(nr, call)	[nr] = (call),
 
 /* Note that we don't include <linux/unistd.h> but <asm/unistd.h> */
-void *sys_call_table[__NR_syscalls] = {
+void *const sys_call_table[__NR_syscalls] = {
 	[0 ... __NR_syscalls-1] = sys_ni_syscall,
 #include <asm/unistd.h>
 };

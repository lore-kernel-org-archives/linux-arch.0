From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Writable sys_call_table (was: Re: [uClinux-dev] [PATCH] m68k: Merge mmu and non-mmu versions of sys_call_table)
Date: Mon, 18 Apr 2011 16:49:31 +0200
Message-ID: <201104181649.31492.arnd@arndb.de>
References: <BANLkTimbHgmUvisE7+TCkgthejNi_zdojQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <BANLkTimbHgmUvisE7+TCkgthejNi_zdojQ@mail.gmail.com>
Sender: linux-m68k-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andreas Schwab <schwab@linux-m68k.org>, Greg Ungerer <gerg@snapgear.com>, Gavin Lambert <gavinl@compacsort.com>, uClinux development list <uclinux-dev@uclinux.org>, Philippe De Muyter <phdm@macqel.be>, Linux/m68k <linux-m68k@lists.linux-m68k.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wednesday 13 April 2011, Geert Uytterhoeven wrote:
> On Thu, Apr 7, 2011 at 10:29, Andreas Schwab <schwab@linux-m68k.org> wrote:
> > Geert Uytterhoeven <geert@linux-m68k.org> writes:
> >> Isn't there a reason it was read-write on m68k, like the table may be changed
> >> at runtime (to install rootkits :-)? Have to check what the other arches do...
> >
> > Initially the syscall_table in Linux has always been writable, bb152f53
> > ("x86/x86_64: mark rodata section read-only: make some datastructures
> > const") made it read-only on x86.  Apparently nobody bothered to do the
> > equivalent change on m68k (I don't think anything makes the kernel text
> > segment write protected anyway).
> 
> 11 arches still store it in "data", including the 4 using the new
> asm-generic/unistd.h
> framework. 9 use "rodata" and 6 use "text".
> The constness of C "extern" declarations doesn't necessarily matches the
> actual sections.
> 

Thanks for pointing this out. Should we apply this patch?
---
[PATCH] mark sys_call_table as const

There is no reason to have sys_call_table writable, and putting
it into the rodata section can make it harder for malicious users
to overwrite the entry points.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/score/kernel/sys_call_table.c b/arch/score/kernel/sys_call_table.c
index 287369b..7be73dc 100644
--- a/arch/score/kernel/sys_call_table.c
+++ b/arch/score/kernel/sys_call_table.c
@@ -7,6 +7,6 @@
 #undef __SYSCALL
 #define __SYSCALL(nr, call) [nr] = (call),
 
-void *sys_call_table[__NR_syscalls] = {
+const void *sys_call_table[__NR_syscalls] = {
 #include <asm/unistd.h>
 };
diff --git a/arch/tile/kernel/sys.c b/arch/tile/kernel/sys.c
index e2187d2..3f2ba14 100644
--- a/arch/tile/kernel/sys.c
+++ b/arch/tile/kernel/sys.c
@@ -122,7 +122,7 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
  * Note that we can't include <linux/unistd.h> here since the header
  * guard will defeat us; <asm/unistd.h> checks for __SYSCALL as well.
  */
-void *sys_call_table[__NR_syscalls] = {
+const void *sys_call_table[__NR_syscalls] = {
 	[0 ... __NR_syscalls-1] = sys_ni_syscall,
 #include <asm/unistd.h>
 };
diff --git a/arch/tile/kernel/compat.c b/arch/tile/kernel/compat.c
index dbc213a..d221452 100644
--- a/arch/tile/kernel/compat.c
+++ b/arch/tile/kernel/compat.c
@@ -166,7 +166,7 @@ long tile_compat_sys_msgrcv(int msqid,
  * Note that we can't include <linux/unistd.h> here since the header
  * guard will defeat us; <asm/unistd.h> checks for __SYSCALL as well.
  */
-void *compat_sys_call_table[__NR_syscalls] = {
+const void *compat_sys_call_table[__NR_syscalls] = {
 	[0 ... __NR_syscalls-1] = sys_ni_syscall,
 #include <asm/unistd.h>
 };
diff --git a/arch/unicore32/kernel/sys.c b/arch/unicore32/kernel/sys.c
index 3afe60a..7a16c7e 100644
--- a/arch/unicore32/kernel/sys.c
+++ b/arch/unicore32/kernel/sys.c
@@ -120,7 +120,7 @@ SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
 #define __SYSCALL(nr, call)	[nr] = (call),
 
 /* Note that we don't include <linux/unistd.h> but <asm/unistd.h> */
-void *sys_call_table[__NR_syscalls] = {
+const void *sys_call_table[__NR_syscalls] = {
 	[0 ... __NR_syscalls-1] = sys_ni_syscall,
 #include <asm/unistd.h>
 };

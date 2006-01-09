Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:30442 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1751637AbWAIXgm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jan 2006 18:36:42 -0500
Date: Tue, 10 Jan 2006 10:36:14 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Subject: [PATCH] powerpc: remove compat_sys_pciconfig_*
Message-Id: <20060110103614.45571f62.sfr@canb.auug.org.au>
In-Reply-To: <20060109162718.GP19769@parisc-linux.org>
References: <20060109162718.GP19769@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-arch@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, cneira@srb.cl, linuxppc64-dev@ozlabs.org, paulus@samba.org, anton@samba.org
List-ID: <linux-arch.vger.kernel.org>

Matthew Wilcox wondered why we need these functions.  We don't.
Remove them and just use the "normnal" versions.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/kernel/sys_ppc32.c |   24 ------------------------
 arch/powerpc/kernel/systbl.S    |    6 +++---
 2 files changed, 3 insertions(+), 27 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

a588565777a0563a1997e2d515db43f9882cb628
diff --git a/arch/powerpc/kernel/sys_ppc32.c b/arch/powerpc/kernel/sys_ppc32.c
index 9c921d1..9b6d965 100644
--- a/arch/powerpc/kernel/sys_ppc32.c
+++ b/arch/powerpc/kernel/sys_ppc32.c
@@ -552,30 +552,6 @@ asmlinkage long compat_sys_sched_rr_get_
 	return ret;
 }
 
-asmlinkage int compat_sys_pciconfig_read(u32 bus, u32 dfn, u32 off, u32 len, u32 ubuf)
-{
-	return sys_pciconfig_read((unsigned long) bus,
-				  (unsigned long) dfn,
-				  (unsigned long) off,
-				  (unsigned long) len,
-				  compat_ptr(ubuf));
-}
-
-asmlinkage int compat_sys_pciconfig_write(u32 bus, u32 dfn, u32 off, u32 len, u32 ubuf)
-{
-	return sys_pciconfig_write((unsigned long) bus,
-				   (unsigned long) dfn,
-				   (unsigned long) off,
-				   (unsigned long) len,
-				   compat_ptr(ubuf));
-}
-
-asmlinkage int compat_sys_pciconfig_iobase(u32 which, u32 in_bus, u32 in_devfn)
-{
-	return sys_pciconfig_iobase(which, in_bus, in_devfn);
-}
-
-
 /* Note: it is necessary to treat mode as an unsigned int,
  * with the corresponding cast to a signed int to insure that the 
  * proper conversion (sign extension) between the register representation of a signed int (msr in 32-bit mode)
diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
index 65463a1..c3ae74b 100644
--- a/arch/powerpc/kernel/systbl.S
+++ b/arch/powerpc/kernel/systbl.S
@@ -239,9 +239,9 @@ SYS32ONLY(ftruncate64)
 SYSX(sys_ni_syscall,sys_stat64,sys_stat64)
 SYSX(sys_ni_syscall,sys_lstat64,sys_lstat64)
 SYSX(sys_ni_syscall,sys_fstat64,sys_fstat64)
-COMPAT_SYS(pciconfig_read)
-COMPAT_SYS(pciconfig_write)
-COMPAT_SYS(pciconfig_iobase)
+SYSCALL(pciconfig_read)
+SYSCALL(pciconfig_write)
+SYSCALL(pciconfig_iobase)
 SYSCALL(ni_syscall)
 SYSCALL(getdents64)
 SYSCALL(pivot_root)
-- 
1.0.6

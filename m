From: Kyle McMartin <kyle@infradead.org>
Subject: Re: flock, FAGAIN, and FWOULDBLOCK
Date: Sun, 22 Feb 2009 20:42:24 -0500
Message-ID: <20090223014224.GB13157@bombadil.infradead.org>
References: <200902222252.45051.sf@sfritsch.de> <20090222224924.GA13157@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:37463 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbZBWBmZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 22 Feb 2009 20:42:25 -0500
Content-Disposition: inline
In-Reply-To: <20090222224924.GA13157@bombadil.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Stefan Fritsch <sf@sfritsch.de>, debian-hppa@lists.debian.org

On Sun, Feb 22, 2009 at 05:49:24PM -0500, Kyle McMartin wrote:
> > according to the flock(2) man page, flock should return EWOULDBLOCK 
> > when a file is locked and the LOCK_NB flag was selected. But on hppa, 
> > it seems to return EAGAIN which is not the same. Where is the bug 
> > here? In the kernel, glibc, or manpages-dev?
> > 
> > This causes problems in apr since it only checks for EWOULDBLOCK.
> > 
> 
> Ugh. Fail.
> 
> EWOULDBLOCK is defined to be EAGAIN on every architecture but parisc,
> since HPUX has different errno values for EAGAIN and EWOULDBLOCK.
> 
> Definitely a kernel bug, if posix says it should return EWOULDBLOCK...
> 

This is really going to suck, it looks like a lot of the locking
primitives used EAGAIN and EWOULDBLOCK interchangeably... The fcntl
manpage says 'EAGAIN or EWOULDBLOCK' so is flock(2) the only problem
here? From a quick glance at posix, fcntl(2) returning EAGAIN is
correct.

My guess is, I'll be able to sort this out with a simple

diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_parisc.c
index 71b3195..18e8542 100644
--- a/arch/parisc/kernel/sys_parisc.c
+++ b/arch/parisc/kernel/sys_parisc.c
@@ -156,6 +156,17 @@ asmlinkage unsigned long sys_mmap(unsigned long addr, unsigned long len,
 
 /* Fucking broken ABI */
 
+asmlinkage long parisc_flock(unsigned int fd, unsigned int cmd)
+{
+	long ret;
+
+	ret = sys_flock(fd, cmd);
+	if (ret == -EAGAIN)
+		ret = -EWOULDBLOCK;	/* fuck you HPUX */
+
+	return ret;
+}
+
 #ifdef CONFIG_64BIT
 asmlinkage long parisc_truncate64(const char __user * path,
 					unsigned int high, unsigned int low)
diff --git a/arch/parisc/kernel/syscall_table.S b/arch/parisc/kernel/syscall_table.S
index 303d2b6..8c62951 100644
--- a/arch/parisc/kernel/syscall_table.S
+++ b/arch/parisc/kernel/syscall_table.S
@@ -226,7 +226,7 @@
 	/* it is POSSIBLE that select will be OK because even though fd_set
 	 * contains longs, the macros and sizes are clever. */
 	ENTRY_COMP(select)
-	ENTRY_SAME(flock)
+	ENTRY_OURS(flock)
 	ENTRY_SAME(msync)
 	/* struct iovec contains pointers */
 	ENTRY_COMP(readv)		/* 145 */

but somehow I suspect this interchangeable use of EAGAIN and EWOULDBLOCK
is going to reveal latent problems in this part of the kernel I would
rather not delve into...

cheers, Kyle

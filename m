From: Ralf Baechle <ralf@linux-mips.org>
Subject: Sign extension problem in llseek(2)
Date: Tue, 24 Mar 2009 19:24:18 +0100
Message-ID: <20090324182418.GC6509@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([213.58.128.207]:33844 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757327AbZCXSYf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 Mar 2009 14:24:35 -0400
Received: from localhost.localdomain ([127.0.0.1]:40639 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21368290AbZCXSYY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 24 Mar 2009 18:24:24 +0000
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: dann frazier <dannf@dannf.org>, linux-mips@linux-mips.org

In fs/read_write.c:

SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned long, offset_high,
                unsigned long, offset_low, loff_t __user *, result,
                unsigned int, origin)
...
	offset = vfs_llseek(file, ((loff_t) offset_high << 32) | offset_low,
                        origin);
 
On a 64-bit system that define CONFIG_HAVE_SYSCALL_WRAPPERS SYSCALL_DEFINEx
will truncate long arguments to 32-bit and on some architectures such as
MIPS sign-extended to 64-bit again.  On such architectures passing a
value with bit 31 in offset_low set will result in a huge 64-bit offset
being passed to vfs_llseek() and it failiing with EINVAL.

MIPS is affected by this issue.  Other 64-bit architectures which also
set CONFIG_HAVE_SYSCALL_WRAPPERS and __ARCH_WANT_SYS_LLSEEK are PowerPC,
S390 and sparc.

The issue was discovered on Debian's MIPS infrastructure machines running
e2fsck:

[...]
                          This was noticed on one of the Debian
infrastructure machines where, after an upgrade, e2fsck began failing
with errors like:

  Error reading block 524290 (Invalid argument) while getting next inode
  from scan.  Ignore error<y>?
[...]

  Ralf

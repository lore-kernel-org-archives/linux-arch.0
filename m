Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:50572 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763875AbXHVRaq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 22 Aug 2007 13:30:46 -0400
Received: from localhost.localdomain ([127.0.0.1]:21715 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022864AbXHVRaq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 22 Aug 2007 18:30:46 +0100
Date: Wed, 22 Aug 2007 18:30:44 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFC][PATCH] introduce TASK_SIZE_OF() for all arches
Message-ID: <20070822173044.GA1978@linux-mips.org>
References: <20070821193835.258D7DD4@kernel> <20070821194309.GD9163@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070821194309.GD9163@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Dave Hansen <haveblue@us.ibm.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Aug 21, 2007 at 01:43:09PM -0600, Matthew Wilcox wrote:

> On Tue, Aug 21, 2007 at 12:38:35PM -0700, Dave Hansen wrote:
> > I'd like to have that for other architectures.  So, add it
> > for all the architectures that actually use "current" in 
> > their TASK_SIZE.  For the others, just add a quick #define
> > in sched.h to use plain old TASK_SIZE.
> 
> MIPS seems to do things a little differently ... Ralf, what should Dave
> be doing here?
> 
> #define TASK_SIZE32     0x7fff8000UL
> #define TASK_SIZE       0x10000000000UL

Indeed. Below patch should do the trick.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/include/asm-mips/processor.h b/include/asm-mips/processor.h
index 83bc945..0e79e03 100644
--- a/include/asm-mips/processor.h
+++ b/include/asm-mips/processor.h
@@ -45,6 +45,8 @@ extern unsigned int vced_count, vcei_count;
  * space during mmap's.
  */
 #define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 3))
+#define TASK_SIZE_OF(tsk)						\
+	(test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE)
 #endif
 
 #ifdef CONFIG_64BIT
@@ -65,6 +67,8 @@ extern unsigned int vced_count, vcei_count;
 #define TASK_UNMAPPED_BASE						\
 	(test_thread_flag(TIF_32BIT_ADDR) ?				\
 		PAGE_ALIGN(TASK_SIZE32 / 3) : PAGE_ALIGN(TASK_SIZE / 3))
+#define TASK_SIZE_OF(tsk)						\
+	(test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE)
 #endif
 
 #define NUM_FPU_REGS	32

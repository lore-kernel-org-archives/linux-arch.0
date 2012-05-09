From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/6] get rid of extra check for TASK_SIZE in
	get_unmapped_area
Date: Wed, 9 May 2012 17:26:57 +0100
Message-ID: <20120509162657.GC10241@n2100.arm.linux.org.uk>
References: <1336488022-3723-1-git-send-email-murzin.v@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38533 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755557Ab2EIQ1I (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 May 2012 12:27:08 -0400
Content-Disposition: inline
In-Reply-To: <1336488022-3723-1-git-send-email-murzin.v@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vladimir Murzin <murzin.v@gmail.com>
Cc: linux-arch@vger.kernel.org, tglx@linutronix.de, davem@davemloft.net, lethal@linux-sh.org

On Tue, May 08, 2012 at 06:40:16PM +0400, Vladimir Murzin wrote:
> From: Vladimir Murzin <murzin.v@gmail>
> 
> The current get_unmapped_area code calls the f_ops->get_unmapped_area or
> the arch's one (via the mm) only when check for TASK_SIZE is passed. However,
> generic code and some arches do the same check in their a_g_u_a implementation.
> 
> This series of patches fix the check order for TASK_SIZE in archs'
> get_unmapped_area() implementations, and then removes extra check in
> high-level get_unmapped_area().

Do we even need this check in arch code?  AFAICS it's already checked in
get_unmapped_area(), and this will be called prior to any
arch_get_unmapped_area() implementation.  Given that this is a potential
security issue, please check my analysis of this.

unsigned long
get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
		unsigned long pgoff, unsigned long flags)
{
	...
	/* Careful about overflows.. */
	if (len > TASK_SIZE)
		return -ENOMEM;

	get_area = current->mm->get_unmapped_area;
	if (file && file->f_op && file->f_op->get_unmapped_area)
		get_area = file->f_op->get_unmapped_area;

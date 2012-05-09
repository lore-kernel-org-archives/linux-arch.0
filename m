From: Vladimir Murzin <murzin.v@gmail.com>
Subject: Re: [PATCH 0/6] get rid of extra check for TASK_SIZE in
 get_unmapped_area
Date: Wed, 9 May 2012 21:56:03 +0400
Message-ID: <20120509175557.GA2823@pinguin>
References: <1336488022-3723-1-git-send-email-murzin.v@gmail.com>
 <20120509162657.GC10241@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:56583 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754027Ab2EIR63 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 May 2012 13:58:29 -0400
Received: by lahd3 with SMTP id d3so428091lah.19
        for <linux-arch@vger.kernel.org>; Wed, 09 May 2012 10:58:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120509162657.GC10241@n2100.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arch@vger.kernel.org, tglx@linutronix.de, davem@davemloft.net, lethal@linux-sh.org

On Wed, May 09, 2012 at 05:26:57PM +0100, Russell King - ARM Linux wrote:
> On Tue, May 08, 2012 at 06:40:16PM +0400, Vladimir Murzin wrote:
> > From: Vladimir Murzin <murzin.v@gmail>
> > 
> > The current get_unmapped_area code calls the f_ops->get_unmapped_area or
> > the arch's one (via the mm) only when check for TASK_SIZE is passed. However,
> > generic code and some arches do the same check in their a_g_u_a implementation.
> > 
> > This series of patches fix the check order for TASK_SIZE in archs'
> > get_unmapped_area() implementations, and then removes extra check in
> > high-level get_unmapped_area().
> 
> Do we even need this check in arch code?  AFAICS it's already checked in
> get_unmapped_area(), and this will be called prior to any
> arch_get_unmapped_area() implementation.  Given that this is a potential
> security issue, please check my analysis of this.
> 
> unsigned long
> get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
> 		unsigned long pgoff, unsigned long flags)
> {
> 	...
> 	/* Careful about overflows.. */
> 	if (len > TASK_SIZE)
> 		return -ENOMEM;
> 
> 	get_area = current->mm->get_unmapped_area;
> 	if (file && file->f_op && file->f_op->get_unmapped_area)
> 		get_area = file->f_op->get_unmapped_area;

Thanks for analysis.

Most of arches do checking for (len > TASK_SIZE) in their a_g_u_a or in
generic one. However, mips, alpha, sparc and ia64 at least do this
checking in a slightly different way.

So, for arches which use generic implementation or have no any special
case

 	/* Careful about overflows.. */
	if (len > TASK_SIZE)
 		return -ENOMEM;
 
 	get_area = current->mm->get_unmapped_area;

is expanded into

 	/* Careful about overflows.. */
	if (len > TASK_SIZE)
 		return -ENOMEM;
 
 	/* there is arch_get_unmapped_area started */

	if (len > TASK_SIZE)
 		return -ENOMEM;

 	/* other stuff in arch_get_unmapped_area */

On the other hand, for arches which have to handle special case for
length checking test for (len > TASK_SIZE) has no sense.

To avoid security issue checking for length should be done
first. Unfortunately, not all arches follow this rule and test in
get_unmapped_area() doesn't cover some cases. For instanse, sparc32 do
checking like

unsigned long arch_get_unmapped_area(struct file *filp, unsigned long
 addr, unsigned long len, unsigned long pgoff, unsigned long flags)
{
        struct vm_area_struct * vmm;

        if (flags & MAP_FIXED) {
                /* We do not accept a shared mapping if it would violate
                 * cache aliasing constraints.
                 */
                if ((flags & MAP_SHARED) &&
                    ((addr - (pgoff << PAGE_SHIFT)) & (SHMLBA - 1)))
                        return -EINVAL;
                return addr;
        }

        /* See asm-sparc/uaccess.h */
        if (len > TASK_SIZE - PAGE_SIZE)
                return -ENOMEM;

...

It seems we could be successful in request a page at fixed address
(TASK_SIZE - PAGE_SIZE) despite the fact that it isn't desirable.

Best wishes
Vladimir Murzin

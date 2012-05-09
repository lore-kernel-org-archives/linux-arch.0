From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/6] get rid of extra check for TASK_SIZE in
	get_unmapped_area
Date: Wed, 9 May 2012 19:07:01 +0100
Message-ID: <20120509180701.GE10241@n2100.arm.linux.org.uk>
References: <1336488022-3723-1-git-send-email-murzin.v@gmail.com> <20120509162657.GC10241@n2100.arm.linux.org.uk> <20120509175557.GA2823@pinguin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49346 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221Ab2EISHK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 May 2012 14:07:10 -0400
Content-Disposition: inline
In-Reply-To: <20120509175557.GA2823@pinguin>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vladimir Murzin <murzin.v@gmail.com>
Cc: linux-arch@vger.kernel.org, tglx@linutronix.de, davem@davemloft.net, lethal@linux-sh.org

On Wed, May 09, 2012 at 09:56:03PM +0400, Vladimir Murzin wrote:
> On Wed, May 09, 2012 at 05:26:57PM +0100, Russell King - ARM Linux wrote:
> > On Tue, May 08, 2012 at 06:40:16PM +0400, Vladimir Murzin wrote:
> > > From: Vladimir Murzin <murzin.v@gmail>
> > > 
> > > The current get_unmapped_area code calls the f_ops->get_unmapped_area or
> > > the arch's one (via the mm) only when check for TASK_SIZE is passed. However,
> > > generic code and some arches do the same check in their a_g_u_a implementation.
> > > 
> > > This series of patches fix the check order for TASK_SIZE in archs'
> > > get_unmapped_area() implementations, and then removes extra check in
> > > high-level get_unmapped_area().
> > 
> > Do we even need this check in arch code?  AFAICS it's already checked in
> > get_unmapped_area(), and this will be called prior to any
> > arch_get_unmapped_area() implementation.  Given that this is a potential
> > security issue, please check my analysis of this.
> > 
> > unsigned long
> > get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
> > 		unsigned long pgoff, unsigned long flags)
> > {
> > 	...
> > 	/* Careful about overflows.. */
> > 	if (len > TASK_SIZE)
> > 		return -ENOMEM;
> > 
> > 	get_area = current->mm->get_unmapped_area;
> > 	if (file && file->f_op && file->f_op->get_unmapped_area)
> > 		get_area = file->f_op->get_unmapped_area;
> 
> Thanks for analysis.
> 
> Most of arches do checking for (len > TASK_SIZE) in their a_g_u_a or in
> generic one. However, mips, alpha, sparc and ia64 at least do this
> checking in a slightly different way.

I think you missed what I said above.  I think get_unmapped_area() gets
called, which _then_ calls into arch_get_unmapped_area() or some alternative
replacement.  I also think that nothing other than get_unmapped_area()
ultimately calls through to arch_get_unmapped_area().

So if get_unmapped_area() is doing:

	/* Careful about overflows.. */
	if (len > TASK_SIZE)
		return -ENOMEM;

_before_ it passes control to arch_get_unmapped_area(), is there any point
arch_get_unmapped_area() duplicating this exact same check?

Can't we just delete all these duplicate checks in arch_get_unmapped_area()
and be done with it, because...

> So, for arches which use generic implementation or have no any special
> case
> 
>  	/* Careful about overflows.. */
> 	if (len > TASK_SIZE)
>  		return -ENOMEM;
>  
>  	get_area = current->mm->get_unmapped_area;
> 
> is expanded into
> 
>  	/* Careful about overflows.. */
> 	if (len > TASK_SIZE)
>  		return -ENOMEM;
>  
>  	/* there is arch_get_unmapped_area started */
> 
> 	if (len > TASK_SIZE)
>  		return -ENOMEM;
> 
>  	/* other stuff in arch_get_unmapped_area */

... having that second check there is pointless.

> On the other hand, for arches which have to handle special case for
> length checking test for (len > TASK_SIZE) has no sense.
> 
> To avoid security issue checking for length should be done
> first. Unfortunately, not all arches follow this rule and test in
> get_unmapped_area() doesn't cover some cases.

But does it matter?  get_unmapped_area() has already checked 'len' and
would have failed if this was larger than TASK_SIZE already.

> For instanse, sparc32 do checking like
> 
> unsigned long arch_get_unmapped_area(struct file *filp, unsigned long
>  addr, unsigned long len, unsigned long pgoff, unsigned long flags)
> {
>         struct vm_area_struct * vmm;
> 
>         if (flags & MAP_FIXED) {
>                 /* We do not accept a shared mapping if it would violate
>                  * cache aliasing constraints.
>                  */
>                 if ((flags & MAP_SHARED) &&
>                     ((addr - (pgoff << PAGE_SHIFT)) & (SHMLBA - 1)))
>                         return -EINVAL;
>                 return addr;
>         }
> 
>         /* See asm-sparc/uaccess.h */
>         if (len > TASK_SIZE - PAGE_SIZE)
>                 return -ENOMEM;

Where an arch does a different check (eg, and it is a smaller size) then
yes, there could be a problem.

But for all those which duplicate the:

	if (len > TASK_SIZE)
		return -ENOMEM;

check, it seems totally pointless to have that code in the arch function,
and I think we should be deleting that from the arch functions.

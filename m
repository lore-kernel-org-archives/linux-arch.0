From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: + separate-atomic_t-declaration-from-asm-atomich-into-asm-atomic_defh.patch added to -mm tree
Date: Fri, 29 Aug 2008 17:34:16 -0600
Message-ID: <20080829233416.GC1239@parisc-linux.org>
References: <200808222056.m7MKucHA016131@imap1.linux-foundation.org> <20080822213624.GX8318@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:48340 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755356AbYH2Xed (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 29 Aug 2008 19:34:33 -0400
Content-Disposition: inline
In-Reply-To: <20080822213624.GX8318@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, ying.huang@intel.com, linux-arch@vger.kernel.org


I see you're fixing up the original patch without commenting on this at
all.

On Fri, Aug 22, 2008 at 03:36:25PM -0600, Matthew Wilcox wrote:
> On Fri, Aug 22, 2008 at 01:56:38PM -0700, akpm@linux-foundation.org wrote:
> > Subject: Separate atomic_t declaration from asm/atomic.h into asm/atomic_def.h
> > From: Huang Ying <ying.huang@intel.com>
> > 
> > asm/atomic.h contains both declaration and implementation of atomic_t.  So
> > there are some implementation related files included in asm/atomic.h.  And
> > atomic_t is a typedef.  Combination of above makes it impossible to use
> > atomic_t in files included by atomic.h.  Such as atomic_t can not be used
> > in linux/kernel.h on i386, because it is included by asm/atomic.h.
> > 
> > It is reasonable to separate declaration from implementation.  So a new
> > file atomic_def.h is added for every architecture to accommodate the
> > declaration of atomic_t.
> 
> Seems to me like all architectures could use:
> 
> +++ include/linux/atomic_type.h
> +typedef struct { volatile int counter; } atomic_t;
> +#ifdef CONFIG_64BIT
> +typedef struct { volatile long counter; } atomic64_t;
> +#endif
> 
> S390 has an __aligned__((4)) on theirs -- is this really necessary?
> Doesn't s390 align ints to 4 bytes automatically?  If it doesn't, it
> shouldn't be harmful to add it to other architectures (iirc m68k only
> requires 2-byte alignment for ints ... hmm, wonder if their atomic_t is
> really atomic if, say, it cross a page boundary ...)
> 
> -- 
> Matthew Wilcox				Intel Open Source Technology Centre
> "Bill, look, we understand that you're interested in selling us this
> operating system, but compare it to ours.  We can't possibly take such
> a retrograde step."
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."

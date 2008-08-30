From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: +
 separate-atomic_t-declaration-from-asm-atomich-into-asm-atomic_defh.patch
 added to -mm tree
Date: Fri, 29 Aug 2008 17:19:36 -0700
Message-ID: <20080829171936.f5f8b53d.akpm@linux-foundation.org>
References: <200808222056.m7MKucHA016131@imap1.linux-foundation.org>
	<20080822213624.GX8318@parisc-linux.org>
	<20080829233416.GC1239@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58646 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750842AbYH3ATj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 29 Aug 2008 20:19:39 -0400
In-Reply-To: <20080829233416.GC1239@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: ying.huang@intel.com, linux-arch@vger.kernel.org

On Fri, 29 Aug 2008 17:34:16 -0600
Matthew Wilcox <matthew@wil.cx> wrote:

> 
> I see you're fixing up the original patch without commenting on this at
> all.

Sob.  I'm just slogging away trying to get my tree to compile.

One more build error and I drop it all.

> On Fri, Aug 22, 2008 at 03:36:25PM -0600, Matthew Wilcox wrote:
> > On Fri, Aug 22, 2008 at 01:56:38PM -0700, akpm@linux-foundation.org wrote:
> > > Subject: Separate atomic_t declaration from asm/atomic.h into asm/atomic_def.h
> > > From: Huang Ying <ying.huang@intel.com>
> > > 
> > > asm/atomic.h contains both declaration and implementation of atomic_t.  So
> > > there are some implementation related files included in asm/atomic.h.  And
> > > atomic_t is a typedef.  Combination of above makes it impossible to use
> > > atomic_t in files included by atomic.h.  Such as atomic_t can not be used
> > > in linux/kernel.h on i386, because it is included by asm/atomic.h.
> > > 
> > > It is reasonable to separate declaration from implementation.  So a new
> > > file atomic_def.h is added for every architecture to accommodate the
> > > declaration of atomic_t.
> > 
> > Seems to me like all architectures could use:
> > 
> > +++ include/linux/atomic_type.h
> > +typedef struct { volatile int counter; } atomic_t;
> > +#ifdef CONFIG_64BIT
> > +typedef struct { volatile long counter; } atomic64_t;
> > +#endif
> > 
> > S390 has an __aligned__((4)) on theirs -- is this really necessary?
> > Doesn't s390 align ints to 4 bytes automatically?  If it doesn't, it
> > shouldn't be harmful to add it to other architectures (iirc m68k only
> > requires 2-byte alignment for ints ... hmm, wonder if their atomic_t is
> > really atomic if, say, it cross a page boundary ...)
> > 

Sounds right to me.

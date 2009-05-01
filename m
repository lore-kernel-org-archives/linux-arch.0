From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH 34/35] powerpc use generic ptemap.h
Date: Fri, 01 May 2009 10:58:40 -0700
Message-ID: <1241200721.29485.202.camel@nimitz>
References: <20090501144201.D31EF417@kernel>
	 <20090501144254.52127677@kernel>  <20090501174617.GB8104@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146]:46053 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754804AbZEAR6n (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 1 May 2009 13:58:43 -0400
In-Reply-To: <20090501174617.GB8104@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2009-05-01 at 13:46 -0400, Christoph Hellwig wrote:
> On Fri, May 01, 2009 at 07:42:54AM -0700, Dave Hansen wrote:
 
> > powerpc is a bid of an oddball here.  It seems to have CONFIG_HIGHPTE
> > behavior at all times when compiled as 32-bit.  There's even an
> > #ifdef CONFIG_HIGHPTE in arch/powerpc/mm/pgtable_32.c, but there's no
> > trace of HIGHPTE in Kconfig anywhere.
> > 
> > This gives ppc32 an explicit HIGHPTE in Kconfig so that we can use
> > the #ifdef in asm-generic/ptemap.h and let ppc use the generic code
> > with x86 and frv.
> 
> But if you enabled HIGHPTE you need to remove that ifdef in pgtable_32.c
> because it didn't get triggered before.

OK, that makes sense.

> >  #define _POWERPC_ASM_PTEMAP_H
> >  
> >  #ifndef __powerpc64__
> > +/*
> > + * This lets us use the x86 implementation
> > + * in the generic ptemap.h
> > + */
> > +#define kmap_atomic_pte(page, type) kmap_atomic(page, type)
> > +#endif
> 
> That comment doesn't make any sense to me, x86 should have nothing to do
> with it.  Also the comment would comfortably fit into a single line
> instead of two.

You're right, that is more of a changelog thing.  I'll fix it up.

-- Dave

Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:48577 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756702AbYC1Dbw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 27 Mar 2008 23:31:52 -0400
Date: Fri, 28 Mar 2008 04:31:50 +0100
From: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch 1/2]: x86: implement pte_special
Message-ID: <20080328033149.GD8083@wotan.suse.de>
References: <20080328025455.GA8083@wotan.suse.de> <20080328025541.GB8083@wotan.suse.de> <20080327.202334.250213398.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080327.202334.250213398.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: akpm@linux-foundation.org, shaggy@austin.ibm.com, axboe@oracle.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org
Message-ID: <20080328033150.JjGj5OTgsy8EWCUbJFSszv_ozXk3u2Gn23TMeAePac0@z>

On Thu, Mar 27, 2008 at 08:23:34PM -0700, David Miller wrote:
> From: Nick Piggin <npiggin@suse.de>
> Date: Fri, 28 Mar 2008 03:55:41 +0100
> 
> > @@ -40,6 +41,8 @@
> >  #define _PAGE_UNUSED3	(_AC(1, L)<<_PAGE_BIT_UNUSED3)
> >  #define _PAGE_PAT	(_AC(1, L)<<_PAGE_BIT_PAT)
> >  #define _PAGE_PAT_LARGE (_AC(1, L)<<_PAGE_BIT_PAT_LARGE)
> > +#define _PAGE_SPECIAL	(_AC(1, L)<<_PAGE_BIT_SPECIAL)
> > +#define __HAVE_ARCH_PTE_SPECIAL
> 
> What tests __HAVE_ARCH_PTE_SPECIAL?
> 
> > @@ -167,7 +170,7 @@ static inline pte_t pte_mkhuge(pte_t pte
> >  static inline pte_t pte_clrhuge(pte_t pte)	{ return __pte(pte_val(pte) & ~(pteval_t)_PAGE_PSE); }
> >  static inline pte_t pte_mkglobal(pte_t pte)	{ return __pte(pte_val(pte) | _PAGE_GLOBAL); }
> >  static inline pte_t pte_clrglobal(pte_t pte)	{ return __pte(pte_val(pte) & ~(pteval_t)_PAGE_GLOBAL); }
> > -static inline pte_t pte_mkspecial(pte_t pte)	{ return pte; }
> > +static inline pte_t pte_mkspecial(pte_t pte)	{ return __pte(pte_val(pte) | _PAGE_SPECIAL); }
> 
> And what calls pte_mkspecial?
> 
> I don't see any code that sets the special bit anywhere
> in these two patches.
> 
> What am I missing?

Oh, sorry these 2 patches are on top of the previous 7 that I sent out.
Hmm, only patch 2/7 went to linux-arch, which is the main consumer of
this pte_special stuff, however if you want a more coherent view of those
7 patches, they are on linux-mm.

Basically, the pfn-based mapping insertion (vm_insert_pfn, remap_pfn_range)
calls pte_mkspecial. And that tells fast_gup "hands off".


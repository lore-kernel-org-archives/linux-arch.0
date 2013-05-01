From: Steve Capper <steve.capper@linaro.org>
Subject: Re: [RFC PATCH 7/9] ARM64: mm: HugeTLB support.
Date: Wed, 1 May 2013 14:04:03 +0100
Message-ID: <20130501130401.GA21923@linaro.org>
References: <1367339448-21727-1-git-send-email-steve.capper@linaro.org>
 <1367339448-21727-8-git-send-email-steve.capper@linaro.org>
 <20130501114238.GG22796@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:63247 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753899Ab3EANEO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 1 May 2013 09:04:14 -0400
Received: by mail-wi0-f176.google.com with SMTP id hi8so2640465wib.15
        for <linux-arch@vger.kernel.org>; Wed, 01 May 2013 06:04:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130501114238.GG22796@mudshark.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michal Hocko <mhocko@suse.cz>, Ken Chen <kenchen@google.com>, Mel Gorman <mgorman@suse.de>, Catalin Marinas <Catalin.Marinas@arm.com>

On Wed, May 01, 2013 at 12:42:38PM +0100, Will Deacon wrote:
> Hi Steve,
> 
> On Tue, Apr 30, 2013 at 05:30:46PM +0100, Steve Capper wrote:
> > Add huge page support to ARM64, different huge page sizes are
> > supported depending on the size of normal pages:
> > 
> > PAGE_SIZE is 4K:
> >    2MB - (pmds) these can be allocated at any time.
> > 1024MB - (puds) usually allocated on bootup with the command line
> >          with something like: hugepagesz=1G hugepages=6
> > 
> > PAGE_SIZE is 64K:
> >  512MB - (pmds), usually allocated on bootup via command line.
> 
> [...]
> 
> > diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> > index 75fd13d..c3cac68 100644
> > --- a/arch/arm64/include/asm/pgtable-hwdef.h
> > +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> > @@ -53,6 +53,7 @@
> >  #define PTE_TYPE_MASK		(_AT(pteval_t, 3) << 0)
> >  #define PTE_TYPE_FAULT		(_AT(pteval_t, 0) << 0)
> >  #define PTE_TYPE_PAGE		(_AT(pteval_t, 3) << 0)
> > +#define PTE_TYPE_HUGEPAGE	(_AT(pmdval_t, 1) << 0)
> 
> This breaks PROT_NONE mappings, where you get:
> 
> 	pte = pte_mkhuge(pte_modify(pte, newprot));
> 
> The pte_modify will clear the valid bit and set the prot_none bit (in order
> to create a present, faulting entry) but then your pte_mkhuge will come in
> and clobber that with a valid block entry.

Thanks Will, I'll re-work the pte_mkhuge/pte_huge logic and get a PROT_NONE
test case coded up.

Cheers,
-- 
Steve

> 
> Will

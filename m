Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ea0-f177.google.com ([209.85.215.177]:60840 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753843Ab3EQIlf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 17 May 2013 04:41:35 -0400
Received: by mail-ea0-f177.google.com with SMTP id q14so2156025eaj.8
        for <linux-arch@vger.kernel.org>; Fri, 17 May 2013 01:41:34 -0700 (PDT)
Date: Fri, 17 May 2013 09:41:25 +0100
From: Steve Capper <steve.capper@linaro.org>
Subject: Re: [RFC PATCH v2 09/11] ARM64: mm: HugeTLB support.
Message-ID: <20130517084124.GA22241@linaro.org>
References: <1368006763-30774-1-git-send-email-steve.capper@linaro.org>
 <1368006763-30774-10-git-send-email-steve.capper@linaro.org>
 <20130516143236.GD18308@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130516143236.GD18308@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michal Hocko <mhocko@suse.cz>, Ken Chen <kenchen@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <Will.Deacon@arm.com>, "patches@linaro.org" <patches@linaro.org>
Message-ID: <20130517084125.Z1zNu5Wn0ks7VUvF9hVxK-X9euxqDV9j4_BmspHpz0c@z>

On Thu, May 16, 2013 at 03:32:36PM +0100, Catalin Marinas wrote:
> On Wed, May 08, 2013 at 10:52:41AM +0100, Steve Capper wrote:
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/hugetlb.h
> ...
> > +static inline int pud_large(pud_t pud)
> > +{
> > +	return !(pud_val(pud) & PUD_TABLE_BIT);
> > +}
> 
> I already commented on this - do we really need pud_large() which is
> the same as pud_huge()? It's only defined on x86 and can be safely
> replaced with pud_huge().
> 

Thanks, yes, sorry this one slipped through the cracks.
I'll update this to use pud_huge.

> > --- /dev/null
> > +++ b/arch/arm64/mm/hugetlbpage.c
> > @@ -0,0 +1,70 @@
> ...
> > +int pmd_huge(pmd_t pmd)
> > +{
> > +	return !(pmd_val(pmd) & PMD_TABLE_BIT);
> > +}
> > +
> > +int pud_huge(pud_t pud)
> > +{
> > +	return !(pud_val(pud) & PUD_TABLE_BIT);
> > +}
> 
> You could even go further and make pud/pmd_huge static inline functions
> for slightly better efficiency (needs changing in the linux/hugetlb.h
> header).

I'll have to have a think about this and a tinker :-). 

Cheers,
-- 
Steve

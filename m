From: Steve Capper <steve.capper@linaro.org>
Subject: Re: ARM: add support to dump the kernel page tables
Date: Thu, 24 Oct 2013 17:25:43 +0100
Message-ID: <20131024162542.GA32124@linaro.org>
References: <20131024071600.GC16735@n2100.arm.linux.org.uk>
 <20131024105143.GA24288@linaro.org>
 <20131024122306.GK16735@n2100.arm.linux.org.uk>
 <20131024125530.GA27357@linaro.org>
 <20131024154956.GN16735@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:38523 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755695Ab3JXQZu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 Oct 2013 12:25:50 -0400
Received: by mail-wi0-f177.google.com with SMTP id h11so2837125wiv.4
        for <linux-arch@vger.kernel.org>; Thu, 24 Oct 2013 09:25:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20131024154956.GN16735@n2100.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org

On Thu, Oct 24, 2013 at 04:49:56PM +0100, Russell King - ARM Linux wrote:
> On Thu, Oct 24, 2013 at 01:55:31PM +0100, Steve Capper wrote:
> > On Thu, Oct 24, 2013 at 01:23:06PM +0100, Russell King - ARM Linux wrote:
> > > On Thu, Oct 24, 2013 at 11:51:44AM +0100, Steve Capper wrote:
> > > > Hi Russell,
> > > > I've given this a quick go on an Arndale with LPAE, and have a few
> > > > suggestions below.
> > > 
> > > Thanks.
> > > 
> > > > > diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
> > > > > index 5689c18..d7682cd 100644
> > > > > --- a/arch/arm/include/asm/pgtable-3level.h
> > > > > +++ b/arch/arm/include/asm/pgtable-3level.h
> > > > > @@ -140,6 +140,7 @@
> > > > >  						 PMD_TYPE_TABLE)
> > > > >  #define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
> > > > >  						 PMD_TYPE_SECT)
> > > > > +#define pmd_large(pmd)		pmd_sect(pmd)
> > > > 
> > > > Could we please instead do something like:
> > > > #define pmd_large(pmd)         (pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))
> > > > 
> > > > This matches the logic used in the huge pages patches (it picks up the
> > > > PROT_NONE case) that would be missed above.
> > > 
> > > Is this used in the generic parts of the kernel?  Can you please point
> > > out where?
> > > 
> > 
> > Apologies I was a little vague. I don't think there are any PROT_NONE
> > protected kernel huge pages, I am worried that pmd_huge may be used by
> > other code (and then run into problems with PROT_NONE).
> 
[I erroneously referred to pmd_huge here, I meant pmd_large sorry].

> Well, the obvious question is: why would you want pmd_large() to return
> false if there is a section entry in place?

Hi,
for LPAE:
I want pmd_large to return true for all non-zero pmds that have bit #1
clear.
 
Clearing bit #0 of a pmd produces a faulting entry, and this is how
PROT_NONE protection is enforced by huge pages.

pmd_sect will return false for non-zero pmds that have both bit #0 and
bit #1 clear, thus will return false for some huge pages.

Cheers,
-- 
Steve

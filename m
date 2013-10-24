Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41637 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755390Ab3JXPuh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 Oct 2013 11:50:37 -0400
Date: Thu, 24 Oct 2013 16:49:56 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: ARM: add support to dump the kernel page tables
Message-ID: <20131024154956.GN16735@n2100.arm.linux.org.uk>
References: <20131024071600.GC16735@n2100.arm.linux.org.uk> <20131024105143.GA24288@linaro.org> <20131024122306.GK16735@n2100.arm.linux.org.uk> <20131024125530.GA27357@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131024125530.GA27357@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Message-ID: <20131024154956.7UGSA7ttQTWSjwIf6idhOP7dyfplohTjl0P5qK8moeE@z>

On Thu, Oct 24, 2013 at 01:55:31PM +0100, Steve Capper wrote:
> On Thu, Oct 24, 2013 at 01:23:06PM +0100, Russell King - ARM Linux wrote:
> > On Thu, Oct 24, 2013 at 11:51:44AM +0100, Steve Capper wrote:
> > > Hi Russell,
> > > I've given this a quick go on an Arndale with LPAE, and have a few
> > > suggestions below.
> > 
> > Thanks.
> > 
> > > > diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
> > > > index 5689c18..d7682cd 100644
> > > > --- a/arch/arm/include/asm/pgtable-3level.h
> > > > +++ b/arch/arm/include/asm/pgtable-3level.h
> > > > @@ -140,6 +140,7 @@
> > > >  						 PMD_TYPE_TABLE)
> > > >  #define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
> > > >  						 PMD_TYPE_SECT)
> > > > +#define pmd_large(pmd)		pmd_sect(pmd)
> > > 
> > > Could we please instead do something like:
> > > #define pmd_large(pmd)         (pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))
> > > 
> > > This matches the logic used in the huge pages patches (it picks up the
> > > PROT_NONE case) that would be missed above.
> > 
> > Is this used in the generic parts of the kernel?  Can you please point
> > out where?
> > 
> 
> Apologies I was a little vague. I don't think there are any PROT_NONE
> protected kernel huge pages, I am worried that pmd_huge may be used by
> other code (and then run into problems with PROT_NONE).

Well, the obvious question is: why would you want pmd_large() to return
false if there is a section entry in place?

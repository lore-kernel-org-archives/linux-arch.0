Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:22575 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751437AbWHDSo2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 4 Aug 2006 14:44:28 -0400
Received: by nf-out-0910.google.com with SMTP id x37so1146088nfc
        for <linux-arch@vger.kernel.org>; Fri, 04 Aug 2006 11:44:27 -0700 (PDT)
Message-ID: <1defaf580608041144q9eca2c6tb9ef8c4ad9293a39@mail.gmail.com>
Date: Fri, 4 Aug 2006 20:44:23 +0200
From: "=?ISO-8859-1?Q?H=E5vard_Skinnemoen?=" <hskinnemoen@gmail.com>
Subject: Re: [RFC] Generic ioremap_page_range
In-Reply-To: <1154711905.10109.25.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
	 <1152892123.24925.67.camel@localhost.localdomain>
	 <20060804094700.40a63a78@cad-250-152.norway.atmel.com>
	 <1154711905.10109.25.camel@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On 8/4/06, Dave Hansen <haveblue@us.ibm.com> wrote:
> On Fri, 2006-08-04 at 09:47 +0200, Haavard Skinnemoen wrote:
> > There's one difference between the generic ioremap_page_range and the
> > i386 version: it takes a pgprot_t argument instead of unsigned long
> > flags, meaning that the arch-specific ioremap() implementation must
> > set all pte flags before calling ioremap_page_range() instead of
> > in the lowest-level page remapping function.
>
> It looks like they were pretty static before, anyway.  I guess, in the
> worst case, you could make a weak symbol in lib/ioremap.c that does
> arch_ioremap_pgprot().  If an architecture needs to do something
> special, they could override it.

So far, I've only seen static flags. And I really can't think of a
reason to set the flags dynamically...

> But, unless this is causing real problems, I don't see any serious
> reason to do it.  It can wail until we actually run into a user that
> needs it.

If anyone does something clever with the pgprot flags, I'm pretty sure
I'll notice it when converting the architecture. Or if I don't, the
arch maintainer surely will...?

> In any case, vmalloc() apparently does something very close to what you
> need, and it does what you suggest: use flush_cache_vmap(), intends to
> only work on pte_none() ptes, and doesn't call a tlb flush function
> afterwords.  Unless there is something to differentiate ioremap's
> functionality (say, the random pte flags you can set with ioremap) I
> can't think of why ioremap is different.

In fact, ARM does it exactly this way. I think I'll try changing it
and see if any arch maintainers complain.

> BTW, does this new generic ioremap code work on _your_ architecture? ;)
> Have you done a quick survey to see how many other architectures can use
> it?

Yes, it works on AVR32. In fact, the old code was broken, and simply
copying the i386 code fixed it. ioremap() on AVR32 is usually a no-op,
so I had to short-circuit some optimizations in order to test it...

From a quick glance, it looks like the generic version should work on
alpha, arm, avr32, cris, i386, m32r, mips, parisc, s390, sh, sh64 and
x86_64. The rest are either no-ops or something weird (powerpc, m68k,
sparc).

Haavard

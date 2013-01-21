From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 28/76] ARC: I/O and DMA Mappings
Date: Mon, 21 Jan 2013 14:26:26 +0000
Message-ID: <201301211426.26839.arnd@arndb.de>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com> <201301181555.43487.arnd@arndb.de> <50FD36CF.1000702@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:54948 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497Ab3AUO0d (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jan 2013 09:26:33 -0500
In-Reply-To: <50FD36CF.1000702@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 21 January 2013, Vineet Gupta wrote:
> On Friday 18 January 2013 09:25 PM, Arnd Bergmann wrote:
> > ...
> So the comment above can be deleted, and we probably need a check in
> ioremap_prot() so that early ioremap bails out if called early - probably using
> slab_is_available()

Ok.

> >> +#include <asm-generic/io.h>
> > I think I commented before that asm-generic/io.h has a number of
> > problems and you should at least override the __raw_{read,write}{b,w,l,q}
> > functions with your own ones using inline assembly.
> >
> > You should also define a non-NULL PCI_IOBASE.
> 
> Sorry for missing out on this one - this was indeed suggested in the private
> pre-list review you did. The 64-bit version certainly needs to be wrapped in a irq
> safe block.
> 
> However others will be exactly same as generic ones. Given that these routines
> operate on __iomem memory which has to be uncached: either wired in uncached
> address space, or goes via an uncached MMU mapping, IMHO the inline-asm or 'C'
> version won't add any value. We do have uncached LD/ST, I've tried to avoid them
> so far as they have certain micro-architectural quirks and per previous argument
> it seems they would be redundant.
> 
> Having said that I might be over-looking something important - so please let me know.

We just moved ARM to use inline assembly versions here, because there were bugs
with some gcc versions and undefined C code in the kernel using 'packed' pointers,
as well as problems in KVM interpreting the memory accessor instructions. I would
definetely recommend doing inline assembly for these on all architectures to spare
you trouble later.

	Arnd

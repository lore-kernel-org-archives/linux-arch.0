Return-Path: <James.Bottomley@SteelEye.com>
Received: from stat1.steeleye.com ([65.114.3.130]:16597 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265151AbUFRXni (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 18 Jun 2004 19:43:38 -0400
Subject: Re: Accessing memory remote across the bus in the same way as local
	memory
From: James Bottomley <James.Bottomley@SteelEye.com>
In-Reply-To: <20040618163243.26d9fcb3.davem@redhat.com>
References: <1087601198.2134.206.camel@mulgrave>
	<20040618163243.26d9fcb3.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 18 Jun 2004 18:43:31 -0500
Message-Id: <1087602212.2078.218.camel@mulgrave>
Mime-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2004-06-18 at 18:32, David S. Miller wrote:
> There are three issues:

Oh, yes, I know this isn't easy, it would be an absolute pig on parisc
too because we use absloute instruction accesses currently to MMIO
space...if we start remapping pieces we end up with cache aliasing
issues.

But what I'm more concerned about is is there a basic show stopper that
would prevent a platform from doing this?

> 1) How to form the physical address (for a PCI device we have PCI device
>    pointer and resource, stuff like that, we just need a translator
>    interface or similar to pass that info in)

That's really something the DMA API does well today.  I think as part of
the implementation, we'd just have the device register the area and its
own internal address for it.

> 2) Whether such accesses are legal.  On Sparc64 one device cannot DMA
>    to/from the MMIO of a device behind a _DIFFERENT_ PCI controller.

Yes, this one could be tricky: no using the memory you obtained for DMA
to or from anything other than this one device.

> 3) Some logic to get page table non-cacheable bits set etc. since this
>    is to non-memory space.

This would be up to the platform piece of the API to sort out, I think.

I'm not anywhere close to proposing this, I'm just exploring the
possibility at the moment.  I'm still arguing "no" in the DMA API
thread...

James

Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:34189
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751122AbWCSWB1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 19 Mar 2006 17:01:27 -0500
Date: Sun, 19 Mar 2006 14:01:24 -0800 (PST)
Message-Id: <20060319.140124.69326977.davem@davemloft.net>
Subject: Re: Potential problem with the page_mapping macro and
 flush_dcache_page()
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1142803783.3240.64.camel@mulgrave.il.steeleye.com>
References: <1142802286.3240.54.camel@mulgrave.il.steeleye.com>
	<20060319.132511.116548328.davem@davemloft.net>
	<1142803783.3240.64.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: James.Bottomley@steeleye.com
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: James Bottomley <James.Bottomley@SteelEye.com>
Date: Sun, 19 Mar 2006 15:29:43 -0600

> On Sun, 2006-03-19 at 13:25 -0800, David S. Miller wrote:
> > This is exactly what Sparc64's caches are too, L1 D-cache is virtually
> > indexed and physically tagged.  But any bus coherency transaction will
> > update all lines with matching physical tags, otherwise things just
> > won't work.
> 
> I'm afraid ours don't.  The reason is that parisc caches are huge
> (around a megabyte), so you have to specify a coherence index (which is
> effectively the virtual index) to the IOMMU on DMA transactions and
> that's the only line it flushes (as long as the physical tags match).

I don't dispute how the parisc cache behaves, you know that better
than me, but I do want to know what in the world does the size of the
cache have to do with deciding whether to design the hardware to flush
all the matching lines or not?

It's a CAM lookup on bus snoop.  That can search all physical tags in
one CAM cycle, which will thus set the invalid bit on all matching
cache lines regardless of virtual index.

How is a virtual address getting into this equation at all?  The IOMMU
sits on some other bus agent such as the PCI controller, right?  So
coherency transactions, even if translated by the IOMMU from a PCI bus
virtual address to a physical main memory address, looks like a
physical address cache transation to the cpu caches on a bus snoop.

What am I missing?

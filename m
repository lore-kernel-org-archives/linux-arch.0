Return-Path: <James.Bottomley@SteelEye.com>
Received: from stat1.steeleye.com ([65.114.3.130]:28128 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265725AbUFSODB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 19 Jun 2004 10:03:01 -0400
Subject: Re: Accessing memory remote across the bus in the same way as local
	memory
From: James Bottomley <James.Bottomley@SteelEye.com>
In-Reply-To: <16595.48028.925656.212915@cargo.ozlabs.ibm.com>
References: <1087601198.2134.206.camel@mulgrave>
	<16595.48028.925656.212915@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 19 Jun 2004 09:02:56 -0500
Message-Id: <1087653778.2121.29.camel@mulgrave>
Mime-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2004-06-18 at 23:05, Paul Mackerras wrote:
> Not on iSeries machines (ppc64 machines running OS/400).  There we
> have to do a hypervisor call for every access to PCI memory or I/O
> space, unfortunately.  Fortunately people don't tend to put arbitrary
> PCI adaptors in iSeries boxes, and they don't run X servers.  Linux
> partitions on iSeries machines are mostly used for things like
> firewalls and web servers.

Heh, I guessed there'd be one architecture that couldn't do this.

> What did you want to be able to do this for?  It probably isn't the
> end of the world if whatever you want to do with this doesn't work on
> iSeries.

The basic issue is can we declare memory that resides on a device chip
(or on a memory controller behind a PCI bridge) to the system so that it
can be used almost identically to real memory (just with a bunch of
restrictions).

The request is coming from an ARM developer who has an OHCI chip with 32
on chip sram.  He wants dma_alloc_coherent() to hand out the on-chip
memory so that he doesn't have to modify the generic OHCI driver to be
able to use a separate memory area.

However, most modern devices seem to come with on-board memory for
descriptors, ring buffers and the like (mainly for efficiency since the
device can access them without having to do a bus to main memory
transaction), so I was wondering if allocating from this on-board pool
could be folded into the DMA API so that dma_alloc_coherent() could
manage it for every such device.

James

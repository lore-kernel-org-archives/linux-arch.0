Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from colo.lackof.org ([198.49.126.79]:29643 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1750761AbWJVTDx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 22 Oct 2006 15:03:53 -0400
Date: Sun, 22 Oct 2006 13:03:51 -0600
From: Grant Grundler <grundler@parisc-linux.org>
Subject: Re: RFC: rewrite Documentation/pci.txt v3
Message-ID: <20061022190351.GA10599@colo.lackof.org>
References: <20061021071436.GA29248@colo.lackof.org> <200610211455.29837.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610211455.29837.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Grant Grundler <grundler@parisc-linux.org>, Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>, linux-pci@atrey.karlin.mff.cuni.cz, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

Andi,
Thanks for the feedback.

One contentious issue you didn't mention was ordering of
when to call pci_request_region() and  pci_enable_device().

I've been thinking about it and I think the API design is just
broken right now.  We shouldn't need pci_request_resource() at all.
If pci_enable_device() is expected to allocate requested resource
types (MMIO vs IO Port) when BIOS does not, then it should also
reserve resources when BIOS or some other code did the allocation.

For "normal" PCI BARs,  something like:
	pci_enable_device(pdev,resource_type_mask_to_enable);
	dev->base = ioremap_nocache(pdev, pci_resource(xxx));

should be sufficient. Or am I missing something?

I'm sure MMIO/IO Port resources NOT described by PCI config space can
be described by generic request_resource() (note the lack of "pci_").


On Sat, Oct 21, 2006 at 02:55:29PM +0200, Andi Kleen wrote:
> On Saturday 21 October 2006 09:14, Grant Grundler wrote:
> 
> I think you should add a note somewhere that the driver
> should be prepared to initialize the device from any
> state it put it in before. That is important for kexec
> which tries to reinit the drivers after a crash.

Yes, I agree - also so the driver can run under different
types of BIOS (different architectures).
I'll think about it more.

> And add a reference to kerneldoc somewhere too? There
> is some PCI documentation in there (although it probably
> could need some overall editing) 

I need more specific guidance on this.

> > 3.2 Set the DMA mask size
> > ~~~~~~~~~~~~~~~~~~~~~~~~~
> > While all drivers should explictly indicate the DMA capability
> 
> I think it's ok to rely on the defaults if 0xffffffff is suitable

I want the driver writer to think about this. I hope it
gets them to verify the device DMA capabilities and if it's
something other than 32-bit, get motivated to make use
of those features. 

E.g. lots of SATA/IDE devices are 64-bit DMA capable but it
looks like generic code is leaving them at 32-bit.
Not good if the box is > 4GB (and many are now).


> And perhaps one sentence what a consistent allocation is.

Hrm...ok. I'm not enthusiastic about this though.

I've read your other comments and no issues with them.

thanks again!
grant

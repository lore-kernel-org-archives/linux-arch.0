Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from colo.lackof.org ([198.49.126.79]:10210 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1751463AbWJWEUA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 23 Oct 2006 00:20:00 -0400
Date: Sun, 22 Oct 2006 22:19:57 -0600
From: Grant Grundler <grundler@parisc-linux.org>
Subject: Re: RFC: rewrite Documentation/pci.txt v3
Message-ID: <20061023041957.GA15915@colo.lackof.org>
References: <20061021071436.GA29248@colo.lackof.org> <200610211455.29837.ak@suse.de> <20061022190351.GA10599@colo.lackof.org> <200610222344.39355.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610222344.39355.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Grant Grundler <grundler@parisc-linux.org>, Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>, linux-pci@atrey.karlin.mff.cuni.cz, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Sun, Oct 22, 2006 at 11:44:39PM +0200, Andi Kleen wrote:
...
> The /** function arguments can be turned into Documentation.
> When you do make pdfdocs you get a .pdf in
> Documentation/DocBook/kernel-api.pdf

Ah ok. I haven't look at DocBook in a long time.
I'll take a look at it before making references to it.

...
> > E.g. lots of SATA/IDE devices are 64-bit DMA capable but it
> > looks like generic code is leaving them at 32-bit.
> > Not good if the box is > 4GB (and many are now).
> 
> Not a good example imho, usually to get >4GB on those you need to use a 
> special interface, a standard SATA/IDE driver cannot do it.
> It's a lot more than just thinking about it.

IDE subsystem is a bad example in that it predates PCI.
But IDE is a good example as any.  Changes to subsystems often happen
when at least two people "think about it": the driver writer and
the subsystem maintainer.

ide_build_dmatable() follows some standard which dictates (and HW implements)
an SG list structure with 32-bit addresses and 16-bit counters.
New PCI devices are certainly capable of more than that.

So I'm now certain I want to keep references to pci_set_dma_mask()
in this document since some SATA (not IDE) could do something different
if the SATA device driver would advertise it was 64-bit capable.
I know jgarzik is smart and I hope he's already provided some way
for libata users to indicate their devices are 64-bit capable.
(Maybe Docbook would tell me that - checking :)

thanks,
grant

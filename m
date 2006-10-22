Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:17811 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750699AbWJVVpF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 22 Oct 2006 17:45:05 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: RFC: rewrite Documentation/pci.txt v3
Date: Sun, 22 Oct 2006 23:44:39 +0200
References: <20061021071436.GA29248@colo.lackof.org> <200610211455.29837.ak@suse.de> <20061022190351.GA10599@colo.lackof.org>
In-Reply-To: <20061022190351.GA10599@colo.lackof.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610222344.39355.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>, linux-pci@atrey.karlin.mff.cuni.cz, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Sunday 22 October 2006 21:03, Grant Grundler wrote: 

>One contentious issue you didn't mention was ordering of
>when to call pci_request_region() and  pci_enable_device().

I don't have a opinion on that.

> > And add a reference to kerneldoc somewhere too? There
> > is some PCI documentation in there (although it probably
> > could need some overall editing) 
> 
> I need more specific guidance on this.

The /** function arguments can be turned into Documentation.
When you do make pdfdocs you get a .pdf in Documentation/DocBook/kernel-api.pdf

Unfortunately it is right now broken and generates illegal pdfs
(and overall throws lots of errors). But maybe someone will fix it.

make mandocs seems to work though

There's also htmldocs and a couple of others.

Anyways, it's the most uptodate reference documentation because it's in the code.

> 
> > > 3.2 Set the DMA mask size
> > > ~~~~~~~~~~~~~~~~~~~~~~~~~
> > > While all drivers should explictly indicate the DMA capability
> > 
> > I think it's ok to rely on the defaults if 0xffffffff is suitable
> 
> I want the driver writer to think about this. I hope it
> gets them to verify the device DMA capabilities and if it's
> something other than 32-bit, get motivated to make use
> of those features. 
> 
> E.g. lots of SATA/IDE devices are 64-bit DMA capable but it
> looks like generic code is leaving them at 32-bit.
> Not good if the box is > 4GB (and many are now).

Not a good example imho, usually to get >4GB on those you need to use a 
special interface, a standard SATA/IDE driver cannot do it.
It's a lot more than just thinking about it.

-Andi

Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:46700 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbYCEUQG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 5 Mar 2008 15:16:06 -0500
Date: Wed, 5 Mar 2008 12:09:43 -0800
From: Greg KH <greg@kroah.com>
Subject: Re: [patch 09/16] parisc: use generic pci_enable_resources()
Message-ID: <20080305200943.GB13569@kroah.com>
References: <20080304185646.864917286@ldl.fc.hp.com> <20080304185821.554040328@ldl.fc.hp.com> <20080305161709.GA3354@phobos.i.cabal.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080305161709.GA3354@phobos.i.cabal.ca>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-pci@atrey.karlin.mff.cuni.cz, linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org, Chris Zankel <chris@zankel.net>
Message-ID: <20080305200943.GNa9-19yZMqxXEn6El4uioFIQijR9uQT5HRo6XW2WOU@z>

On Wed, Mar 05, 2008 at 11:17:10AM -0500, Kyle McMartin wrote:
> On Tue, Mar 04, 2008 at 11:56:55AM -0700, Bjorn Helgaas wrote:
> > Use the generic pci_enable_resources() instead of the arch-specific code.
> > 
> > Unlike this arch-specific code, the generic version:
> >     - checks PCI_NUM_RESOURCES (11), not DEVICE_COUNT_RESOURCE (12), resources
> >     - skips resources that have neither IORESOURCE_IO nor IORESOURCE_MEM set
> >     - skips ROM resources unless IORESOURCE_ROM_ENABLE is set
> >     - checks for resource collisions with "!r->parent"
> > 
> > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > 
> 
> Acked-by: Kyle McMartin <kyle@mcmartin.ca>

added, thanks.

greg k-h

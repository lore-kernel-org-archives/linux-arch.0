Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 206-248-169-182.dsl.ncf.ca ([206.248.169.182]:27219 "EHLO
	phobos.cabal.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754056AbYBSHDZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 Feb 2008 02:03:25 -0500
Date: Tue, 19 Feb 2008 02:03:25 -0500
From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [patch 4/4] RFC: PCI: consolidate several
	pcibios_enable_resources() implementations
Message-ID: <20080219070325.GB10115@phobos.i.cabal.ca>
References: <20080219043952.845136014@ldl.fc.hp.com> <20080219044307.878416912@ldl.fc.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080219044307.878416912@ldl.fc.hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org, Chris Zankel <chris@zankel.net>

On Mon, Feb 18, 2008 at 09:39:56PM -0700, Bjorn Helgaas wrote:
>     parisc: checks DEVICE_COUNT_RESOURCE (12) instead of PCI_NUM_RESOURCES
>	(11) resources at (1),
>

Good catch.

> has no IORESOURCE_{IO,MEM} check at (3),

What else can it be?

> 	has no PCI_ROM_RESOURCE check at (4), has no collision check at (5)
> 	always turns on PCI_COMMAND_SERR | PCI_COMMAND_PARITY at (6),
> 	writes cmd even if unchanged at (7)
> 

I'll have to check into 4 & 5, there might be a good reason for it. For
instance on a four port HP ethernet card (pci-pci bridge + 4 tulips) all
4 of the rom resources are mapped to the same address, which afaict, is
allowed but breaks things in mysterious and subtle ways.

That said, the parisc pci code is a rats nest...

cheers, Kyle

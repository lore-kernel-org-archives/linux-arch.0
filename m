Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from colo.lackof.org ([198.49.126.79]:48461 "EHLO colo.lackof.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753996AbYB1Rbi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 28 Feb 2008 12:31:38 -0500
Date: Thu, 28 Feb 2008 10:31:25 -0700
From: Grant Grundler <grundler@parisc-linux.org>
Subject: Re: [patch 5/6] PARISC: move PERR & SERR enables out of
	pcibios_enable_resources()
Message-ID: <20080228173125.GA16270@colo.lackof.org>
References: <20080228000437.880811124@ldl.fc.hp.com> <20080228001053.209248743@ldl.fc.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080228001053.209248743@ldl.fc.hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org, Chris Zankel <chris@zankel.net>

On Wed, Feb 27, 2008 at 05:04:42PM -0700, Bjorn Helgaas wrote:
> Move PERR and SERR enables from pcibios_enable_resources() to
> platform_pci_enable_device() so the former matches other
> architectures and can be shared.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Ack-By: Grant Grundler <grundler@parisc-linux.org>

This patch sequence is heading in the right direction.
I've not tested this particular one yet but I'm pretty sure it's ok.
I'll fixup any breakage for parisc.

...
> +/*
> + * A driver is enabling the device.  We enable the PERR and SERR bits
> + * unconditionally.  Drivers that do not need parity (eg graphics and
> + * possibly networking) can clear these bits if they want.
> + */
> +static int platform_pci_enable_device(struct pci_dev *dev)

Thanks for preserving this comment.

In general, I'm wondering if the check for device class would be
sufficient here to NOT enable PERR/SERR for graphics automatically.
While disabling PERR was "the right thing" for older "mostly write"
devices of the 1990's and early 2000, it might not be correct for
current 3-D graphics devices which use host mem to buffer processed
results. I'm thinking of Intel graphics controllers in particular
but I don't know any details of how they actually work.

I'm also a bit concerned about this now becuase (IIRC) AGP didn't
implement parity though it looked like PCI protocol. PCI-e certainly
does but it's possible BIOS/Firmware disable parity generation
on the host bridge when connected to a gfx device.
We wouldn't want to enable parity checking on a PCI-e gfx device in this
case and I hope someone (perhaps at Intel) could double check this.

thanks,
grant

Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:36584 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758042AbYBSSAO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 Feb 2008 13:00:14 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 0/4] RFC: PCI: consolidate several pcibios_enable_resources() implementations
Date: Tue, 19 Feb 2008 11:02:12 -0700
References: <20080219043952.845136014@ldl.fc.hp.com> <20080219080947.GB20893@flint.arm.linux.org.uk> <1203415712.6740.102.camel@pasglop>
In-Reply-To: <1203415712.6740.102.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200802191102.13777.bjorn.helgaas@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: benh@kernel.crashing.org
Cc: Russell King <rmk-pci@arm.linux.org.uk>, linux-pci@atrey.karlin.mff.cuni.cz, linux-arch@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org, Chris Zankel <chris@zankel.net>

On Tuesday 19 February 2008 03:08:32 am Benjamin Herrenschmidt wrote:
> On Tue, 2008-02-19 at 08:09 +0000, Russell King wrote:
> > On Mon, Feb 18, 2008 at 09:39:52PM -0700, Bjorn Helgaas wrote:
> > > 
> > > ARM and PA-RISC, in particular, have interesting differences:
> > >     - ARM always enables bridge devices, which no other arch does
> > 
> > ARM does this because there is nothing else which would do that - which
> > means devices behind bridges would be completely inaccessible.
> 
> That's normally done by pci_enable_bridges() called by
> pci_assign_unassigned_resources().

alpha, mips, mn10300, powerpc, and x86 use pci_enable_bridges() via
pci_assign_unassigned_resources().  parisc uses pci_enable_bridges()
directly from lba_driver_probe().  I guess the other arches (except
arm) rely on firmware to enable bridge.

I think pci_assign_unassigned_resources() is a bit of an anachronism --
it's a boot-time thing that does it for all root buses at once.  A
more hot-plug oriented scheme would do it like parisc, where every
time we discover a root bridge, we do any necessary resource assignment
and bridge enablement underneath it.

For ARM, maybe that could happen in pcibios_init_hw() or something
similar.

> > >     - PA-RISC always turns on SERR and PARITY, which no other arch does
> > 
> > ARM also does this, unless pdev_bad_for_parity(dev) is true.  See
> > ARMs pcibios_fixup_bus().
> 
> While that sounds like a good idea to generalize, I think it should
> remain arch stuff tho, not move to generic code.
> 
> On some platforms, weirdo firmwares handle error handling and will be
> unhappy if the kernel mucks around (such as pSeries).

I agree the SERR and PARITY stuff probably needs to remain arch code.
But it would be nice to at least have this and the bridge enable done in
similar places across arches.

Bjorn


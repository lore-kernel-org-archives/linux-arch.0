Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36826 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbYBSIKc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 Feb 2008 03:10:32 -0500
Date: Tue, 19 Feb 2008 08:09:47 +0000
From: Russell King <rmk-pci@arm.linux.org.uk>
Subject: Re: [patch 0/4] RFC: PCI: consolidate several pcibios_enable_resources() implementations
Message-ID: <20080219080947.GB20893@flint.arm.linux.org.uk>
References: <20080219043952.845136014@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080219043952.845136014@ldl.fc.hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-arch@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org, Chris Zankel <chris@zankel.net>

On Mon, Feb 18, 2008 at 09:39:52PM -0700, Bjorn Helgaas wrote:
> There are many implementations of pcibios_enable_resources() that differ
> in minor ways that look more like bugs than architectural differences.
> This patch series consolidates most of them to use the x86 version.
> 
> This series is for discussion only at this point.  I'm interested in
> feedback about whether any of the differences are "real" and need to
> be preserved.
> 
> ARM and PA-RISC, in particular, have interesting differences:
>     - ARM always enables bridge devices, which no other arch does

ARM does this because there is nothing else which would do that - which
means devices behind bridges would be completely inaccessible.

>     - PA-RISC always turns on SERR and PARITY, which no other arch does

ARM also does this, unless pdev_bad_for_parity(dev) is true.  See
ARMs pcibios_fixup_bus().

> Should other arches do the same thing, or are these somehow related to
> ARM and PA-RISC architecture?

I suspect they're architecture specific; I wouldn't like to do either
on x86, but they're either required or preferred on ARM.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:

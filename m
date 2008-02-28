Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:23097 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400AbYB1AJM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Feb 2008 19:09:12 -0500
Message-Id: <20080228000437.880811124@ldl.fc.hp.com>
Date: Wed, 27 Feb 2008 17:04:37 -0700
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 0/6] RFC: PCI: consolidate pcibios_enable_resources() implementations, v2
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@atrey.karlin.mff.cuni.cz, linux-arch@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org, Chris Zankel <chris@zankel.net>

There are many implementations of pcibios_enable_resources() that differ
in minor ways that look more like bugs than architectural differences.
This patch series consolidates most of them to use the x86 version.

Changes between v1 and v2:

  - Moved ARM bridge enable to new platform_pci_enable_device(),
    called by pcibios_enable_device()

  - Moved PA-RISC SERR & PERR enable to new platform_pci_enable_device(),
    called by pcibios_enable_device()

  - In the generic pcibios_enable_resources(), adopted powerpc resource
    collision detection (check for (!r->parent) instead of
    (!r->start && r->end))

  - In the generic pcibios_enable_resources(), added a little more detail to
    the resource collision error message

  - Moved consolidated pcibios_enable_resources() from bios.c to setup-res.c

Thanks for the comments on the first version.  I think this addresses
all of them.

Any other comments would be welcome.

Bjorn
-- 

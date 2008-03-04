Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:19922 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932978AbYCDS4L (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 Mar 2008 13:56:11 -0500
Message-Id: <20080304185646.864917286@ldl.fc.hp.com>
Date: Tue, 04 Mar 2008 11:56:46 -0700
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 00/16] PCI: consolidate several pcibios_enable_resources() implementations, v3
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@atrey.karlin.mff.cuni.cz, linux-arch@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org, Chris Zankel <chris@zankel.net>

This series replaces most of the arch-specific pcibios_enable_resources()
implementations with a single generic pci_enable_resources().

I think this is ready for -mm, but of course, I'm still interested in
any other comments.

Changes between v2 and v3:
    
    - Renamed the generic version to pci_enable_resources(), to keep
      pcibios_* names for arch-specific code (suggested by Kyle, thanks).

    - I reorganized this series into a single PCI patch that adds the new
      generic version, followed by a bunch of patches that individually
      convert each arch over to use it.

Bjorn

-- 

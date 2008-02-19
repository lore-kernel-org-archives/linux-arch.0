Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:9512 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180AbYBSElK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 18 Feb 2008 23:41:10 -0500
Message-Id: <20080219043952.845136014@ldl.fc.hp.com>
Date: Mon, 18 Feb 2008 21:39:52 -0700
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 0/4] RFC: PCI: consolidate several pcibios_enable_resources() implementations
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@atrey.karlin.mff.cuni.cz, linux-arch@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org, Chris Zankel <chris@zankel.net>

There are many implementations of pcibios_enable_resources() that differ
in minor ways that look more like bugs than architectural differences.
This patch series consolidates most of them to use the x86 version.

This series is for discussion only at this point.  I'm interested in
feedback about whether any of the differences are "real" and need to
be preserved.

ARM and PA-RISC, in particular, have interesting differences:
    - ARM always enables bridge devices, which no other arch does
    - PA-RISC always turns on SERR and PARITY, which no other arch does

Should other arches do the same thing, or are these somehow related to
ARM and PA-RISC architecture?

Bjorn

-- 

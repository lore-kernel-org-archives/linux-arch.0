Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:35849 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755441Ab1DGD0x (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 Apr 2011 23:26:53 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCHES] Generalize PCI <-> OF node matching 
Date: Thu,  7 Apr 2011 13:26:31 +1000
Message-ID: <1302146796-26825-1-git-send-email-benh@kernel.crashing.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, bheglaas@google.com, monstr@monstr.eu, tglx@linuxtronix.de, bigeasy@linuxtronix.de
Message-ID: <20110407032631.90in2AvlBCPAefoEiL4o8s14e5A_hZJiqk4dXCqOp7M@z>

This series generalize the PCI <-> OF node matching, moves it to the
PCI core and make our archs use it. I also rip out while at it a whole
bunch of useless stuff from microblaze PCI code which was copied from
ppc32 and is essentially useless there (old workarounds for PowerMac
and ancient X servers).

Compile tested on x86_64, microblaze, sparc64 and powerpc.

How do you guys want to proceed with this series ? It will quickly
become a pre-req for other things on powerpc, so I can carry it in
powerpc in a separate branch that I also pull into powerpc-next or
we can have it somewhere on tip...


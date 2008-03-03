Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:36685 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753082AbYCCUkw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 3 Mar 2008 15:40:52 -0500
Subject: Re: [patch 4/6] ARM: move bridge enable out of
	pcibios_enable_resources()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
In-Reply-To: <200803030959.35625.jbarnes@virtuousgeek.org>
References: <20080228000437.880811124@ldl.fc.hp.com>
	 <20080228001053.013269726@ldl.fc.hp.com>
	 <200803030959.35625.jbarnes@virtuousgeek.org>
Content-Type: text/plain
Date: Tue, 04 Mar 2008 07:35:57 +1100
Message-ID: <1204576557.21545.4.camel@pasglop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org, Chris Zankel <chris@zankel.net>
Message-ID: <20080303203557.uj8iJR-iLHU1bMPiD1kqBGGcsClVtBOtRu0Ehv7HZL0@z>


On Mon, 2008-03-03 at 09:59 -0800, Jesse Barnes wrote:
> On Wednesday, February 27, 2008 4:04 pm Bjorn Helgaas wrote:
> > Move bridge enable from pcibios_enable_resources() to
> > platform_pci_enable_device() so the former matches other
> > architectures and can be shared.
> 
> I really like the direction of these patches.  Getting PCI resources assigned 
> & devices setup correctly for new arches has always been a bit more trouble 
> than it should be...

You'll noticed that I recently moved powerpc to something more common to
x86 in the are of resource allocation. Still -slightly- different but I
do believe there is room for somebody with some skills to try to turn
some of that into generic code.

Ben.




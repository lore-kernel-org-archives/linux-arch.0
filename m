From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: PCIBIOS_MIN_IO/MEM problem
Date: Tue, 11 Nov 2008 15:56:55 +1100
Message-ID: <1226379415.7530.94.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:54827 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753154AbYKKFpM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 11 Nov 2008 00:45:12 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci <linux-pci@vger.kernel.org>
Cc: Jesse Barnes <jesse.barnes@intel.com>, Linux Arch list <linux-arch@vger.kernel.org>

Hi !

I have a problem on platforms with multiple PCI domains and allocating
resources.

The mechanism of having the arch set PCIBIOS_MIN_IO and PCIBIOS_MIN_MEM
to avoid allocating things over the legacy areas among other things
doesn't work well for us.

The reason is that on platforms where resource addresses are remapped
because the PCI bus isn't mapped 1:1, the values of the ranges we try
to avoid (typically 0...4K for IO space and legacy VGA memory) is
different from one domain to the next.

Right now, I'm doing a workaround for .28 that will reserve those
regions on some platforms before the allocation occurs, but it's a bit
fishy, especially it gives strange results when using things like legacy
IDE PCI cards that really want to allocate in those areas.

Ideally, we would need to pass the pci_bus pointer to those macros.

Thus, is there any objection to me replacing those accross the board
with something like that ?

	resource_size_t pcibios_min_assign_io(struct pci_bus *bus)
	resource_size_t pcibios_min_assign_mem(struct pci_bus *bus)

Please holler if you have objections before I start fixing everybody :-)

Cheers,
Ben.

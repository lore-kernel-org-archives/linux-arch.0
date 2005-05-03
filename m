Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 3 May 2005 10:47:56 +1000
From: Anton Blanchard <anton@samba.org>
Subject: iomap interface issue
Message-ID: <20050503004756.GB12682@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: torvalds@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Hi,

I was looking through the iomap API and noticed that pci_iounmap only
takes a pci_dev and address:

void pci_iounmap(struct pci_dev *dev, void __iomem *addr)

At the moment the ppc64 interface does nothing on iounmap, but for
hotplug we need to tear down MMU entries associated with MMIO regions.
This is because we need to ensure all entries are removed before the
adapter is moved to another partition (or else the old partition could
still access the device).

With the current API we could work out if an address is IO or MMIO but
it will be a bit ugly. I was wondering if it made sense to pass in the
BAR to pci_iounmap. That would make it easy to work out if its an MMIO
region.

Anton

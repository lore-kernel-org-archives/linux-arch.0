Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:26942 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758649Ab2BKEHJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 10 Feb 2012 23:07:09 -0500
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 06/22] PCI, sparc: Register busn_res for root buses
Date: Fri, 10 Feb 2012 20:06:09 -0800
Message-ID: <1328933185-15154-7-git-send-email-yinghai@kernel.org>
In-Reply-To: <1328933185-15154-1-git-send-email-yinghai@kernel.org>
References: <1328933185-15154-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Message-ID: <20120211040609.qkqjwN3ShcWT1MzPIE2w1sF5cGpyV0AnXQO9KUojQ0s@z>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/kernel/pci.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index bb8bc2e..83881df9 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -703,6 +703,7 @@ struct pci_bus * __devinit pci_scan_one_pbm(struct pci_pbm_info *pbm,
 	}
 	bus->secondary = pbm->pci_first_busno;
 	bus->subordinate = pbm->pci_last_busno;
+	pci_bus_insert_busn_res(bus, pbm->pci_first_busno, pbm->pci_last_busno);
 
 	pci_of_scan_bus(pbm, node, bus);
 	pci_bus_add_devices(bus);
-- 
1.7.7


Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:25688 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965430Ab2B1WIY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2012 17:08:24 -0500
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 06/24] PCI: insert busn_res in pci_create_root_bus
Date: Tue, 28 Feb 2012 14:07:25 -0800
Message-ID: <1330466863-28469-7-git-send-email-yinghai@kernel.org>
In-Reply-To: <1330466863-28469-1-git-send-email-yinghai@kernel.org>
References: <1330466863-28469-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Message-ID: <20120228220725.jbjv3uXxwr6C4Hp8NR_e58Wjlz8eUH30qJOhrb4E-dM@z>

that busn_res is from resources list

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/probe.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ed82369..25a7ef8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1649,7 +1649,10 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 		list_move_tail(&window->list, &bridge->windows);
 		res = window->res;
 		offset = window->offset;
-		pci_bus_add_resource(b, res, 0);
+		if (res->flags & IORESOURCE_BUS)
+			pci_bus_insert_busn_res(b, res->start, res->end);
+		else
+			pci_bus_add_resource(b, res, 0);
 		if (offset) {
 			if (resource_type(res) == IORESOURCE_IO)
 				fmt = " (bus address [%#06llx-%#06llx])";
-- 
1.7.7


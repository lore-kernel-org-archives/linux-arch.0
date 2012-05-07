Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:51007 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932219Ab2EGUa3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 May 2012 16:30:29 -0400
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 09/21] PCI: Insert busn_res in pci_create_root_bus()
Date: Mon,  7 May 2012 13:29:54 -0700
Message-ID: <1336422606-4244-10-git-send-email-yinghai@kernel.org>
In-Reply-To: <1336422606-4244-1-git-send-email-yinghai@kernel.org>
References: <1336422606-4244-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Message-ID: <20120507202954.n_Su-x_YSOzsxpJNgUzWCRPowIU-YL-PkP6cSFxikFs@z>

That busn_res is from resources list

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/probe.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 7662ab7..59011ce 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1684,7 +1684,10 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 		list_move_tail(&window->list, &bridge->windows);
 		res = window->res;
 		offset = window->offset;
-		pci_bus_add_resource(b, res, 0);
+		if (res->flags & IORESOURCE_BUS)
+			pci_bus_insert_busn_res(b, bus, res->end);
+		else
+			pci_bus_add_resource(b, res, 0);
 		if (offset) {
 			if (resource_type(res) == IORESOURCE_IO)
 				fmt = " (bus address [%#06llx-%#06llx])";
-- 
1.7.7


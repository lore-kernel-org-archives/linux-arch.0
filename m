Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:28251 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030352Ab2CSFo1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 19 Mar 2012 01:44:27 -0400
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH -v11 09/30] PCI: Add default busn_resource
Date: Sun, 18 Mar 2012 22:42:40 -0700
Message-ID: <1332135781-13695-10-git-send-email-yinghai@kernel.org>
In-Reply-To: <1332135781-13695-1-git-send-email-yinghai@kernel.org>
References: <1332135781-13695-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Message-ID: <20120319054240.ihrGlose1-BUQwdMOeS66Q26b5kkVwE7d6deKxnScus@z>

We need to put into the resources list for legacy system.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/probe.c |    7 +++++++
 include/linux/pci.h |    2 ++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 654c727..2378531 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -15,6 +15,13 @@
 #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
 #define CARDBUS_RESERVE_BUSNR	3
 
+struct resource busn_resource = {
+	.name	= "PCI busn",
+	.start	= 0,
+	.end	= 255,
+	.flags	= IORESOURCE_BUS,
+};
+
 /* Ugh.  Need to stop exporting this to modules. */
 LIST_HEAD(pci_root_buses);
 EXPORT_SYMBOL(pci_root_buses);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e494759..40606c1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -368,6 +368,8 @@ static inline int pci_channel_offline(struct pci_dev *pdev)
 	return (pdev->error_state != pci_channel_io_normal);
 }
 
+extern struct resource busn_resource;
+
 struct pci_host_bridge_window {
 	struct list_head list;
 	struct resource *res;		/* host bridge aperture (CPU address) */
-- 
1.7.7


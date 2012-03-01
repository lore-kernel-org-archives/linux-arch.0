Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:32233 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754269Ab2CADCJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 Feb 2012 22:02:09 -0500
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 15/36] PCI: Add busn_res into struct pci_bus.
Date: Wed, 29 Feb 2012 19:00:16 -0800
Message-ID: <1330570837-26638-16-git-send-email-yinghai@kernel.org>
In-Reply-To: <1330570837-26638-1-git-send-email-yinghai@kernel.org>
References: <1330570837-26638-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20120301030016.L38WfcbxU7C5J5Hb95rFfVj4-YB5zuc5EFLnzEgUrS4@z>

will use it to have bus number resource tree.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/pci.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index d93d3ae..7c03852 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -419,6 +419,7 @@ struct pci_bus {
 	struct list_head slots;		/* list of slots on this bus */
 	struct resource *resource[PCI_BRIDGE_RESOURCE_NUM];
 	struct list_head resources;	/* address space routed to this bus */
+	struct resource busn_res;	/* track registered bus num range */
 
 	struct pci_ops	*ops;		/* configuration access functions */
 	void		*sysdata;	/* hook for sys-specific extension */
-- 
1.7.7


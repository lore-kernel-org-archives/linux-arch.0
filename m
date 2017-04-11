From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v3 31/32] lib: fix Devres devm_ioremap_* offset parameter kerneldoc description
Date: Tue, 11 Apr 2017 13:29:11 +0100
Message-ID: <20170411122923.6285-32-lorenzo.pieralisi@arm.com>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60090 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754979AbdDKMac (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Apr 2017 08:30:32 -0400
In-Reply-To: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Tejun Heo <tj@kernel.org>

The offset parameter in Devres devm_ioremap_* functions kerneldoc
entries is erroneously defined as BUS offset whereas it is actually
a resource address.

Since it is actually misleading, fix the Devres devm_ioremap_* offset
parameter kerneldoc entry by replacing BUS offset with a more
suitable description (ie Resource address).

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Tejun Heo <tj@kernel.org>
---
 lib/devres.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/devres.c b/lib/devres.c
index cb1464c..78eca71 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -17,7 +17,7 @@ static int devm_ioremap_match(struct device *dev, void *res, void *match_data)
 /**
  * devm_ioremap - Managed ioremap()
  * @dev: Generic device to remap IO address for
- * @offset: BUS offset to map
+ * @offset: Resource address to map
  * @size: Size of map
  *
  * Managed ioremap().  Map is automatically unmapped on driver detach.
@@ -45,7 +45,7 @@ EXPORT_SYMBOL(devm_ioremap);
 /**
  * devm_ioremap_nocache - Managed ioremap_nocache()
  * @dev: Generic device to remap IO address for
- * @offset: BUS offset to map
+ * @offset: Resource address to map
  * @size: Size of map
  *
  * Managed ioremap_nocache().  Map is automatically unmapped on driver
@@ -74,7 +74,7 @@ EXPORT_SYMBOL(devm_ioremap_nocache);
 /**
  * devm_ioremap_wc - Managed ioremap_wc()
  * @dev: Generic device to remap IO address for
- * @offset: BUS offset to map
+ * @offset: Resource address to map
  * @size: Size of map
  *
  * Managed ioremap_wc().  Map is automatically unmapped on driver detach.
-- 
2.10.0

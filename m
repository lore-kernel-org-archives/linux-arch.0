Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59750 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729980AbfHTO6e (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Aug 2019 10:58:34 -0400
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 03/11] of/fdt: add of_fdt_machine_is_compatible function
Date: Tue, 20 Aug 2019 16:58:11 +0200
Message-ID: <20190820145821.27214-4-nsaenzjulienne@suse.de>
In-Reply-To: <20190820145821.27214-1-nsaenzjulienne@suse.de>
References: <20190820145821.27214-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: catalin.marinas@arm.com, hch@lst.de, wahrenst@gmx.net, marc.zyngier@arm.com, robh+dt@kernel.org, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-riscv@lists.infradead.org, Frank Rowand <frowand.list@gmail.com>
Cc: phill@raspberryi.org, f.fainelli@gmail.com, will@kernel.org, nsaenzjulienne@suse.de, linux-kernel@vger.kernel.org, eric@anholt.net, mbrugger@suse.com, linux-rpi-kernel@lists.infradead.org, akpm@linux-foundation.org, m.szyprowski@samsung.com
Message-ID: <20190820145811.dyZH0-91xokmg24Wx-361Qb-3kJ2L8HDkIK7xF6_-rU@z>

Provides the same functionality as of_machine_is_compatible.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

Changes in v2: None

 drivers/of/fdt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 9cdf14b9aaab..06ffbd39d9af 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -802,6 +802,13 @@ const char * __init of_flat_dt_get_machine_name(void)
 	return name;
 }
 
+static const int __init of_fdt_machine_is_compatible(char *name)
+{
+	unsigned long dt_root = of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(dt_root, name);
+}
+
 /**
  * of_flat_dt_match_machine - Iterate match tables to find matching machine.
  *
-- 
2.22.0

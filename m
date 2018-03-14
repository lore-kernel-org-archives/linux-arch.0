Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:6638 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751362AbeCNSRG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Mar 2018 14:17:06 -0400
From: John Garry <john.garry@huawei.com>
Subject: [PATCH v17 02/10] PCI: Remove unused __weak attribute in pci_register_io_range()
Date: Thu, 15 Mar 2018 02:15:51 +0800
Message-ID: <1521051359-34473-3-git-send-email-john.garry@huawei.com>
In-Reply-To: <1521051359-34473-1-git-send-email-john.garry@huawei.com>
References: <1521051359-34473-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mika.westerberg@linux.intel.com, rafael@kernel.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org, robh+dt@kernel.org, bhelgaas@google.com, arnd@arndb.de, mark.rutland@arm.com, olof@lixom.net, dann.frazier@canonical.com, andy.shevchenko@gmail.com, robh@kernel.org, andriy.shevchenko@linux.intel.com
Cc: joe@perches.com, benh@kernel.crashing.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linuxarm@huawei.com, minyard@acm.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, rdunlap@infradead.org, gregkh@linuxfoundation.org, akpm@linux-foundation.org, frowand.list@gmail.com, agraf@suse.de
Message-ID: <20180314181551.MMBBq9SB2BOthkun-rXWxpV4k1Z2u-b0N-R8KnCC9GI@z>

From: Gabriele Paoloni <gabriele.paoloni@huawei.com>

Currently pci_register_io_range() has only one definition;
therefore there is no use of the __weak attribute.

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Tested-by: dann frazier <dann.frazier@canonical.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ae654e2..ff41a64 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3451,7 +3451,7 @@ struct io_range {
  * Record the PCI IO range (expressed as CPU physical address + size).
  * Return a negative value if an error has occured, zero otherwise
  */
-int __weak pci_register_io_range(phys_addr_t addr, resource_size_t size)
+int pci_register_io_range(phys_addr_t addr, resource_size_t size)
 {
 	int err = 0;
 
-- 
1.9.1

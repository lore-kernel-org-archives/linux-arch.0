Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:4261 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751150AbeAULgd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 21 Jan 2018 06:36:33 -0500
From: John Garry <john.garry@huawei.com>
Subject: [PATCH v11 9/9] MAINTAINERS: Add maintainer for HiSilicon LPC driver
Date: Sun, 21 Jan 2018 20:27:27 +0800
Message-ID: <1516537647-50553-10-git-send-email-john.garry@huawei.com>
In-Reply-To: <1516537647-50553-1-git-send-email-john.garry@huawei.com>
References: <1516537647-50553-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mika.westerberg@linux.intel.com, rafael@kernel.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, robh+dt@kernel.org, bhelgaas@google.com, arnd@arndb.de, mark.rutland@arm.com, olof@lixom.net, hanjun.guo@linaro.org, dann.frazier@canonical.com
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linuxarm@huawei.com, linux-pci@vger.kernel.org, minyard@acm.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, John Garry <john.garry@huawei.com>
Message-ID: <20180121122727.1ZLigOW0gCpaCEQOxGl3hsDBYKawrlg5j78CLxgx_Hw@z>

Added maintainer for drivers/bus/hisi_lpc.c

Signed-off-by: John Garry <john.garry@huawei.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f1e3ee6..ab09908 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6386,6 +6386,13 @@ W:	http://www.hisilicon.com
 S:	Maintained
 F:	drivers/net/ethernet/hisilicon/hns3/
 
+HISILICON LPC BUS DRIVER
+M:	john.garry@huawei.com
+W:	http://www.hisilicon.com
+S:	Maintained
+F:	drivers/bus/hisi_lpc.c
+F:	Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
+
 HISILICON NETWORK SUBSYSTEM DRIVER
 M:	Yisen Zhuang <yisen.zhuang@huawei.com>
 M:	Salil Mehta <salil.mehta@huawei.com>
-- 
1.9.1

Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn1bon0085.outbound.protection.outlook.com ([157.56.111.85]:37312
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751875AbbJNGcB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 14 Oct 2015 02:32:01 -0400
From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH v2 2/4] pci: add include <linux/dma-mapping.h>
Date: Wed, 14 Oct 2015 14:31:42 +0800
Message-ID: <1444804304-5213-3-git-send-email-lftan@altera.com>
In-Reply-To: <1444804304-5213-1-git-send-email-lftan@altera.com>
References: <1444804304-5213-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-pci@vger.kernel.org, Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com
Message-ID: <20151014063142.7jZUCti_8slb1kDYOcTuGRb89m_pvTEs-UE0PH1nQOg@z>

Include <linux/dma-mapping.h> explicitly, it depends on architecture's pci.h
to include it before this. It cause compilation error when we move to
asm-generic pci.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 drivers/pci/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6a9a111..ef2f09e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -25,6 +25,7 @@
 #include <linux/device.h>
 #include <linux/pm_runtime.h>
 #include <linux/pci_hotplug.h>
+#include <linux/dma-mapping.h>
 #include <asm-generic/pci-bridge.h>
 #include <asm/setup.h>
 #include "pci.h"
-- 
1.8.2.1


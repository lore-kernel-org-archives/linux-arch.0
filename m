From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 13/34] PCI: make pci_flags non-weak
Date: Wed, 07 Mar 2012 15:33:10 -0700
Message-ID: <20120307223310.25669.87977.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gy0-f202.google.com ([209.85.160.202]:58163 "EHLO
	mail-gy0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030562Ab2CGWdL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 Mar 2012 17:33:11 -0500
Received: by mail-gy0-f202.google.com with SMTP id z15so865477ghb.1
        for <linux-arch@vger.kernel.org>; Wed, 07 Mar 2012 14:33:11 -0800 (PST)
In-Reply-To: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org

No architecture defines its own pci_flags, so the core symbol does not
need to be weak.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/setup-bus.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 6db307f..e241f2f 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -28,7 +28,7 @@
 #include <asm-generic/pci-bridge.h>
 #include "pci.h"
 
-unsigned int __weak pci_flags;
+unsigned int pci_flags;
 
 struct pci_dev_resource {
 	struct list_head list;

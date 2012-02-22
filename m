From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1 11/11] PCI: make pci_flags non-weak
Date: Wed, 22 Feb 2012 11:19:58 -0700
Message-ID: <20120222181958.27513.2134.stgit@bhelgaas.mtv.corp.google.com>
References: <20120222181556.27513.9413.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw0-f74.google.com ([209.85.213.74]:39839 "EHLO
	mail-yw0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754918Ab2BVST7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 22 Feb 2012 13:19:59 -0500
Received: by yhgm50 with SMTP id m50so48276yhg.1
        for <linux-arch@vger.kernel.org>; Wed, 22 Feb 2012 10:19:59 -0800 (PST)
In-Reply-To: <20120222181556.27513.9413.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org

No architecture defines its own pci_flags, so the core symbol does not
need to be weak.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/setup-bus.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 7b7d7e9..c172ebb 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -28,7 +28,7 @@
 #include <asm-generic/pci-bridge.h>
 #include "pci.h"
 
-unsigned int __weak pci_flags;
+unsigned int pci_flags;
 
 struct resource_list_x {
 	struct resource_list_x *next;

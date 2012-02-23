From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 12/12] PCI: make pci_flags non-weak
Date: Thu, 23 Feb 2012 12:44:03 -0700
Message-ID: <20120223194403.20708.53279.stgit@bhelgaas.mtv.corp.google.com>
References: <20120223194209.20708.54480.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw0-f74.google.com ([209.85.213.74]:65213 "EHLO
	mail-yw0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756518Ab2BWToF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 23 Feb 2012 14:44:05 -0500
Received: by yhgm50 with SMTP id m50so207277yhg.1
        for <linux-arch@vger.kernel.org>; Thu, 23 Feb 2012 11:44:04 -0800 (PST)
In-Reply-To: <20120223194209.20708.54480.stgit@bhelgaas.mtv.corp.google.com>
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

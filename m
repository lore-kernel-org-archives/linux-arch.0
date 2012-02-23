Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qy0-f202.google.com ([209.85.216.202]:58837 "EHLO
	mail-qy0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756194Ab2BWTnI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 23 Feb 2012 14:43:08 -0500
Received: by qcsp5 with SMTP id p5so16214qcs.1
        for <linux-arch@vger.kernel.org>; Thu, 23 Feb 2012 11:43:07 -0800 (PST)
Subject: [PATCH v2 01/12] PCI: make pci_flags always available
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 23 Feb 2012 12:43:07 -0700
Message-ID: <20120223194307.20708.66822.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120223194209.20708.54480.stgit@bhelgaas.mtv.corp.google.com>
References: <20120223194209.20708.54480.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Message-ID: <20120223194307.pAOZfxQmM7fmjXHXRH6dwinj9R5JQh6hvMjrR63Ekkg@z>

If we move resource assignment functions into the core, we'll still
need a way for architectures to prevent reassignment, e.g., the
"pci_probe_only" functionality, and we'll need a generic, always
available way the core can test for that.  The "pci_flags"
arrangement used by several architectures seems like a convenient
way to do this.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/setup-bus.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 86b69f85..7b7d7e9 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -25,8 +25,11 @@
 #include <linux/ioport.h>
 #include <linux/cache.h>
 #include <linux/slab.h>
+#include <asm-generic/pci-bridge.h>
 #include "pci.h"
 
+unsigned int __weak pci_flags;
+
 struct resource_list_x {
 	struct resource_list_x *next;
 	struct resource *res;


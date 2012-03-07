From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 01/34] PCI: make pci_flags always available
Date: Wed, 07 Mar 2012 15:32:09 -0700
Message-ID: <20120307223209.25669.37360.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
index 2991a89..6db307f 100644
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
 struct pci_dev_resource {
 	struct list_head list;
 	struct resource *res;

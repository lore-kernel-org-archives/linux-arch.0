Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f202.google.com ([74.125.82.202]:64371 "EHLO
	mail-we0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965145Ab2CGWlE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 Mar 2012 17:41:04 -0500
Received: by wejx9 with SMTP id x9so269959wej.1
        for <linux-arch@vger.kernel.org>; Wed, 07 Mar 2012 14:41:03 -0800 (PST)
Subject: [PATCH v3 10/34] powerpc/PCI: allow reallocation on PA Semi
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 07 Mar 2012 15:32:55 -0700
Message-ID: <20120307223255.25669.42520.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20120307223255.oc0x17Ab1Z84-qfUSoGqNwd0AZP06n__GSluTYqCwy8@z>

We believe there's no reason to prevent reallocation on PA Semi, so
revert to the default of "allow reallocation if necessary."

CC: Olof Johansson <olof@lixom.net>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/powerpc/platforms/pasemi/pci.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
index b6a0ec4..aa86271 100644
--- a/arch/powerpc/platforms/pasemi/pci.c
+++ b/arch/powerpc/platforms/pasemi/pci.c
@@ -229,9 +229,6 @@ void __init pas_pci_init(void)
 
 	/* Setup the linkage between OF nodes and PHBs */
 	pci_devs_phb_init();
-
-	/* Use the common resource allocation mechanism */
-	pci_probe_only = 1;
 }
 
 void __iomem *pasemi_pci_getcfgaddr(struct pci_dev *dev, int offset)


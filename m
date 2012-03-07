From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 02/34] PCI: add pci_clear_flags()
Date: Wed, 07 Mar 2012 15:32:14 -0700
Message-ID: <20120307223214.25669.68888.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qy0-f202.google.com ([209.85.216.202]:56075 "EHLO
	mail-qy0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932698Ab2CGWcP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 Mar 2012 17:32:15 -0500
Received: by qcsp5 with SMTP id p5so868364qcs.1
        for <linux-arch@vger.kernel.org>; Wed, 07 Mar 2012 14:32:14 -0800 (PST)
In-Reply-To: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org

Add a pci_clear_flags() for cases when we statically initialize
pci_flags, then decide to clear things out later.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/asm-generic/pci-bridge.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/asm-generic/pci-bridge.h b/include/asm-generic/pci-bridge.h
index 4a5aca2..a5b5d5a 100644
--- a/include/asm-generic/pci-bridge.h
+++ b/include/asm-generic/pci-bridge.h
@@ -45,6 +45,11 @@ static inline void pci_add_flags(int flags)
 	pci_flags |= flags;
 }
 
+static inline void pci_clear_flags(int flags)
+{
+	pci_flags &= ~flags;
+}
+
 static inline int pci_has_flag(int flag)
 {
 	return pci_flags & flag;
@@ -52,6 +57,7 @@ static inline int pci_has_flag(int flag)
 #else
 static inline void pci_set_flags(int flags) { }
 static inline void pci_add_flags(int flags) { }
+static inline void pci_clear_flags(int flags) { }
 static inline int pci_has_flag(int flag)
 {
 	return 0;

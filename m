From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 23/73] sparc: don't use module_init in non-modular pci.c code
Date: Tue, 21 Jan 2014 16:22:26 -0500
Message-ID: <1390339396-3479-24-git-send-email-paul.gortmaker@windriver.com>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:50643 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754179AbaAUVYk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jan 2014 16:24:40 -0500
In-Reply-To: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, "David S. Miller" <davem@davemloft.net>, Bjorn Helgaas <bhelgaas@google.com>, sparclinux@vger.kernel.org

The pci.o is built for SPARC64_PCI -- which is bool, and hence
this code is either present or absent.  It will never be modular,
so using module_init as an alias for __initcall can be somewhat
misleading.

Fix this up now, so that we can relocate module_init from
init.h into module.h in the future.  If we don't do this, we'd
have to add module.h to obviously non-modular code, and that
would be a worse thing.

Note that direct use of __initcall is discouraged, vs. one
of the priority categorized subgroups.  As __initcall gets
mapped onto device_initcall, our use of device_initcall
directly in this change means that the runtime impact is
zero -- it will remain at level 6 in initcall ordering.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/sparc/kernel/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 7de8d1f..1555bbc 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -1005,6 +1005,5 @@ static int __init of_pci_slot_init(void)
 
 	return 0;
 }
-
-module_init(of_pci_slot_init);
+device_initcall(of_pci_slot_init);
 #endif
-- 
1.8.4.1

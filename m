From: Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC PATCH 02/28] kbuild: allow architectures to automatically define kconfig symbols
Date: Tue,  3 Nov 2015 22:20:33 +0200
Message-ID: <1446582059-17355-3-git-send-email-octavian.purdila@intel.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:38789 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753672AbbKCUXE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 3 Nov 2015 15:23:04 -0500
In-Reply-To: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, thehajime@gmail.com, Octavian Purdila <octavian.purdila@intel.com>

This patch calls an architecture hook during the kernel config process
that allows the architecture to automatically define kconfig
symbols. This can be done by exporting environment variables from the
new architecture hook.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index d5b3739..668b8fe 100644
--- a/Makefile
+++ b/Makefile
@@ -554,6 +554,7 @@ endif # KBUILD_EXTMOD
 
 ifeq ($(dot-config),1)
 # Read in config
+-include arch/$(SRCARCH)/auto.conf
 -include include/config/auto.conf
 
 ifeq ($(KBUILD_EXTMOD),)
-- 
2.1.0

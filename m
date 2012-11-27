Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:46107 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756768Ab2K0X3g (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 27 Nov 2012 18:29:36 -0500
From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH V7 4/7] openrisc: use new common dtc rule
Date: Tue, 27 Nov 2012 16:29:13 -0700
Message-ID: <1354058956-7199-4-git-send-email-swarren@wwwdotorg.org>
In-Reply-To: <1354058956-7199-1-git-send-email-swarren@wwwdotorg.org>
References: <1354058956-7199-1-git-send-email-swarren@wwwdotorg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Marek <mmarek@suse.cz>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, Jonas Bonn <jonas@southpole.se>, linux@lists.openrisc.net
Message-ID: <20121127232913.4X8clWMfb-y72HfKJAXyb3pHJEw1KTbkAvImo3Tmz8U@z>

From: Stephen Warren <swarren@nvidia.com>

The current rules have the .dtb files build in a different directory
from the .dts files. This patch changes openrisc to use the generic dtb
rule which builds .dtb files in the same directory as the source .dts.

This requires renaming arch/openrisc/boot/Makefile to
arch/openrisc/boot/dts/Makefile, and updating arch/openrisc/Makefile to
call the new Makefile.

Cc: Jonas Bonn <jonas@southpole.se>
Cc: linux@lists.openrisc.net
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v7: New patch.
---
 arch/openrisc/Makefile                |    2 +-
 arch/openrisc/boot/{ => dts}/Makefile |    5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)
 rename arch/openrisc/boot/{ => dts}/Makefile (75%)

diff --git a/arch/openrisc/Makefile b/arch/openrisc/Makefile
index 966886c..4739b83 100644
--- a/arch/openrisc/Makefile
+++ b/arch/openrisc/Makefile
@@ -50,6 +50,6 @@ BUILTIN_DTB := y
 else
 BUILTIN_DTB := n
 endif
-core-$(BUILTIN_DTB) += arch/openrisc/boot/
+core-$(BUILTIN_DTB) += arch/openrisc/boot/dts/
 
 all: vmlinux
diff --git a/arch/openrisc/boot/Makefile b/arch/openrisc/boot/dts/Makefile
similarity index 75%
rename from arch/openrisc/boot/Makefile
rename to arch/openrisc/boot/dts/Makefile
index 0995835..b092d30 100644
--- a/arch/openrisc/boot/Makefile
+++ b/arch/openrisc/boot/dts/Makefile
@@ -1,5 +1,3 @@
-
-
 ifneq '$(CONFIG_OPENRISC_BUILTIN_DTB)' '""'
 BUILTIN_DTB := $(patsubst "%",%,$(CONFIG_OPENRISC_BUILTIN_DTB)).dtb.o
 else
@@ -10,6 +8,3 @@ obj-y += $(BUILTIN_DTB)
 clean-files := *.dtb.S
 
 #DTC_FLAGS ?= -p 1024
-
-$(obj)/%.dtb: $(src)/dts/%.dts FORCE
-	$(call if_changed_dep,dtc)
-- 
1.7.10.4


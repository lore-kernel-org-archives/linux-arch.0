Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50023 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756498Ab0LATma (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 1 Dec 2010 14:42:30 -0500
From: dirk.brandewie@gmail.com
Subject: [PATCH 2/4] x86/of: Add building device tree blob(s) into image.
Date: Wed,  1 Dec 2010 11:41:33 -0800
Message-ID: <b5a8dfa4d580d8637132f81317390a535ab98511.1291231792.git.dirk.brandewie@gmail.com>
In-Reply-To: <cover.1289943240.git.dirk.brandewie@gmail.com>
References: <cover.1289943240.git.dirk.brandewie@gmail.com>
In-Reply-To: <cover.1291231792.git.dirk.brandewie@gmail.com>
References: <cover.1291231792.git.dirk.brandewie@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-serial@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, sodaville@linutronix.de, linuxppc-dev@lists.ozlabs.org, microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org, mmarek@suse.cz, Dirk Brandewie <dirk.brandewie@gmail.com>
Message-ID: <20101201194133.Yfsp4B54jjWA8ulEL4cDCaTish2Xp-BfNf8rsQhIjvo@z>

From: Dirk Brandewie <dirk.brandewie@gmail.com>

This patch adds linking device tree blob into vmlinux. DTB's are
added by adding the blob object name to list of objects to be linked
into the image.

Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
---
 arch/x86/platform/ce4100/Makefile |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/x86/platform/ce4100/Makefile b/arch/x86/platform/ce4100/Makefile
index 91fc929..3b49187 100644
--- a/arch/x86/platform/ce4100/Makefile
+++ b/arch/x86/platform/ce4100/Makefile
@@ -1 +1,11 @@
 obj-$(CONFIG_X86_INTEL_CE)	+= ce4100.o
+clean-files := *dtb.S
+
+ifdef CONFIG_X86_OF
+###
+# device tree blob
+obj-$(CONFIG_X86_INTEL_CE) += ce4100.dtb.o
+
+$(obj)/%.dtb: $(src)/%.dts
+	$(call if_changed,dtc)
+endif
-- 
1.7.2.3


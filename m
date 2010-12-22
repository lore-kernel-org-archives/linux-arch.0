Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55396 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040Ab0LVT5q (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 22 Dec 2010 14:57:46 -0500
From: dirk.brandewie@gmail.com
Subject: [PATCH 2/4] x86/of: Add building device tree blob(s) into image.
Date: Wed, 22 Dec 2010 11:57:27 -0800
Message-ID: <1293047849-26078-3-git-send-email-dirk.brandewie@gmail.com>
In-Reply-To: <1293047849-26078-1-git-send-email-dirk.brandewie@gmail.com>
References: <1293047849-26078-1-git-send-email-dirk.brandewie@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org, microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org, mmarek@suse.cz, dirk.brandewie@gmail.com, linux-kbuild@vger.kernel.org
Message-ID: <20101222195727.asnG2izT2buVBiDx2SRg0uOsi7qItES6Fi5OQAcAbTc@z>

From: Dirk Brandewie <dirk.brandewie@gmail.com>

This patch adds linking device tree blob into vmlinux. DTB's are
added by adding the blob object name to list of objects to be linked
into the image.

Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
---
 arch/x86/platform/ce4100/Makefile |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/x86/platform/ce4100/Makefile b/arch/x86/platform/ce4100/Makefile
index 91fc929..e5f3b7b 100644
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
+	$(call cmd,dtc)
+endif
-- 
1.7.2.3


Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35383 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753980AbeDTHem (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Apr 2018 03:34:42 -0400
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 3/4] kbuild: Allow LD_DEAD_CODE_DATA_ELIMINATION to be selectable if enabled
Date: Fri, 20 Apr 2018 17:34:13 +1000
Message-ID: <20180420073414.23169-4-npiggin@gmail.com>
In-Reply-To: <20180420073414.23169-1-npiggin@gmail.com>
References: <20180420073414.23169-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>, Nicolas Pitre <nico@fluxnic.net>
Message-ID: <20180420073413.-APPk0O8RFwRTR4JuP_H8xbVCfZWNHn4fe-wiNHlLDU@z>

Architectures that are capable can select
HAVE_LD_DEAD_CODE_DATA_ELIMINATION to enable selection of that
option (as an EXPERT kernel option).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/Kconfig | 15 ---------------
 init/Kconfig | 27 +++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8e0d665c8d53..3234b73d4626 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -596,21 +596,6 @@ config CC_STACKPROTECTOR_AUTO
 
 endchoice
 
-config LD_DEAD_CODE_DATA_ELIMINATION
-	bool
-	help
-	  Select this if the architecture wants to do dead code and
-	  data elimination with the linker by compiling with
-	  -ffunction-sections -fdata-sections and linking with
-	  --gc-sections.
-
-	  This requires that the arch annotates or otherwise protects
-	  its external entry points from being discarded. Linker scripts
-	  must also merge .text.*, .data.*, and .bss.* correctly into
-	  output sections. Care must be taken not to pull in unrelated
-	  sections (e.g., '.text.init'). Typically '.' in section names
-	  is used to distinguish them from label names / C identifiers.
-
 config HAVE_ARCH_WITHIN_STACK_FRAMES
 	bool
 	help
diff --git a/init/Kconfig b/init/Kconfig
index f013afc74b11..1706d963766b 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1038,6 +1038,33 @@ config CC_OPTIMIZE_FOR_SIZE
 
 endchoice
 
+config HAVE_LD_DEAD_CODE_DATA_ELIMINATION
+	bool
+	help
+	  This requires that the arch annotates or otherwise protects
+	  its external entry points from being discarded. Linker scripts
+	  must also merge .text.*, .data.*, and .bss.* correctly into
+	  output sections. Care must be taken not to pull in unrelated
+	  sections (e.g., '.text.init'). Typically '.' in section names
+	  is used to distinguish them from label names / C identifiers.
+
+config LD_DEAD_CODE_DATA_ELIMINATION
+	bool "Dead code and data elimination (EXPERIMENTAL)"
+	depends on HAVE_LD_DEAD_CODE_DATA_ELIMINATION
+	depends on EXPERT
+	help
+	  Select this if the architecture wants to do dead code and
+	  data elimination with the linker by compiling with
+	  -ffunction-sections -fdata-sections, and linking with
+	  --gc-sections.
+
+	  This can reduce on disk and in-memory size of the kernel
+	  code and static data, particularly for small configs and
+	  on small systems. This has the possibility of introducing
+	  silently broken kernel if the required annotations are not
+	  present. This option is not well tested yet, so use at your
+	  own risk.
+
 config SYSCTL
 	bool
 
-- 
2.17.0

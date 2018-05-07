Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51022 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752275AbeEGKof (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 May 2018 06:44:35 -0400
Received: by mail-wm0-f67.google.com with SMTP id t11so12660556wmt.0
        for <linux-arch@vger.kernel.org>; Mon, 07 May 2018 03:44:34 -0700 (PDT)
From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [RFC PATCH v3 6/6] Documentation/features/vm: Remove arch support status file for 'pte_special'
Date: Mon,  7 May 2018 12:43:43 +0200
Message-ID: <1525689823-3340-7-git-send-email-andrea.parri@amarulasolutions.com>
In-Reply-To: <1525689823-3340-1-git-send-email-andrea.parri@amarulasolutions.com>
References: <1525689823-3340-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, paulmck@linux.vnet.ibm.com, Andrea Parri <andrea.parri@amarulasolutions.com>
Message-ID: <20180507104343.xX9e6bmXjD-UULGCikSVP45P-fyrvSNrKYBnYMUurfA@z>

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 .../features/vm/pte_special/arch-support.txt       | 33 ----------------------
 1 file changed, 33 deletions(-)
 delete mode 100644 Documentation/features/vm/pte_special/arch-support.txt

diff --git a/Documentation/features/vm/pte_special/arch-support.txt b/Documentation/features/vm/pte_special/arch-support.txt
deleted file mode 100644
index 6a608a6dcf71d..0000000000000
--- a/Documentation/features/vm/pte_special/arch-support.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-#
-# Feature name:          pte_special
-#         Kconfig:       __HAVE_ARCH_PTE_SPECIAL
-#         description:   arch supports the pte_special()/pte_mkspecial() VM APIs
-#
-    -----------------------
-    |         arch |status|
-    -----------------------
-    |       alpha: | TODO |
-    |         arc: |  ok  |
-    |         arm: |  ok  |
-    |       arm64: |  ok  |
-    |         c6x: | TODO |
-    |       h8300: | TODO |
-    |     hexagon: | TODO |
-    |        ia64: | TODO |
-    |        m68k: | TODO |
-    |  microblaze: | TODO |
-    |        mips: | TODO |
-    |       nds32: | TODO |
-    |       nios2: | TODO |
-    |    openrisc: | TODO |
-    |      parisc: | TODO |
-    |     powerpc: |  ok  |
-    |       riscv: | TODO |
-    |        s390: |  ok  |
-    |          sh: |  ok  |
-    |       sparc: |  ok  |
-    |          um: | TODO |
-    |   unicore32: | TODO |
-    |         x86: |  ok  |
-    |      xtensa: | TODO |
-    -----------------------
-- 
2.7.4

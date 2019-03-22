Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conuserg-12.nifty.com ([210.131.2.79]:22663 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfCVPPJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Mar 2019 11:15:09 -0400
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/2] arch: remove <asm/sizes.h> amd <asm-generic/sizes.h>
Date: Sat, 23 Mar 2019 00:14:25 +0900
Message-ID: <1553267665-27228-2-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1553267665-27228-1-git-send-email-yamada.masahiro@socionext.com>
References: <1553267665-27228-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>
Message-ID: <20190322151425.xqnjMFIu5dkFLWELd0fG6qpo0AKfLNJbyxDDFgwbXuU@z>

Now that all instances of #include <asm/sizes.h> have been replaced
with #include <linux/sizes.h>, we can remove these.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/include/asm/Kbuild       | 1 -
 arch/arm64/include/asm/Kbuild     | 1 -
 arch/h8300/include/asm/Kbuild     | 1 -
 arch/hexagon/include/asm/Kbuild   | 1 -
 arch/nds32/include/asm/Kbuild     | 1 -
 arch/sh/include/asm/Kbuild        | 1 -
 arch/unicore32/include/asm/Kbuild | 1 -
 include/asm-generic/sizes.h       | 2 --
 8 files changed, 9 deletions(-)
 delete mode 100644 include/asm-generic/sizes.h

diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index a8a4eb7..1e8ab83 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -17,7 +17,6 @@ generic-y += seccomp.h
 generic-y += segment.h
 generic-y += serial.h
 generic-y += simd.h
-generic-y += sizes.h
 generic-y += trace_clock.h
 
 generated-y += mach-types.h
diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 1e17ea5..7ef561c 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -20,7 +20,6 @@ generic-y += rwsem.h
 generic-y += segment.h
 generic-y += serial.h
 generic-y += set_memory.h
-generic-y += sizes.h
 generic-y += switch_to.h
 generic-y += trace_clock.h
 generic-y += unaligned.h
diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
index 3e7c8ec..63f59b0 100644
--- a/arch/h8300/include/asm/Kbuild
+++ b/arch/h8300/include/asm/Kbuild
@@ -40,7 +40,6 @@ generic-y += scatterlist.h
 generic-y += sections.h
 generic-y += serial.h
 generic-y += shmparam.h
-generic-y += sizes.h
 generic-y += spinlock.h
 generic-y += timex.h
 generic-y += tlbflush.h
diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
index b25fd42..e8d12ee 100644
--- a/arch/hexagon/include/asm/Kbuild
+++ b/arch/hexagon/include/asm/Kbuild
@@ -31,7 +31,6 @@ generic-y += sections.h
 generic-y += segment.h
 generic-y += serial.h
 generic-y += shmparam.h
-generic-y += sizes.h
 generic-y += topology.h
 generic-y += trace_clock.h
 generic-y += unaligned.h
diff --git a/arch/nds32/include/asm/Kbuild b/arch/nds32/include/asm/Kbuild
index 64ceff7..82c1206 100644
--- a/arch/nds32/include/asm/Kbuild
+++ b/arch/nds32/include/asm/Kbuild
@@ -38,7 +38,6 @@ generic-y += preempt.h
 generic-y += sections.h
 generic-y += segment.h
 generic-y += serial.h
-generic-y += sizes.h
 generic-y += switch_to.h
 generic-y += timex.h
 generic-y += topology.h
diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index a6ef3fe..d283257 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -18,6 +18,5 @@ generic-y += percpu.h
 generic-y += preempt.h
 generic-y += rwsem.h
 generic-y += serial.h
-generic-y += sizes.h
 generic-y += trace_clock.h
 generic-y += xor.h
diff --git a/arch/unicore32/include/asm/Kbuild b/arch/unicore32/include/asm/Kbuild
index 1d1544b..f061a24 100644
--- a/arch/unicore32/include/asm/Kbuild
+++ b/arch/unicore32/include/asm/Kbuild
@@ -29,7 +29,6 @@ generic-y += sections.h
 generic-y += segment.h
 generic-y += serial.h
 generic-y += shmparam.h
-generic-y += sizes.h
 generic-y += syscalls.h
 generic-y += topology.h
 generic-y += trace_clock.h
diff --git a/include/asm-generic/sizes.h b/include/asm-generic/sizes.h
deleted file mode 100644
index 1dcfad9..0000000
--- a/include/asm-generic/sizes.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* This is a placeholder, to be removed over time */
-#include <linux/sizes.h>
-- 
2.7.4

From: Alex Bee <knaerzche@gmail.com>
Subject: [PATCH] linux: arm: vdso: nullpatch vdso_clock_gettime64 for non-virtual timers
Date: Thu, 16 Jul 2020 17:07:23 +0200
Message-ID: <20200716150723.9389-1-knaerzche@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbgGPPHc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 11:07:32 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA83EC061755
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2020 08:07:31 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s10so7371527wrw.12
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2020 08:07:31 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Alex Bee <knaerzche@gmail.com>, linux-arm-kernel@lists.infradead.org, Russell King <linux@armlinux.org.uk>, Daniel Jordan <daniel.m.jordan@oracle.com>, Florian Fainelli <f.fainelli@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, Vincenzo Frascino <vincenzo.frascino@arm.com>

Along with commit commit 74d06efb9c2f ("ARM: 8932/1: Add clock_gettime64
entry point") clock_gettime64 was added for ARM platform to solve the
y2k38 problem on 32-bit platforms. glibc from version 2.31 onwards
started using this vdso-call on ARM platforms.
However it was (probably) forgotten to "nullpatch" this call, when no
reliable timer source is available, for example when
"arm,cpu-registers-not-fw-configured" is defined in devicetree for
"arm,armv7-timer".
This results in erratic time jumps whenever "gettimeofday" gets called,
since the (non-working) vdso-call will be used instead of a syscall.

This patch adds clock_gettime64 to get nullpatched as well. It has been
verified to work and solve this issue on Rockchip RK322x, RK3288 and
RPi4 (32-bit kernel build) platforms.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/kernel/vdso.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index 6bfdca4769a7..fddd08a6e063 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -184,6 +184,7 @@ static void __init patch_vdso(void *ehdr)
 	if (!cntvct_ok) {
 		vdso_nullpatch_one(&einfo, "__vdso_gettimeofday");
 		vdso_nullpatch_one(&einfo, "__vdso_clock_gettime");
+		vdso_nullpatch_one(&einfo, "__vdso_clock_gettime64");
 	}
 }
 
-- 
2.17.1

Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:34461 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfCGQFl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Mar 2019 11:05:41 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4/4] arm64: vdso: turn off profiling etc
Date: Thu,  7 Mar 2019 17:05:32 +0100
Message-Id: <20190307160532.3328288-5-arnd@arndb.de>
In-Reply-To: <20190307160532.3328288-1-arnd@arndb.de>
References: <20190307160532.3328288-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

I took this from the x86 version, without it, all
kinds of things fail to build in the vdso.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/kernel/vdso/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index c904b2a9b255..3768600219c0 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -25,6 +25,12 @@ ccflags-y += -nostdlib -Wl,-soname=linux-vdso.so.1 \
 VDSO_LDFLAGS := -Bsymbolic
 
 CFLAGS_REMOVE_vgettimeofday.o = -pg -Os
+KBUILD_CFLAGS			+= $(DISABLE_LTO)
+KASAN_SANITIZE                  := n
+UBSAN_SANITIZE                  := n
+OBJECT_FILES_NON_STANDARD       := y
+KCOV_INSTRUMENT			:= n
+
 ifeq ($(c-gettimeofday-y),)
 CFLAGS_vgettimeofday.o = -O2 -mcmodel=tiny
 else
-- 
2.20.0

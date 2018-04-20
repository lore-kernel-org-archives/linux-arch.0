Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41052 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753980AbeDTHej (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Apr 2018 03:34:39 -0400
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 2/4] kbuild: LD_DEAD_CODE_DATA_ELIMINATION no -ffunction-sections/-fdata-sections for module build
Date: Fri, 20 Apr 2018 17:34:12 +1000
Message-ID: <20180420073414.23169-3-npiggin@gmail.com>
In-Reply-To: <20180420073414.23169-1-npiggin@gmail.com>
References: <20180420073414.23169-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>, Nicolas Pitre <nico@fluxnic.net>
Message-ID: <20180420073412.n9Q61TUPUldnC4Lz40njc2L_KIMAHi52JJAoXSl8Pgo@z>

Modules do not tend to cope with -ffunction-sections, even though they
do not link with -gc-sections. It may be possible for unused symbols to
be trimmed from modules, but in general that would take much more work
in architecture module linker scripts.

For now, enable these only for kernel build.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index e811e0c509c5..2ed651403bb4 100644
--- a/Makefile
+++ b/Makefile
@@ -799,8 +799,8 @@ KBUILD_CFLAGS += $(call cc-option, -fno-inline-functions-called-once)
 endif
 
 ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
-KBUILD_CFLAGS	+= $(call cc-option,-ffunction-sections,)
-KBUILD_CFLAGS	+= $(call cc-option,-fdata-sections,)
+KBUILD_CFLAGS_KERNEL	+= $(call cc-option,-ffunction-sections,)
+KBUILD_CFLAGS_KERNEL	+= $(call cc-option,-fdata-sections,)
 endif
 
 # arch Makefile may override CC so keep this after arch Makefile is included
-- 
2.17.0

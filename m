Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gerard.telenet-ops.be ([195.130.132.48]:39803 "EHLO
	gerard.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753568Ab3KYIzp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Nov 2013 03:55:45 -0500
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 10/24] sh/uapi: Use Kbuild logic to include <asm-generic/types.h>
Date: Mon, 25 Nov 2013 09:55:20 +0100
Message-ID: <1385369734-24893-11-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1385369734-24893-1-git-send-email-geert@linux-m68k.org>
References: <1385369734-24893-1-git-send-email-geert@linux-m68k.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org
Message-ID: <20131125085520.hyTVgK6QXnJi6CDXYyZnD3nAHyXtByMmcBcDYXzUN_0@z>

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/include/uapi/asm/Kbuild  |    3 ++-
 arch/sh/include/uapi/asm/types.h |    1 -
 2 files changed, 2 insertions(+), 2 deletions(-)
 delete mode 100644 arch/sh/include/uapi/asm/types.h

diff --git a/arch/sh/include/uapi/asm/Kbuild b/arch/sh/include/uapi/asm/Kbuild
index 60613ae78513..03b29041b09f 100644
--- a/arch/sh/include/uapi/asm/Kbuild
+++ b/arch/sh/include/uapi/asm/Kbuild
@@ -1,6 +1,8 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
+generic-y += types.h
+
 header-y += auxvec.h
 header-y += byteorder.h
 header-y += cachectl.h
@@ -19,7 +21,6 @@ header-y += signal.h
 header-y += sockios.h
 header-y += stat.h
 header-y += swab.h
-header-y += types.h
 header-y += unistd.h
 header-y += unistd_32.h
 header-y += unistd_64.h
diff --git a/arch/sh/include/uapi/asm/types.h b/arch/sh/include/uapi/asm/types.h
deleted file mode 100644
index b9e79bc580dd..000000000000
--- a/arch/sh/include/uapi/asm/types.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/types.h>
-- 
1.7.9.5


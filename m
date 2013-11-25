From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 05/24] m32r/uapi: Use Kbuild logic to provide <asm/types.h>
Date: Mon, 25 Nov 2013 09:55:15 +0100
Message-ID: <1385369734-24893-6-git-send-email-geert@linux-m68k.org>
References: <1385369734-24893-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1385369734-24893-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Hirokazu Takata <takata@linux-m32r.org>, linux-m32r@ml.linux-m32r.org
List-Id: linux-arch.vger.kernel.org

Uapi <asm-generic/types.h> just includes <asm-generic/int-ll64.h>

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-m32r@ml.linux-m32r.org
---
 arch/m32r/include/uapi/asm/Kbuild  |    3 ++-
 arch/m32r/include/uapi/asm/types.h |    1 -
 2 files changed, 2 insertions(+), 2 deletions(-)
 delete mode 100644 arch/m32r/include/uapi/asm/types.h

diff --git a/arch/m32r/include/uapi/asm/Kbuild b/arch/m32r/include/uapi/asm/Kbuild
index 43937a61d6cf..87f6d698fb9c 100644
--- a/arch/m32r/include/uapi/asm/Kbuild
+++ b/arch/m32r/include/uapi/asm/Kbuild
@@ -1,6 +1,8 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
+generic-y += types.h
+
 header-y += auxvec.h
 header-y += bitsperlong.h
 header-y += byteorder.h
@@ -29,5 +31,4 @@ header-y += statfs.h
 header-y += swab.h
 header-y += termbits.h
 header-y += termios.h
-header-y += types.h
 header-y += unistd.h
diff --git a/arch/m32r/include/uapi/asm/types.h b/arch/m32r/include/uapi/asm/types.h
deleted file mode 100644
index 9ec9d4c5ac4d..000000000000
--- a/arch/m32r/include/uapi/asm/types.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/int-ll64.h>
-- 
1.7.9.5

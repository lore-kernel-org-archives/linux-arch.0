From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 54/66] include/asm-generic/kdebug.h: Checkpatch cleanup
Date: Sat, 27 Feb 2010 17:51:35 +0100
Message-ID: <1267289508-31031-55-git-send-email-andrea.gelmini@gelma.net>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Andrea Gelmini <andrea.gelmini@gelma.net>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

include/asm-generic/kdebug.h:6: ERROR: spaces required around that '=' (ctx:VxV)

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 include/asm-generic/kdebug.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-generic/kdebug.h b/include/asm-generic/kdebug.h
index 11e57b6..832be39 100644
--- a/include/asm-generic/kdebug.h
+++ b/include/asm-generic/kdebug.h
@@ -3,7 +3,7 @@
 
 enum die_val {
 	DIE_UNUSED,
-	DIE_OOPS=1
+	DIE_OOPS = 1
 };
 
 #endif /* _ASM_GENERIC_KDEBUG_H */
-- 
1.7.0.90.g251a4

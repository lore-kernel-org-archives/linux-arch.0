From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4/6] asm-generic: kdebug.h: Checkpatch cleanup
Date: Sat,  9 Oct 2010 21:57:50 +0200
Message-ID: <1286654272-21483-5-git-send-email-arnd@arndb.de>
References: <1286654272-21483-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1286654272-21483-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Andrea Gelmini <andrea.gelmini@gelma.net>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

From: Andrea Gelmini <andrea.gelmini@gelma.net>

include/asm-generic/kdebug.h:6: ERROR: spaces required around that '=' (ctx:VxV)

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/kdebug.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-generic/kdebug.h b/include/asm-generic/kdebug.h
index 11e57b6..d181449 100644
--- a/include/asm-generic/kdebug.h
+++ b/include/asm-generic/kdebug.h
@@ -3,7 +3,7 @@
 
 enum die_val {
 	DIE_UNUSED,
-	DIE_OOPS=1
+	DIE_OOPS = 1,
 };
 
 #endif /* _ASM_GENERIC_KDEBUG_H */
-- 
1.7.1

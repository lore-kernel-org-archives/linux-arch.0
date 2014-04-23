Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.89.28.114]:28224 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbaDWKIi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 Apr 2014 06:08:38 -0400
From: James Hogan <james.hogan@imgtec.com>
Subject: [RFC 2/3] scripts/checksyscalls.sh: Make renameat optional
Date: Wed, 23 Apr 2014 11:08:06 +0100
Message-ID: <1398247687-13453-3-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1398247687-13453-1-git-send-email-james.hogan@imgtec.com>
References: <1398247687-13453-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, James Hogan <james.hogan@imgtec.com>
Message-ID: <20140423100806.I8ckSvfleUSNcll-c4rc14ghtsMx6-joODLCRLniGuQ@z>

The new renameat2 syscall provides all the functionality of renameat
with an additional flags argument, so make renameat optional so that
future architectures can omit it without getting a warning.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
---
This patch doesn't affect existing architectures, so there's no harm for
this to wait for the v3.16 merge window.
---
 scripts/checksyscalls.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
index fd8fa9aa7c4e..5b3add31f9f1 100755
--- a/scripts/checksyscalls.sh
+++ b/scripts/checksyscalls.sh
@@ -25,7 +25,7 @@ cat << EOF
 #define __IGNORE_rmdir		/* unlinkat */
 #define __IGNORE_lchown		/* fchownat */
 #define __IGNORE_access		/* faccessat */
-#define __IGNORE_rename		/* renameat */
+#define __IGNORE_rename		/* renameat2 */
 #define __IGNORE_readlink	/* readlinkat */
 #define __IGNORE_symlink	/* symlinkat */
 #define __IGNORE_utimes		/* futimesat */
@@ -37,6 +37,9 @@ cat << EOF
 #define __IGNORE_lstat64	/* fstatat64 */
 #endif
 
+/* Missing flags argument */
+#define __IGNORE_renameat	/* renameat2 */
+
 /* CLOEXEC flag */
 #define __IGNORE_pipe		/* pipe2 */
 #define __IGNORE_dup2		/* dup3 */
-- 
1.8.1.2


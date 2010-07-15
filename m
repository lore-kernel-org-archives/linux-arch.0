From: Ted Percival <ted@midg3t.net>
Subject: [PATCH 1/2] fcntl.h comment: FD_CLOEXEC is for F_[GET|SET]FD
Date: Thu, 15 Jul 2010 11:29:16 -0600
Message-ID: <1279214957-10235-1-git-send-email-ted@tedp.id.au>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from arcueid.lazypants.org ([208.78.100.164]:56088 "EHLO
	arcueid.lazypants.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933954Ab0GOSL4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jul 2010 14:11:56 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Ted Percival <ted@tedp.id.au>

Not for F_[GET|SET]FL

Signed-off-by: Ted Percival <ted@tedp.id.au>
---
 include/asm-generic/fcntl.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-generic/fcntl.h b/include/asm-generic/fcntl.h
index 4d3e483..65e18d3 100644
--- a/include/asm-generic/fcntl.h
+++ b/include/asm-generic/fcntl.h
@@ -74,7 +74,7 @@
 #define F_GETSIG	11	/* for sockets. */
 #endif
 
-/* for F_[GET|SET]FL */
+/* for F_[GET|SET]FD */
 #define FD_CLOEXEC	1	/* actually anything with low bit set goes */
 
 /* for posix fcntl() and lockf() */
-- 
1.7.1

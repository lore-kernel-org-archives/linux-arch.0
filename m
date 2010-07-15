From: Ted Percival <ted@midg3t.net>
Subject: [PATCH 2/2] fcntl.h comment: Fix typo regarding O_SYNC
Date: Thu, 15 Jul 2010 11:29:17 -0600
Message-ID: <1279214957-10235-2-git-send-email-ted@tedp.id.au>
References: <1279214957-10235-1-git-send-email-ted@tedp.id.au>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from arcueid.lazypants.org ([208.78.100.164]:56089 "EHLO
	arcueid.lazypants.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933954Ab0GOSL5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jul 2010 14:11:57 -0400
In-Reply-To: <1279214957-10235-1-git-send-email-ted@tedp.id.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Ted Percival <ted@tedp.id.au>


Signed-off-by: Ted Percival <ted@tedp.id.au>
---
 include/asm-generic/fcntl.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-generic/fcntl.h b/include/asm-generic/fcntl.h
index 65e18d3..d6e84ba 100644
--- a/include/asm-generic/fcntl.h
+++ b/include/asm-generic/fcntl.h
@@ -3,7 +3,7 @@
 
 #include <linux/types.h>
 
-/* open/fcntl - O_SYNC is only implemented on blocks devices and on files
+/* open/fcntl - O_SYNC is only implemented on block devices and on files
    located on an ext2 file system */
 #define O_ACCMODE	00000003
 #define O_RDONLY	00000000
-- 
1.7.1

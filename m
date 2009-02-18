From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [RFC PATCH] kernel: add -D__CHECK_ENDIAN__ by default
Date: Wed, 18 Feb 2009 13:33:01 -0800
Message-ID: <1234992781.31073.192.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:18817 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611AbZBRVdE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 18 Feb 2009 16:33:04 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>

The noise level with endian checking is getting to the point where
having this enabled by default wouldn't be too bad.  If this were to
go in for the 2.6.30 devel cycle it may motivate the last sections that
are still particularly noisy (sound/, drivers/scsi/ come to mind)

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 96628d0..4d4e400 100644
--- a/Makefile
+++ b/Makefile
@@ -326,7 +326,7 @@ PERL		= perl
 CHECK		= sparse
 
 CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ \
-		  -Wbitwise -Wno-return-void $(CF)
+		  -D__CHECK_ENDIAN__ -Wbitwise -Wno-return-void $(CF)
 MODFLAGS	= -DMODULE
 CFLAGS_MODULE   = $(MODFLAGS)
 AFLAGS_MODULE   = $(MODFLAGS)
-- 
1.6.2.rc1.175.g96b8a

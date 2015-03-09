Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:50545 "EHLO
	mail2.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458AbbCIIrY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Mar 2015 04:47:24 -0400
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v6 16/16] mksysmap: Add h8300 local symbol pattern
Date: Mon,  9 Mar 2015 17:47:10 +0900
Message-ID: <1425890830-29399-17-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1425890830-29399-1-git-send-email-ysato@users.sourceforge.jp>
References: <1425890830-29399-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20150309084710.JKPmE5heeFyiWQXlA0R5FWi5_ZfG2nYT6zX6_3jqJBE@z>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 scripts/mksysmap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mksysmap b/scripts/mksysmap
index 7ada35a..a35acc0 100755
--- a/scripts/mksysmap
+++ b/scripts/mksysmap
@@ -41,4 +41,4 @@
 # so we just ignore them to let readprofile continue to work.
 # (At least sparc64 has __crc_ in the middle).
 
-$NM -n $1 | grep -v '\( [aNUw] \)\|\(__crc_\)\|\( \$[adt]\)' > $2
+$NM -n $1 | grep -v '\( [aNUw] \)\|\(__crc_\)\|\( \$[adt]\)\|\( .L\)' > $2
-- 
2.1.4


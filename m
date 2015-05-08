From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v11 02/19] mksysmap: Add h8300 local symbol pattern
Date: Sat,  9 May 2015 00:04:22 +0900
Message-ID: <1431097479-21101-3-git-send-email-ysato@users.sourceforge.jp>
References: <1431097479-21101-1-git-send-email-ysato@users.sourceforge.jp>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:14384 "EHLO
	mail2.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963AbbEHPEw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 8 May 2015 11:04:52 -0400
In-Reply-To: <1431097479-21101-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

h8300's nm output have a lot of local symbols.
ex)
00000000 N .Lframe0
00000013 N .LLST1
00000026 N .LLST2
00000039 N .LLST3
0000004c N .LLST4
Added new pattern " .L" to filter rule.

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

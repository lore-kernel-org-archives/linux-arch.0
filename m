Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:26580 "EHLO
	mail2.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735AbbCKOVX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 11 Mar 2015 10:21:23 -0400
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v7 16/17] mksysmap: Add h8300 local symbol pattern
Date: Wed, 11 Mar 2015 23:21:07 +0900
Message-ID: <1426083668-5011-17-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1426083668-5011-1-git-send-email-ysato@users.sourceforge.jp>
References: <1426083668-5011-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20150311142107.lUwDBAU3l6y2114QqKA3Gn0PbIIVjBDBEEmWOeyY5Ac@z>

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


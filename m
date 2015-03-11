From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v7 16/17] mksysmap: Add h8300 local symbol pattern
Date: Wed, 11 Mar 2015 23:21:07 +0900
Message-ID: <1426083668-5011-17-git-send-email-ysato@users.sourceforge.jp>
References: <1426083668-5011-1-git-send-email-ysato@users.sourceforge.jp>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426083668-5011-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
List-Id: linux-arch.vger.kernel.org

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

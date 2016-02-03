From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH v2 09/13] ppc: get rid of unreachable abs() implementation
Date: Wed,  3 Feb 2016 21:20:41 +0000
Message-ID: <1454534445-16759-9-git-send-email-viro@ZenIV.linux.org.uk>
References: <20160203211953.GT17997@ZenIV.linux.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160203211953.GT17997@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Both the extern and export had been killed off by Christoph
back in 2004; the actual implementation had been left behind.
Time to end that depravity, let's bury the body...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/powerpc/kernel/misc_32.S | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index b1519c5..a3d3de6 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -696,12 +696,6 @@ _GLOBAL(__bswapdi2)
 	blr
 EXPORT_SYMBOL(__bswapdi2)
 
-_GLOBAL(abs)
-	srawi	r4,r3,31
-	xor	r3,r3,r4
-	sub	r3,r3,r4
-	blr
-
 #ifdef CONFIG_SMP
 _GLOBAL(start_secondary_resume)
 	/* Reset stack */
-- 
2.1.4

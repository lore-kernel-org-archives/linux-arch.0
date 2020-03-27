From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [RFC][PATCH 05/14] ia64: csum_partial_copy_nocheck(): don't abuse csum_partial_copy_from_user()
Date: Fri, 27 Mar 2020 23:31:08 +0000
Message-ID: <20200327233117.1031393-5-viro@ZenIV.linux.org.uk>
References: <20200327233006.GW23230@ZenIV.linux.org.uk>
 <20200327233117.1031393-1-viro@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200327233117.1031393-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Just inline the call and use memcpy() instead of __copy_from_user() and
note that the tail is precisely ia64 csum_partial().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/ia64/lib/csum_partial_copy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/lib/csum_partial_copy.c b/arch/ia64/lib/csum_partial_copy.c
index bf9396b1ed32..9ab570d0f756 100644
--- a/arch/ia64/lib/csum_partial_copy.c
+++ b/arch/ia64/lib/csum_partial_copy.c
@@ -134,8 +134,8 @@ EXPORT_SYMBOL(csum_partial_copy_from_user);
 __wsum
 csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum)
 {
-	return csum_partial_copy_from_user((__force const void __user *)src,
-					   dst, len, sum, NULL);
+	memcpy(dst, src, len);
+	return csum_partial(dst, len, sum);
 }
 
 EXPORT_SYMBOL(csum_partial_copy_nocheck);
-- 
2.11.0

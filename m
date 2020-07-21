From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH 04/18] csum_and_copy_..._user(): pass 0xffffffff instead of 0 as initial sum
Date: Tue, 21 Jul 2020 21:25:35 +0100
Message-ID: <20200721202549.4150745-4-viro@ZenIV.linux.org.uk>
References: <20200721202425.GA2786714@ZenIV.linux.org.uk>
 <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Preparation for the change of calling conventions; right now all
callers pass 0 as initial sum.  Passing 0xffffffff instead yields
the values comparable mod 0xffff and guarantees that 0 will not
be returned on success.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 7405922caaec..d5b7e204fea6 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1451,7 +1451,7 @@ size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 		int err = 0;
 		next = csum_and_copy_from_user(v.iov_base,
 					       (to += v.iov_len) - v.iov_len,
-					       v.iov_len, 0, &err);
+					       v.iov_len, ~0U, &err);
 		if (!err) {
 			sum = csum_block_add(sum, next, off);
 			off += v.iov_len;
@@ -1493,7 +1493,7 @@ bool csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum,
 		int err = 0;
 		next = csum_and_copy_from_user(v.iov_base,
 					       (to += v.iov_len) - v.iov_len,
-					       v.iov_len, 0, &err);
+					       v.iov_len, ~0U, &err);
 		if (err)
 			return false;
 		sum = csum_block_add(sum, next, off);
@@ -1539,7 +1539,7 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *csump,
 		int err = 0;
 		next = csum_and_copy_to_user((from += v.iov_len) - v.iov_len,
 					     v.iov_base,
-					     v.iov_len, 0, &err);
+					     v.iov_len, ~0U, &err);
 		if (!err) {
 			sum = csum_block_add(sum, next, off);
 			off += v.iov_len;
-- 
2.11.0

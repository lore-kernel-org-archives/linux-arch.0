From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] include/asm-generic/atomic.h: use 'unsigned int' instead
 of 'unsigned long' for atomic_clear_mask()
Date: Fri, 11 Oct 2013 09:41:33 +0800
Message-ID: <5257574D.1040604@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:48732 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034Ab3JKBmg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Oct 2013 21:42:36 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

For atomic_clear_mask(), 'v->counter' is 'int', so it is better to use
'unsigned int' instead of 'unsigned long' for parameter 'mask' to make
atomic_clear_mask() itself consistency.

And atomic_[set/clear]_mask() are pairs, the modification can also let
them consistent with each other.

Although the original implementation can not cause bugs, it is still
better to let it improved.


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 include/asm-generic/atomic.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-generic/atomic.h b/include/asm-generic/atomic.h
index 33bd2de..f31bff97 100644
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -153,7 +153,7 @@ static inline int __atomic_add_unless(atomic_t *v, int a, int u)
  * Atomically clears the bits set in @mask from @v
  */
 #ifndef atomic_clear_mask
-static inline void atomic_clear_mask(unsigned long mask, atomic_t *v)
+static inline void atomic_clear_mask(unsigned int mask, atomic_t *v)
 {
 	unsigned long flags;
 
-- 
1.7.7.6

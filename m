From: David Howells <dhowells@redhat.com>
Subject: [PATCH 03/13] Make generic bitops return bool
Date: Wed, 29 Apr 2015 20:21:52 +0100
Message-ID: <20150429192152.24909.61753.stgit@warthog.procyon.org.uk>
References: <20150429192133.24909.43184.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150429192133.24909.43184.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Make generic bit handling functions return a bool type when they're returning
a simple boolean value.  This allows gcc to make better choices and produce
better warnings.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/asm-generic/bitops/ext2-atomic.h |    4 ++--
 include/asm-generic/bitops/le.h          |   10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/bitops/ext2-atomic.h b/include/asm-generic/bitops/ext2-atomic.h
index 87f0f109d7f1..8048f8b38720 100644
--- a/include/asm-generic/bitops/ext2-atomic.h
+++ b/include/asm-generic/bitops/ext2-atomic.h
@@ -7,7 +7,7 @@
 
 #define ext2_set_bit_atomic(lock, nr, addr)		\
 	({						\
-		int ret;				\
+		bool ret;				\
 		spin_lock(lock);			\
 		ret = __test_and_set_bit_le(nr, addr);	\
 		spin_unlock(lock);			\
@@ -16,7 +16,7 @@
 
 #define ext2_clear_bit_atomic(lock, nr, addr)		\
 	({						\
-		int ret;				\
+		bool ret;				\
 		spin_lock(lock);			\
 		ret = __test_and_clear_bit_le(nr, addr);	\
 		spin_unlock(lock);			\
diff --git a/include/asm-generic/bitops/le.h b/include/asm-generic/bitops/le.h
index 61731543c00e..c610b9943a08 100644
--- a/include/asm-generic/bitops/le.h
+++ b/include/asm-generic/bitops/le.h
@@ -49,7 +49,7 @@ extern unsigned long find_next_bit_le(const void *addr,
 #error "Please fix <asm/byteorder.h>"
 #endif
 
-static inline int test_bit_le(int nr, const void *addr)
+static inline bool test_bit_le(int nr, const void *addr)
 {
 	return test_bit(nr ^ BITOP_LE_SWIZZLE, addr);
 }
@@ -74,22 +74,22 @@ static inline void __clear_bit_le(int nr, void *addr)
 	__clear_bit(nr ^ BITOP_LE_SWIZZLE, addr);
 }
 
-static inline int test_and_set_bit_le(int nr, void *addr)
+static inline bool test_and_set_bit_le(int nr, void *addr)
 {
 	return test_and_set_bit(nr ^ BITOP_LE_SWIZZLE, addr);
 }
 
-static inline int test_and_clear_bit_le(int nr, void *addr)
+static inline bool test_and_clear_bit_le(int nr, void *addr)
 {
 	return test_and_clear_bit(nr ^ BITOP_LE_SWIZZLE, addr);
 }
 
-static inline int __test_and_set_bit_le(int nr, void *addr)
+static inline bool __test_and_set_bit_le(int nr, void *addr)
 {
 	return __test_and_set_bit(nr ^ BITOP_LE_SWIZZLE, addr);
 }
 
-static inline int __test_and_clear_bit_le(int nr, void *addr)
+static inline bool __test_and_clear_bit_le(int nr, void *addr)
 {
 	return __test_and_clear_bit(nr ^ BITOP_LE_SWIZZLE, addr);
 }

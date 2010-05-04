From: Takuya Yoshikawa <takuya.yoshikawa@gmail.com>
Subject: [RFC][PATCH resend 8/12] asm-generic: bitops: introduce le bit
 offset macro
Date: Tue, 4 May 2010 22:05:00 +0900
Message-ID: <20100504220500.7695cd66.takuya.yoshikawa@gmail.com>
References: <20100504215645.6448af8f.takuya.yoshikawa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100504215645.6448af8f.takuya.yoshikawa@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Takuya Yoshikawa <takuya.yoshikawa@gmail.com>
Cc: avi@redhat.com, mtosatti@redhat.com, agraf@suse.de, yoshikawa.takuya@oss.ntt.co.jp, fernando@oss.ntt.co.jp, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, kvm-ia64@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@ozlabs.org, arnd@arndb.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Although we can use *_le_bit() helpers to treat bitmaps le arranged,
having le bit offset calculation as a seperate macro gives us more freedom.

For example, KVM has le arranged dirty bitmaps for VGA, live-migration
and they are used in user space too. To avoid bitmap copies between kernel
and user space, we want to update the bitmaps in user space directly.
To achive this, le bit offset with *_user() functions help us a lot.

So let us use the le bit offset calculation part by defining it as a new
macro: generic_le_bit_offset() .

Signed-off-by: Takuya Yoshikawa <yoshikawa.takuya@oss.ntt.co.jp>
CC: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/bitops/le.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/asm-generic/bitops/le.h b/include/asm-generic/bitops/le.h
index 80e3bf1..ee445fb 100644
--- a/include/asm-generic/bitops/le.h
+++ b/include/asm-generic/bitops/le.h
@@ -9,6 +9,8 @@
 
 #if defined(__LITTLE_ENDIAN)
 
+#define generic_le_bit_offset(nr)	(nr)
+
 #define generic_test_le_bit(nr, addr) test_bit(nr, addr)
 #define generic___set_le_bit(nr, addr) __set_bit(nr, addr)
 #define generic___clear_le_bit(nr, addr) __clear_bit(nr, addr)
@@ -25,6 +27,8 @@
 
 #elif defined(__BIG_ENDIAN)
 
+#define generic_le_bit_offset(nr)	((nr) ^ BITOP_LE_SWIZZLE)
+
 #define generic_test_le_bit(nr, addr) \
 	test_bit((nr) ^ BITOP_LE_SWIZZLE, (addr))
 #define generic___set_le_bit(nr, addr) \
-- 
1.7.0.4

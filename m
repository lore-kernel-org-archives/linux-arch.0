From: Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] generic arch_futex_atomic_op_inuser() cleanup
Date: Mon, 15 Jul 2019 13:27:06 +0300
Message-ID: <7b963f9a-21b1-4c6d-3ece-556d018508b4@virtuozzo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

Access to 'op' variable does not require pagefault_disable(),
'ret' variable should be initialized before using,
'oldval' variable can be replaced by constant.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 include/asm-generic/futex.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/futex.h b/include/asm-generic/futex.h
index 8666fe7f35d7..e9a9655d786d 100644
--- a/include/asm-generic/futex.h
+++ b/include/asm-generic/futex.h
@@ -118,9 +118,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 static inline int
 arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
 {
-	int oldval = 0, ret;
-
-	pagefault_disable();
+	int ret = 0;
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -132,10 +130,8 @@ arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
-		*oval = oldval;
+		*oval = 0;
 
 	return ret;
 }
-- 
2.17.1

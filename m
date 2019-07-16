Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relay.sw.ru ([185.231.240.75]:38014 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729533AbfGPGWR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Jul 2019 02:22:17 -0400
From: Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2] futex: generic arch_futex_atomic_op_inuser() cleanup
References: <alpine.DEB.2.21.1907151513450.1722@nanos.tec.linutronix.de>
Message-ID: <12bdaca8-99eb-e576-f842-5970ab1d6a92@virtuozzo.com>
Date: Tue, 16 Jul 2019 09:22:03 +0300
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1907151513450.1722@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Message-ID: <20190716062203.zHnq-TqyOMeft7fcFlI6lv-524CbeZ81eCK_aKWXL_k@z>

generic smp version of arch_futex_atomic_op_inuser() always returns -ENOSYS

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 include/asm-generic/futex.h | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/include/asm-generic/futex.h b/include/asm-generic/futex.h
index 8666fe7f35d7..02970b11f71f 100644
--- a/include/asm-generic/futex.h
+++ b/include/asm-generic/futex.h
@@ -118,26 +118,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 static inline int
 arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
 {
-	int oldval = 0, ret;
-
-	pagefault_disable();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	pagefault_enable();
-
-	if (!ret)
-		*oval = oldval;
-
-	return ret;
+	return -ENOSYS;
 }
 
 static inline int
-- 
2.17.1

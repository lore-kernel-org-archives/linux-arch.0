From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/6] arm: don't call addr_limit_user_check for nommu
Date: Mon, 20 Jul 2020 17:54:41 +0200
Message-ID: <20200720155441.GA13067@lst.de>
References: <20200714105505.935079-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200714105505.935079-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On arm nommu kernel use the same constant for USER_DS and KERNEL_DS,
and seqment_eq always returns false.  With the current check in
addr_limit_user_check that works by accident, but when replacing
seqment_eq with uaccess_kerne it will fail.  Just remove the not
needed check entirely.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Guenter Roeck <linux@roeck-us.net>
---

Andrew: this should preferably go before the other patches in this
series.

 arch/arm/kernel/signal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index ab2568996ddb0c..c9dc912b83f012 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -713,7 +713,9 @@ struct page *get_signal_page(void)
 /* Defer to generic check */
 asmlinkage void addr_limit_check_failed(void)
 {
+#ifdef CONFIG_MMU
 	addr_limit_user_check();
+#endif
 }
 
 #ifdef CONFIG_DEBUG_RSEQ
-- 
2.27.0

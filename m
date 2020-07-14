From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/6] syscalls: use uaccess_kernel in addr_limit_user_check
Date: Tue, 14 Jul 2020 12:55:00 +0200
Message-ID: <20200714105505.935079-2-hch@lst.de>
References: <20200714105505.935079-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgGNK7c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jul 2020 06:59:32 -0400
In-Reply-To: <20200714105505.935079-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Use the uaccess_kernel helper instead of duplicating it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/syscalls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index b951a87da9877c..e933a43d4a69ac 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -263,7 +263,7 @@ static inline void addr_limit_user_check(void)
 		return;
 #endif
 
-	if (CHECK_DATA_CORRUPTION(!segment_eq(get_fs(), USER_DS),
+	if (CHECK_DATA_CORRUPTION(uaccess_kernel(),
 				  "Invalid address limit on user-mode return"))
 		force_sig(SIGKILL);
 
-- 
2.26.2

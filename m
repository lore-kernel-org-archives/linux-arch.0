Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99719C433F5
	for <linux-arch@archiver.kernel.org>; Thu,  5 May 2022 08:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347188AbiEEIaD (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 5 May 2022 04:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348045AbiEEI34 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 May 2022 04:29:56 -0400
X-Greylist: delayed 473 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 May 2022 01:26:16 PDT
Received: from sym2.noone.org (sym.noone.org [IPv6:2a01:4f8:120:4161::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D322F2D1F5
        for <linux-arch@vger.kernel.org>; Thu,  5 May 2022 01:26:16 -0700 (PDT)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4Kv65g2Lwvzvjfm; Thu,  5 May 2022 10:18:15 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Mike Rapoport <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Subject: [PATCH] riscv: Wire up memfd_secret in UAPI header
Date:   Thu,  5 May 2022 10:18:15 +0200
Message-Id: <20220505081815.22808-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Move the __ARCH_WANT_MEMFD_SECRET define added in commit 7bb7f2ac24a0
("arch, mm: wire up memfd_secret system call where relevant") to
<uapi/asm/unistd.h> so __NR_memfd_secret is defined when including
<unistd.h> in userspace.

This allows the memds_secret selftest to pass on riscv.

Cc: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 arch/riscv/include/asm/unistd.h      | 1 -
 arch/riscv/include/uapi/asm/unistd.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/unistd.h b/arch/riscv/include/asm/unistd.h
index 6c316093a1e5..977ee6181dab 100644
--- a/arch/riscv/include/asm/unistd.h
+++ b/arch/riscv/include/asm/unistd.h
@@ -9,7 +9,6 @@
  */
 
 #define __ARCH_WANT_SYS_CLONE
-#define __ARCH_WANT_MEMFD_SECRET
 
 #include <uapi/asm/unistd.h>
 
diff --git a/arch/riscv/include/uapi/asm/unistd.h b/arch/riscv/include/uapi/asm/unistd.h
index 8062996c2dfd..d95fbf5846b0 100644
--- a/arch/riscv/include/uapi/asm/unistd.h
+++ b/arch/riscv/include/uapi/asm/unistd.h
@@ -21,6 +21,7 @@
 #endif /* __LP64__ */
 
 #define __ARCH_WANT_SYS_CLONE3
+#define __ARCH_WANT_MEMFD_SECRET
 
 #include <asm-generic/unistd.h>
 
-- 
2.36.0


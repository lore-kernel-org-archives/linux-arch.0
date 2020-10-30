Return-Path: <SRS0=x4yw=EF=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD50C4741F
	for <linux-arch@archiver.kernel.org>; Fri, 30 Oct 2020 15:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B17F2223F
	for <linux-arch@archiver.kernel.org>; Fri, 30 Oct 2020 15:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604072971;
	bh=xH/xlh89YROcQ6IGanzE2IUwe7x9ABvjpXSH43dVrJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wLtOYHf+xKaTaT1fqr91M6s738wX0iqZA/lbWtKRmq8W+rEbEhYs4l+QUuZG4VbCJ
	 uEwZabwTb+sy4QtdfN1lDuoe/QuHv0PkIU5yPoSJw2rfv3ZalqaNPx82j+m/BhoaSB
	 6lvUz5t2dBjRKBH1t3N7vOdL3MaM9RSrutvmhFbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgJ3Pta (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 30 Oct 2020 11:49:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgJ3Pta (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Oct 2020 11:49:30 -0400
Received: from localhost.localdomain (HSI-KBW-46-223-126-90.hsi.kabel-badenwuerttemberg.de [46.223.126.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED397206E9;
        Fri, 30 Oct 2020 15:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604072969;
        bh=xH/xlh89YROcQ6IGanzE2IUwe7x9ABvjpXSH43dVrJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WVmWqQwGHaS4dTDzDIyxXEX9rwVMnmELKiEcch4wuAWUu8jAMUxoLWiZkQfs4syTF
         F84Lc34G02PqLbS7gUO690oFismOg2pygTQWoC8GmN6c7zobjVWdHA3RXEXTJh299w
         R7/iMgOB2iHrCSL1nCvDdOuXub2rAYRb+K9ubr3M=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        viro@zeniv.linux.org.uk, linus.walleij@linaro.org, arnd@arndb.de
Subject: [PATCH 1/9] mm/maccess: fix unaligned copy_{from,to}_kernel_nofault
Date:   Fri, 30 Oct 2020 16:49:11 +0100
Message-Id: <20201030154919.1246645-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201030154519.1245983-1-arnd@kernel.org>
References: <20201030154519.1245983-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

On machines such as ARMv5 that trap unaligned accesses, these
two functions can be slow when each access needs to be emulated,
or they might not work at all.

Change them so that each loop is only used when both the src
and dst pointers are naturally aligned.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/maccess.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/mm/maccess.c b/mm/maccess.c
index 3bd70405f2d8..d3f1a1f0b1c1 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -24,13 +24,21 @@ bool __weak copy_from_kernel_nofault_allowed(const void *unsafe_src,
 
 long copy_from_kernel_nofault(void *dst, const void *src, size_t size)
 {
+	unsigned long align = 0;
+
+	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
+		align = (unsigned long)dst | (unsigned long)src;
+
 	if (!copy_from_kernel_nofault_allowed(src, size))
 		return -ERANGE;
 
 	pagefault_disable();
-	copy_from_kernel_nofault_loop(dst, src, size, u64, Efault);
-	copy_from_kernel_nofault_loop(dst, src, size, u32, Efault);
-	copy_from_kernel_nofault_loop(dst, src, size, u16, Efault);
+	if (!(align & 7))
+		copy_from_kernel_nofault_loop(dst, src, size, u64, Efault);
+	if (!(align & 3))
+		copy_from_kernel_nofault_loop(dst, src, size, u32, Efault);
+	if (!(align & 1))
+		copy_from_kernel_nofault_loop(dst, src, size, u16, Efault);
 	copy_from_kernel_nofault_loop(dst, src, size, u8, Efault);
 	pagefault_enable();
 	return 0;
@@ -50,10 +58,18 @@ EXPORT_SYMBOL_GPL(copy_from_kernel_nofault);
 
 long copy_to_kernel_nofault(void *dst, const void *src, size_t size)
 {
+	unsigned long align = 0;
+
+	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
+		align = (unsigned long)dst | (unsigned long)src;
+
 	pagefault_disable();
-	copy_to_kernel_nofault_loop(dst, src, size, u64, Efault);
-	copy_to_kernel_nofault_loop(dst, src, size, u32, Efault);
-	copy_to_kernel_nofault_loop(dst, src, size, u16, Efault);
+	if (!(align & 7))
+		copy_to_kernel_nofault_loop(dst, src, size, u64, Efault);
+	if (!(align & 3))
+		copy_to_kernel_nofault_loop(dst, src, size, u32, Efault);
+	if (!(align & 1))
+		copy_to_kernel_nofault_loop(dst, src, size, u16, Efault);
 	copy_to_kernel_nofault_loop(dst, src, size, u8, Efault);
 	pagefault_enable();
 	return 0;
-- 
2.27.0


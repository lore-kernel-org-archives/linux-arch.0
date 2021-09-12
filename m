Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21CFC433FE
	for <linux-arch@archiver.kernel.org>; Sun, 12 Sep 2021 21:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2BD660F51
	for <linux-arch@archiver.kernel.org>; Sun, 12 Sep 2021 21:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbhILV7L (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sun, 12 Sep 2021 17:59:11 -0400
Received: from tartarus.angband.pl ([51.83.246.204]:39892 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236550AbhILV7J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Sep 2021 17:59:09 -0400
X-Greylist: delayed 1900 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Sep 2021 17:59:08 EDT
Received: from 89-73-149-240.dynamic.chello.pl ([89.73.149.240] helo=barad-dur.angband.pl)
        by tartarus.angband.pl with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kilobyte@angband.pl>)
        id 1mPWzK-00C2bN-16; Sun, 12 Sep 2021 23:26:11 +0200
Received: from [2a02:a31c:8245:f980::4] (helo=valinor.angband.pl)
        by barad-dur.angband.pl with esmtp (Exim 4.94.2)
        (envelope-from <kilobyte@angband.pl>)
        id 1mPWzJ-0003D5-AU; Sun, 12 Sep 2021 23:26:09 +0200
Received: from kilobyte by valinor.angband.pl with local (Exim 4.95-RC2)
        (envelope-from <kilobyte@valinor.angband.pl>)
        id 1mPWzI-00035X-3D;
        Sun, 12 Sep 2021 23:26:08 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Cc:     Adam Borowski <kilobyte@angband.pl>
Date:   Sun, 12 Sep 2021 23:26:06 +0200
Message-Id: <20210912212606.11854-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 89.73.149.240
X-SA-Exim-Mail-From: kilobyte@angband.pl
Subject: [PATCH] asm-generic/io.h: give stub iounmap() on !MMU same prototype as elsewhere
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

It made -Werror sad.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 include/asm-generic/io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index e93375c710b9..dea1d36a6402 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -957,7 +957,7 @@ static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
 
 #ifndef iounmap
 #define iounmap iounmap
-static inline void iounmap(void __iomem *addr)
+static inline void iounmap(volatile void __iomem *addr)
 {
 }
 #endif
-- 
2.33.0


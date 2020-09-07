Return-Path: <SRS0=71DO=CQ=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A7BC43461
	for <linux-arch@archiver.kernel.org>; Mon,  7 Sep 2020 05:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBD8F21741
	for <linux-arch@archiver.kernel.org>; Mon,  7 Sep 2020 05:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hEYF4PSl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgIGF7a (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 7 Sep 2020 01:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgIGF6i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Sep 2020 01:58:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF0CC061756;
        Sun,  6 Sep 2020 22:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=LZG506isFI0SSgZ6Zw+vMgWmYh0hewhmkGW4YKK3Ono=; b=hEYF4PSl9zeran7ag2rqjrqpS+
        F5YHwGNHRtUS/Z2Jy9aT/DAniqZ1qGd8gaILOKip2LnfpJ6kCpY+MIDo0A15yM5WxzPKOVdDJL34G
        oE8EBQwCz4G+IKkBMhP4/mRP4MXhf2D2smtrEYKj08iYpqhmQlRGMZV9pXsr1Yl+Ng649ggawxTBp
        +HA2Nd09IHgmGMDBpn5zLsUDLH6GTwUQ9wB2LKQUI7TK7bYmgAADrm7kitmH7hb53jBlhFYnQGya7
        dsKZQzhaFoxG6l9zVTDaNFfsu68KbENJX/9W82Z5FihOVKoQ83g0PrrgdmHTgoaktJZ8LAjuUv4e6
        ffZQ6t1A==;
Received: from [2001:4bb8:184:af1:e178:97b2:ac6b:4e16] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFAAg-00035H-HT; Mon, 07 Sep 2020 05:58:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 3/8] asm-generic: add nommu implementations of __{get,put}_kernel_nofault
Date:   Mon,  7 Sep 2020 07:58:20 +0200
Message-Id: <20200907055825.1917151-4-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200907055825.1917151-1-hch@lst.de>
References: <20200907055825.1917151-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add native implementations of __{get,put}_kernel_nofault using
{get,put}_unaligned, just like the {get,put}_user implementations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/asm-generic/uaccess.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
index 6de5f524e9e631..b367f339be1a90 100644
--- a/include/asm-generic/uaccess.h
+++ b/include/asm-generic/uaccess.h
@@ -61,6 +61,22 @@ static inline int __put_user_fn(size_t size, void __user *to, void *from)
 }
 #define __put_user_fn(sz, u, k)	__put_user_fn(sz, u, k)
 
+#define __get_kernel_nofault(dst, src, type, err_label)			\
+do {									\
+	*((type *)dst) = get_unaligned((type *)(src));			\
+	if (0) /* make sure the label looks used to the compiler */	\
+		goto err_label;						\
+} while (0)
+
+#define __put_kernel_nofault(dst, src, type, err_label)			\
+do {									\
+	put_unaligned(*((type *)src), (type *)(dst));			\
+	if (0) /* make sure the label looks used to the compiler */	\
+		goto err_label;						\
+} while (0)
+
+#define HAVE_GET_KERNEL_NOFAULT 1
+
 static inline __must_check unsigned long
 raw_copy_from_user(void *to, const void __user * from, unsigned long n)
 {
-- 
2.28.0


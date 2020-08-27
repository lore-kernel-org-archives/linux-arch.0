Return-Path: <SRS0=b863=CF=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64446C433E1
	for <linux-arch@archiver.kernel.org>; Thu, 27 Aug 2020 10:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 387EC2075B
	for <linux-arch@archiver.kernel.org>; Thu, 27 Aug 2020 10:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0lx+daS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgH0KP7 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 27 Aug 2020 06:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbgH0KOy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 06:14:54 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A672C061264;
        Thu, 27 Aug 2020 03:14:54 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id i13so2378604pjv.0;
        Thu, 27 Aug 2020 03:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=MM8ByLpSzA5yU4gymQhZmL1JfibHhtBl5mNFRiHI+fw=;
        b=R0lx+daSLUHkhX+nMEeLycxQeuAq1h27Ol1K4gOKJIY0KqDCSpZnJ21OyBcpGXZ/7u
         wRJiiskFKcNW3hve+ObGPxcvkHYUbfzMw7uK1u/93nqxi6mCNSL6O0GMqDKZcRpUFe4C
         NtQBgBCuVejieuiWpWLWo6J4P3PJFGHkn7GiRYcAYV/YQjHOBDVANJxbJQrWtncyRUee
         V1aMQKc5U9X0MmCnrpdMUndDBW96JrOlW0/lbTHzpDyutRgqhMKVmfD3zZvAJywt7knF
         0fSRdSD3gozwxfHG1p8eK19mMt7Tirvrf5sNdRV5b1qIZwxseX77UVbNEqJwufNkYY8A
         XEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=MM8ByLpSzA5yU4gymQhZmL1JfibHhtBl5mNFRiHI+fw=;
        b=mHDCCgDT2D2guZVO5L9KV+C9+zMwEYlTOm8d+RICSK+nsfKd2/fItJzjJN4QFTnSUc
         5K2W4pk+gjsmfsSTSBbKRTNVtDmYvUR3EtxygeZYgJT9uTn1wbXtixQiK1BtQfsQzqgH
         LUvItr/XK+pxlfXCC4qp+Mrz6eDHA1V451oRbbnPje+0mJnT9RX4oKBkFTSUsv2YmCxz
         21yRIkfNnjsoT9yZaApF6Vpd5Ipjb7fWNwHCyiI8D8GgDuSFfWRQQMZIdxqwOPvgQUdB
         EizeuJXnjlF1nj5ZmatKg8pnRQa68Fsig/qRPYTGV93vpV5cLHTz7UJTPu0A3HTR66ET
         VBtw==
X-Gm-Message-State: AOAM530BQaOaTbIMUdvqNINdHIJ28VjBTx4NBfd7F/o0ZRgdxAEKEif0
        Zb7LZ9eIpvys+C70orSf03/1VeWZwNHNug==
X-Google-Smtp-Source: ABdhPJySTxbhAISxFhl3CrPfgjbdCW33JdORLifcr40wS71jXayBPzn+t1oRT8YjrraMnBRvRuLQ6w==
X-Received: by 2002:a17:90b:110:: with SMTP id p16mr1549885pjz.150.1598523293716;
        Thu, 27 Aug 2020 03:14:53 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id t10sm2333434pfq.52.2020.08.27.03.14.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 03:14:53 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     arnd@arndb.de
Cc:     rppt@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/23] sym53c8xx: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
Date:   Thu, 27 Aug 2020 18:14:21 +0800
Message-Id: <c5d891436d993d2becd40eff4db1a40d4a9bc4ac.1598518912.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1598518912.git.brookxu@tencent.com>
References: <cover.1598518912.git.brookxu@tencent.com>
In-Reply-To: <cover.1598518912.git.brookxu@tencent.com>
References: <cover.1598518912.git.brookxu@tencent.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since ASSERT_FAIL() and ASSERT_WARN() have been provided, ASSERT()
may be realized through them, thus reducing code redundancy and
facilitating problem analysis.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 drivers/scsi/sym53c8xx_2/sym_hipd.h | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/scsi/sym53c8xx_2/sym_hipd.h b/drivers/scsi/sym53c8xx_2/sym_hipd.h
index 9231a28..0676c94 100644
--- a/drivers/scsi/sym53c8xx_2/sym_hipd.h
+++ b/drivers/scsi/sym53c8xx_2/sym_hipd.h
@@ -79,14 +79,7 @@
  *  These ones should have been already defined.
  */
 #ifndef assert
-#define	assert(expression) { \
-	if (!(expression)) { \
-		(void)panic( \
-			"assertion \"%s\" failed: file \"%s\", line %d\n", \
-			#expression, \
-			__FILE__, __LINE__); \
-	} \
-}
+#define	assert(expression) ASSERT_FAIL(expression)
 #endif
 
 /*
-- 
1.8.3.1


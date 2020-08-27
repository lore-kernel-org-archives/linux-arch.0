Return-Path: <SRS0=b863=CF=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECE5C433E1
	for <linux-arch@archiver.kernel.org>; Thu, 27 Aug 2020 10:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28CCA207F7
	for <linux-arch@archiver.kernel.org>; Thu, 27 Aug 2020 10:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bX7rFanN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgH0KO4 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 27 Aug 2020 06:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbgH0KOv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 06:14:51 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BFBC061264;
        Thu, 27 Aug 2020 03:14:50 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x143so3132932pfc.4;
        Thu, 27 Aug 2020 03:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=EbDoc21TnVO1rS/pOV9rJr+/c7DLZndo5m2NKLEUdME=;
        b=bX7rFanNJT8Dz6DbYDza0NTckyLhC9BO6swQpguSETqQjjSbwbid2b0YEczeBcgrba
         YYdO8CBXNyBqcfvNzUu/H5H9GBbR1IJaHKdEPY3CmQWan1zpmp/F9imPMaeC0R04ylfM
         4+XJgDroIhpssZZ8EIPZkbOZd0fj2UGOxFgHbGt0fQISZ4DXiLlLRJLYD34GR5jICbbg
         7hJc6Fx3KCtWcqlqm4hW3s/RcD3hcBr8IPHU5VCrdFwO+rqa9UeW8TD125Dvo8a9q9LD
         dZtIL0l3zcC76W5Sj6P8/ZzaYnjWJdYekhT0+DjL5WxmkEu2BNYYM8fIG4qr+6SrStDd
         yzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=EbDoc21TnVO1rS/pOV9rJr+/c7DLZndo5m2NKLEUdME=;
        b=Qb0iYLktV3lHuKf1BQUNH1b8nte7E0WN18rQlt51WE4sTtoxdwiAP1TocW7gmwADWB
         vTBDVgSTaTChRahKMB+BA9k8RPiVcBNYGdfaBOUpwAkoOUvUHnL7AfzrUwtJUdQdeZla
         OxV4TmN62rMPizj0+hBW53R3yYWBsITUkkyvj07vhoya3O7z/MBUaPxpQQgDVFCqax3H
         Cvm0t61GXl6Q0TjeoeE1kASlyOXHAT3Mfk/9Cr1ZWdOToBkCNPq5n6EifCCbIG2rvc89
         4RjwBEVvle8WY8iSEPX27hfdwPTEf1uSf+xKQAuZO2ispzeWAe7P8mB6EY1WqqEKA6E3
         JRqg==
X-Gm-Message-State: AOAM533+sZsgnv833FiK1806ZJzmySl2cjjak8EsBl4rUTJChY9is0wP
        C345yy1pUoUywNn7wYpu/+0=
X-Google-Smtp-Source: ABdhPJwSxqaT5eUJLycmEQSSll/I1dLEdqrPnTiwd5BwkS1nLKYhNLGCeXDCRKGL7SRYUtl//zIIjg==
X-Received: by 2002:a62:e70d:: with SMTP id s13mr15213983pfh.143.1598523289409;
        Thu, 27 Aug 2020 03:14:49 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id t10sm2333434pfq.52.2020.08.27.03.14.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 03:14:49 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     arnd@arndb.de
Cc:     rppt@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/23] nvidia: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
Date:   Thu, 27 Aug 2020 18:14:18 +0800
Message-Id: <d52d2f09c0ac01dcef3cb27d2d09a838edf68b7b.1598518912.git.brookxu@tencent.com>
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
 drivers/video/fbdev/nvidia/nvidia.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
index c6820e2..f5b3a9a 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -40,12 +40,7 @@
 #define NVTRACE_LEAVE(...)  NVTRACE("%s END\n", __func__)
 
 #ifdef CONFIG_FB_NVIDIA_DEBUG
-#define assert(expr) \
-	if (!(expr)) { \
-	printk( "Assertion failed! %s,%s,%s,line=%d\n",\
-	#expr,__FILE__,__func__,__LINE__); \
-	BUG(); \
-	}
+#define assert(expr) ASSERT_FAIL(expr)
 #else
 #define assert(expr)
 #endif
-- 
1.8.3.1


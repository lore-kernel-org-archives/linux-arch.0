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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A722C433E1
	for <linux-arch@archiver.kernel.org>; Thu, 27 Aug 2020 10:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 456D120738
	for <linux-arch@archiver.kernel.org>; Thu, 27 Aug 2020 10:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkXBpWp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgH0KP7 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 27 Aug 2020 06:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbgH0KOv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 06:14:51 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4366EC061232;
        Thu, 27 Aug 2020 03:14:51 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q93so2423273pjq.0;
        Thu, 27 Aug 2020 03:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=YEwhGlOiAn2QBZ/J91Vcx56sl7B71UFREHc/KBToN3g=;
        b=WkXBpWp7j5GxJXTfymH26tFnRLaHsn9jzVUToPdLVRPXUt4L3JYq4bLbmTH8ChyhTs
         /H+mXg5XKLwgmYFMz7JJrHAgQKawIxxrcC6gbtzu8+5FkBHTbsP09CkkV+py4bJV+/S6
         lFa0/Ka7rMByyOU2a+jSMs2RvQRru6IEjFaFAxogdpuvB94j6QGHNH290Pz22d6QeMDF
         WFHVaLNrOIfL4xptSLhqbkxpJZzgoXobqyE06x9gxKkbfwqYOySUY8R97ZSYmOn0G96O
         NwI21pojUs/hCpuwgk2KKf5gzzcmwacO0hYw2Z/Y45Fdjq8PAToI0nnf8IoGRhGhOg1h
         3aXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=YEwhGlOiAn2QBZ/J91Vcx56sl7B71UFREHc/KBToN3g=;
        b=IJ0IDol8UE2Vo9BXXkVhiCEeGn+CmS7UZz7kPquUJfydOFjmISjcqZqGRQtDbAQf5x
         t7YT+24ZRFE0MTL7KAS5C8avvDeA2PnV+1VO8K3DLGiQ6qFd7nWZBYEW783XoK4f6a7b
         Oh/qDgNi5F2JszUw2+GzD6bITxWvN2vpTFHGG9l1x9+6zNdSt5e9QMtYvPceSsp8Gdq9
         EEZ9kZQtmHT8dJT+ztCnHmhHrzaKB/v3y8VVfADgSdFQdqFlDCNqTADDoM8fCp98uY1T
         9CgauGpULKxAP1pFkFThAf3GwkEX/PjZwt3TJCJkGXb7/3vaJTg+XD3o+cnhqmO7725k
         0KVw==
X-Gm-Message-State: AOAM530hADmsTU18ZhmXQqQNoBvc//l6YXMHjDZ+COVZ1HnioG4H5h7e
        aMAS36dr/fE5wtS7qTmPelg=
X-Google-Smtp-Source: ABdhPJzuYx6FZ/d8jAIKixAJodimMSFEeM0cgIw7dnzyvIFdj/pAatlRZfA/qkTpV+NKgCpmcU4XRw==
X-Received: by 2002:a17:90a:c917:: with SMTP id v23mr9893892pjt.97.1598523290873;
        Thu, 27 Aug 2020 03:14:50 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id t10sm2333434pfq.52.2020.08.27.03.14.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 03:14:50 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     arnd@arndb.de
Cc:     rppt@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/23] fbdev/cirrusfb:: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
Date:   Thu, 27 Aug 2020 18:14:19 +0800
Message-Id: <66be38f348ed3725d626fddef76ff55db7aa5999.1598518912.git.brookxu@tencent.com>
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
 drivers/video/fbdev/cirrusfb.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/cirrusfb.c b/drivers/video/fbdev/cirrusfb.c
index 3df64a9..3dcafdd 100644
--- a/drivers/video/fbdev/cirrusfb.c
+++ b/drivers/video/fbdev/cirrusfb.c
@@ -67,11 +67,7 @@
 
 /* debugging assertions */
 #ifndef CIRRUSFB_NDEBUG
-#define assert(expr) \
-	if (!(expr)) { \
-		printk("Assertion failed! %s,%s,%s,line=%d\n", \
-		#expr, __FILE__, __func__, __LINE__); \
-	}
+#define assert(expr) ASSERT_WARN(expr)
 #else
 #define assert(expr)
 #endif
-- 
1.8.3.1


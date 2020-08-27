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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E71C433E3
	for <linux-arch@archiver.kernel.org>; Thu, 27 Aug 2020 10:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27843207F7
	for <linux-arch@archiver.kernel.org>; Thu, 27 Aug 2020 10:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBuwfj0+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgH0KOu (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 27 Aug 2020 06:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbgH0KOo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 06:14:44 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECB5C061264;
        Thu, 27 Aug 2020 03:14:43 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h12so3017717pgm.7;
        Thu, 27 Aug 2020 03:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=lcebHZjuLTjuHLla0RNUmQpB3T0HWgXfvZ5bMk1Kq6c=;
        b=HBuwfj0+JYgxMosisP9hXz8knUgl9IqQXFpxOcQ4GJQSalzzPkCAASU96RPbcKyO2k
         yzqTlYv2HNwg6FS0izuDuDpDKU0hLRuccxTxYKAGgk98lClB2swIkZDpPt2D7PPH0rTR
         Cw1Yu9w18W30J2afyASib2mXpQy+ucC9+upcI8VKVRAWVRUhnPlInc2vEZ8Do5ntOCRF
         8q1HTfiLny5tMI0t/jxpTOSfQ5oyFZLAdu+uh+iieJnYgSBulXgwr4PYRsV8XEq8tebY
         pRfox/6qCS092y1gZydVZDpBbQA/nNZIWhHJRuwhAujhFH4R1Vqo9OUPbWDXqj1p4rLa
         bgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=lcebHZjuLTjuHLla0RNUmQpB3T0HWgXfvZ5bMk1Kq6c=;
        b=JXTRxVGhbRFrejJOKrpo00cEFnVHthI2ZGd+pfWzNV85tgH0HTFCemEM35A8/Bidhy
         l0EDFy+EGlb4tO3REs1ejNcXfdZFjPfMh5KU2vLy25wTRZl4sBIh148c6bWci8XFloVM
         LV8pFkmIcVaqvfqpVQzpXw8THBDWaj79kqAIrHRavJT2ZIH6X+C52j9i9ExNbKhAKkSk
         WV0JDsJERUs6/u8s02S1tISqczo+ukUoDnE+pw3cGhYKkPAkw4wV260A+ifs3VrpIYlc
         a+bl3drY1ZltXRUn+OSN8n/qjGowGhF5s5hqfJvztUidPjsS46FFx0+dI/Xk7Absqjg6
         wMSA==
X-Gm-Message-State: AOAM533uh7+II8XuYEY+boclRuz+kPFkiBx+8BswHlrZ5BVZpAiW1QnU
        2TKMZTWketNmqJ8V7F60Wo8=
X-Google-Smtp-Source: ABdhPJznoc7gG8tJcYmhxemvd2d/TZDNqGHFXo3qbyUacya34toebe/trKa38S0cpnFsdxQ6AiJQvg==
X-Received: by 2002:a17:902:be10:: with SMTP id r16mr15812173pls.295.1598523282346;
        Thu, 27 Aug 2020 03:14:42 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id t10sm2333434pfq.52.2020.08.27.03.14.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 03:14:42 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     arnd@arndb.de
Cc:     rppt@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/23] jfs: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
Date:   Thu, 27 Aug 2020 18:14:13 +0800
Message-Id: <9797d150e126542889c4a8c0601f997a8199e900.1598518912.git.brookxu@tencent.com>
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
 fs/jfs/jfs_debug.h | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/fs/jfs/jfs_debug.h b/fs/jfs/jfs_debug.h
index 48e2150..0a2f0e5 100644
--- a/fs/jfs/jfs_debug.h
+++ b/fs/jfs/jfs_debug.h
@@ -24,22 +24,11 @@
 #endif
 
 /*
- *	assert with traditional printf/panic
- */
-#define assert(p) do {	\
-	if (!(p)) {	\
-		printk(KERN_CRIT "BUG at %s:%d assert(%s)\n",	\
-		       __FILE__, __LINE__, #p);			\
-		BUG();	\
-	}		\
-} while (0)
-
-/*
  *	debug ON
  *	--------
  */
 #ifdef CONFIG_JFS_DEBUG
-#define ASSERT(p) assert(p)
+#define ASSERT(p) ASSERT_FAIL(p)
 
 /* printk verbosity */
 #define JFS_LOGLEVEL_ERR 1
-- 
1.8.3.1


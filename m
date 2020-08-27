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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31816C433DF
	for <linux-arch@archiver.kernel.org>; Thu, 27 Aug 2020 10:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F9F922B49
	for <linux-arch@archiver.kernel.org>; Thu, 27 Aug 2020 10:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVJeGpi0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgH0KOt (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 27 Aug 2020 06:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbgH0KOo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 06:14:44 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5B0C06121B;
        Thu, 27 Aug 2020 03:14:44 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d22so3127933pfn.5;
        Thu, 27 Aug 2020 03:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=K6iAF1bAIgrDi8rEAEPz6sa2CytTwXocJLkALhrz0vk=;
        b=RVJeGpi0UwHEAl9A2coXSoVlKmrj7yytq0pZskmSSD+JQ3UXq0gXQX9onvp1QCh4eP
         ypXcIZbNwl0yKUFSuITUgFEFvaIylXncTWG4WehuOr7fvXyCvLFUOb6pe5LG2ViNBvi/
         XJmvBqlBMMyQRIyJLASrt2mCjkeRGzh5BlLWuL+OOHbPYDwUeBFnzlp0gJLxWcKA0yU7
         1kv/jKsPtJLjJJEHSvlkCzdS6nk0ZKeRnVg0Xs47//v7QG2tRcAX0rtokolcWQELoD2P
         5G0A8l4VvASFIZb5DxnIuGpQ8yZ+R6YyJ68LKTWgC5QKTWvc4nd6d3fZwFy/0Lg0fgqp
         1HXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=K6iAF1bAIgrDi8rEAEPz6sa2CytTwXocJLkALhrz0vk=;
        b=tH8K1AisPTlNGJAGZJN3CuZPShnjye2UNdo5A3gLLEVkipQCKqjcgUJ3lniVU6Fv1c
         dEIYWtrU+euPUJvPHdfvvaxjOWNiRmffd8fWKA1fVlMX/ae7g/a0Of8IZBiSsv2azpN8
         JyoT+rPZl3aiLtiaN8Tn2frritTrR7JXA+IRXNRO2ZvCrfcBt7FUw3S3CIAaKNDB3fCq
         LnEivO0uRYc0M1LUvBlEpIDCDTrYLcdwdRl6kCfZH1HvsHman59jkUpLljjhdVxjs5D0
         Ey/OlWtKurtdzDBZkSjtb7XoGJRdNpUeTvowKHOf77+C8R3cY7F9MO0GFEKaNZOml3gI
         JVdw==
X-Gm-Message-State: AOAM531R/FqICpiECW2XiGi2EmalVXQlDX0sPZ8gaulDTvrSmvKNk0QX
        1F2het5KyrophT9JD7ice+hashNlryiYSA==
X-Google-Smtp-Source: ABdhPJxzftCMISEkIaodqrxvMsYxKv8AyN4ChJGIdKWqtBmlqFbcyDqpUhXAJ9YTChj2zCB65TX83g==
X-Received: by 2002:a17:902:8a93:: with SMTP id p19mr15949244plo.320.1598523283735;
        Thu, 27 Aug 2020 03:14:43 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id t10sm2333434pfq.52.2020.08.27.03.14.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 03:14:43 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     arnd@arndb.de
Cc:     rppt@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/23] cachefiles: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
Date:   Thu, 27 Aug 2020 18:14:14 +0800
Message-Id: <6ab4f297f0a88e562a141219b9d9797d966d3257.1598518912.git.brookxu@tencent.com>
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
 fs/cachefiles/internal.h | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index cf9bd64..2447437 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -316,14 +316,7 @@ extern int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
 
 #if 1 /* defined(__KDEBUGALL) */
 
-#define ASSERT(X)							\
-do {									\
-	if (unlikely(!(X))) {						\
-		pr_err("\n");						\
-		pr_err("Assertion failed\n");		\
-		BUG();							\
-	}								\
-} while (0)
+#define ASSERT(X) ASSERT_FAIL(x)
 
 #define ASSERTCMP(X, OP, Y)						\
 do {									\
-- 
1.8.3.1


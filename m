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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DEBC433DF
	for <linux-arch@archiver.kernel.org>; Thu, 27 Aug 2020 10:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 228B22075B
	for <linux-arch@archiver.kernel.org>; Thu, 27 Aug 2020 10:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwnVkiqv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgH0KPa (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 27 Aug 2020 06:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbgH0KPD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 06:15:03 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50DDC061234;
        Thu, 27 Aug 2020 03:15:02 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ls14so2348323pjb.3;
        Thu, 27 Aug 2020 03:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Gt2HyJ1wviG71lKYx9TWlV8qFczO3DOOX9qm2sFWYAs=;
        b=HwnVkiqvs8MhylumPgGYeEwUi2EqFsi1M1jQdNHk9Ke9fVWgSR3L8IHkrQ321T0s91
         WaWuqCw43iryWG/EQldyIpxJmfGWLJ6OB2xCSf172V5yx89UsTcXkjFlt5B4QsnWp5df
         OtagkaOBy4RWyKtmMKqjgQ/XOgndvF0ITg+advmYEFeM05fID3Zc345ZJs/hDvBYMw0e
         ft2Qgf+cHsG2k4YH1LAsw/p1ZntavhIn8z4LlpAz1FWARDeJeWOuAgMX3R3iSEEbJI32
         biNHrCWiKix8Fhgl5TrFK3Al0QqNAyaaR1nB5H962mFKa71hh7W5zS8Heb/BShO4dQww
         opbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Gt2HyJ1wviG71lKYx9TWlV8qFczO3DOOX9qm2sFWYAs=;
        b=m6g5fLTPGASxhKrGdh1l87T2b9cVmB0I0xPj4wz4IY132Qv6SU/5vbPirV1Ew58m7f
         K6y+OtQ+iwFo1BAQ0V1QRY7iizsuYoAh/0coHTfxQyufeJyf6wOktpCUcKvDZB0thZ7I
         VPgM1GEAsyTMbY/SYsuBxPZXhYH1eOsllbf+HHqgn8cm8yFN7MbVk7mbsyQpH4D+5/gT
         Vy/Kui7rWPZio0EySQKlbKfhZ8Z0oc0W/5aPlEs+gm8QvQArR6KXGp9mPJSYuoXRPiLP
         wszdUgLzoAqPutnpRKv05RzTgs1hCM4Q8R0886JoUqVYpAMxElQ3YPBd4tZ/G5Fydiur
         IYMQ==
X-Gm-Message-State: AOAM530QVANBRf1tepeuQszDb60n19ON2FAiFuR9a6isBY8wQjXvK32E
        yZ5BjeYKwMWO15JqQaiYscOKWCff74sxGg==
X-Google-Smtp-Source: ABdhPJzAwKy8h4T9aIzkxVY0wnIbxZ2txMW9vSjytRLOlagBuhjQVFHGfCz/yOQokujMx44fr2UdSw==
X-Received: by 2002:a17:90a:cc6:: with SMTP id 6mr10469390pjt.2.1598523302435;
        Thu, 27 Aug 2020 03:15:02 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id t10sm2333434pfq.52.2020.08.27.03.15.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 03:15:01 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     arnd@arndb.de
Cc:     rppt@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 22/23] rbd: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
Date:   Thu, 27 Aug 2020 18:14:27 +0800
Message-Id: <1566d951b3b1ea93cd2cd9e88e29289cbbd40584.1598518912.git.brookxu@tencent.com>
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
 drivers/block/rbd.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index d9c0e7d..798b9ad 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -617,14 +617,7 @@ void rbd_warn(struct rbd_device *rbd_dev, const char *fmt, ...)
 }
 
 #ifdef RBD_DEBUG
-#define rbd_assert(expr)						\
-		if (unlikely(!(expr))) {				\
-			printk(KERN_ERR "\nAssertion failure in %s() "	\
-						"at line %d:\n\n"	\
-					"\trbd_assert(%s);\n\n",	\
-					__func__, __LINE__, #expr);	\
-			BUG();						\
-		}
+#define rbd_assert(expr)	ASSERT_FAIL(expr)
 #else /* !RBD_DEBUG */
 #  define rbd_assert(expr)	((void) 0)
 #endif /* !RBD_DEBUG */
-- 
1.8.3.1


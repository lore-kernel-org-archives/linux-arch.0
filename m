Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9F2C433E0
	for <linux-arch@archiver.kernel.org>; Tue, 16 Mar 2021 01:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B82D64FB2
	for <linux-arch@archiver.kernel.org>; Tue, 16 Mar 2021 01:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbhCPBzF (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 15 Mar 2021 21:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbhCPByc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Mar 2021 21:54:32 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6724C061756;
        Mon, 15 Mar 2021 18:54:30 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id g24so10645936qts.6;
        Mon, 15 Mar 2021 18:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a7JdQMPMgs8V6p2mIbAAMliZc+Q/jwU8V02vmoeVTgc=;
        b=q+2JratXAIojiOnbybFMXtp6qteLs7myYpTjGtZUxGtQbOGGKO0ygwLBMT3MEwvH+d
         ekA/xYjDbAxJtmcA6a4anum1Z0drIuGkeL7kSSk/VwXL/aT7sFiYKSe8ZPrXB2eYzTBZ
         N+gEEcu3U4arDCnAa4mRZfX6dqdgwdWpMSYgdjZL2FE2MXfThRk5Kk3JHcfM5O59yRnL
         hLOJc84dITbVMh17TiHQPu0mgWARfz5vB8MquDpPyZdfpWFHr7ZVxH7wdMOLJNMZXpal
         SDOClxQ97Fq2JVX6z4XxN/grORdOwmotLT53/4oOmkaafttDD4VSepsaWIMZhTG8o21T
         mmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a7JdQMPMgs8V6p2mIbAAMliZc+Q/jwU8V02vmoeVTgc=;
        b=axywmY+fd7eAu2cig4tiJFm4VPx7v/evauzfZ3IFxmUXcFpwIzq9kqppV+RaR18yKu
         khBB+LsMTq5d6erJG7663rmSa3csa+OYEePKlfbzla+eFIg5MYkz5/3Kx0WepKUSsJos
         fJuySld/NHiPxjAKi1tgat96KEqlZf20W6n1j38xPynDuX9lqtIr0hMfwr1Bao6dy7i9
         mF4JslrX6pmXeKV+qntWSVcypcpaN4xzbrNZovIL7FxbDW5tLCacY5p3JczKFZSlprIT
         kfpRtvJrJqq4J51g8kEoO2sK/iHyJZ5d4XopBB1NznrlwlteCiJCOj4s61BwyAMyBKUn
         aY4Q==
X-Gm-Message-State: AOAM532n4ZLnRl6RES8PqjcwpAfmafRtUOCYCFmK80TDvc3rBChWak2L
        jpurYFNgzbwHow7zcABEpoiGZ3yZKic=
X-Google-Smtp-Source: ABdhPJyjbBs7nlG8KEc38wGBab/VGyJ2ZNfYRj+OtifaXJOa0rBZ8Jw6way9C1o+bwbBBpGBDkALDw==
X-Received: by 2002:aed:2063:: with SMTP id 90mr19621568qta.195.1615859669929;
        Mon, 15 Mar 2021 18:54:29 -0700 (PDT)
Received: from localhost ([76.73.146.210])
        by smtp.gmail.com with ESMTPSA id q15sm12422975qti.9.2021.03.15.18.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 18:54:29 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, linux-m68k@lists.linux-m68k.org,
        linux-arch@vger.kernel.org, linux-sh@vger.kernel.org,
        Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rich Felker <dalias@libc.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 01/13] tools: disable -Wno-type-limits
Date:   Mon, 15 Mar 2021 18:54:12 -0700
Message-Id: <20210316015424.1999082-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210316015424.1999082-1-yury.norov@gmail.com>
References: <20210316015424.1999082-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

GENMASK(h, l) may be passed with unsigned types. In such case, type-limits
warning is generated for example in case of GENMASK(h, 0).

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 tools/scripts/Makefile.include | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 84dbf61a7eca..15e99905cb7d 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -38,6 +38,7 @@ EXTRA_WARNINGS += -Wswitch-enum
 EXTRA_WARNINGS += -Wundef
 EXTRA_WARNINGS += -Wwrite-strings
 EXTRA_WARNINGS += -Wformat
+EXTRA_WARNINGS += -Wno-type-limits
 
 CC_NO_CLANG := $(shell $(CC) -dM -E -x c /dev/null | grep -Fq "__clang__"; echo $$?)
 
-- 
2.25.1


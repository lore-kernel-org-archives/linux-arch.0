Return-Path: <SRS0=ECFR=CK=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224D4C433E2
	for <linux-arch@archiver.kernel.org>; Tue,  1 Sep 2020 14:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF85821D6C
	for <linux-arch@archiver.kernel.org>; Tue,  1 Sep 2020 14:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/L+aoGR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgIAOpD (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbgIAOQN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 10:16:13 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8D2C06125E;
        Tue,  1 Sep 2020 07:16:12 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s10so148782plp.1;
        Tue, 01 Sep 2020 07:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+cGML8t0IrnDZlw59Ro+Eu895qkrrnKIgTl4NIzGBZ4=;
        b=q/L+aoGRQrWIn3GYU9nuKy9oC2d5bDbHhhRro1r90MDLWrwe1RmfZXOp6jivtRHnQt
         Pms8OjK6Bmlq936jr8qBCqmyJqZgIXsMxB9QH0VtREPg1O3kn2ActM2ghM7PVDI9Keqh
         2eyD0PfIPWXBmuEZ4YIF0wHZjh0znY4x9t6701ZagEU8SZNQSxKIwHogz2hwbcIS9lMm
         Ifw2lpDuMXSebyFfdrFEpDJ5R854gI85YjQrxyI+gAzVGFlXHYpO3KEEblQUz+KvX/kZ
         k9vEfLpBosQBSMti5oQIbOSsUuLEeeEvjKD08vTZAWCk/yEfqyfoiLt3a26sK2zzlXbd
         iwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+cGML8t0IrnDZlw59Ro+Eu895qkrrnKIgTl4NIzGBZ4=;
        b=YTtQ8ma/vqEW3ICgPTIVWEemmjUQRS2CA0A8icIsvkkeysvHo3dV2vwUcjnZ3XT7Tg
         odppSSOWWWq+Lu1LDFlTW7N+pbw6BvGTRqWmLjgfHQ21eY6E1IecpABdNQR+UhGz+Pj/
         m0AKYuOMXLlVVuo9pIm/PD62Mq6HEQZE/y9pXujBCznES3VzffnwJ7+NnI/UfQyfKNIj
         ZEdB8yP4hGdFMGGwbDHEtcfnW1NfyFcr47Y0zLsuQo9706Q8nPJ7jKm6gR2pD53MlmIm
         dWyIuESBYlc3po7lHY9Qi7PEIGwJlKn7BcC+aV1bdOrGINdt4s+WNtoH4BA2hPdnpOkc
         96PQ==
X-Gm-Message-State: AOAM532BKnNq1xaQwF90kRJoedvLHwph/nDz1700moiotteVs/FEUa4v
        05zQQBAxNNf9dvHLmXemEVv7JEsweC0=
X-Google-Smtp-Source: ABdhPJylqMXQGKTlmnPfp26Mn7dao1YgWG7htPyEpONiO22Ggga6Tlf4bzQNnEnK7C93V4kGf7L02Q==
X-Received: by 2002:a17:902:323:: with SMTP id 32mr1579212pld.59.1598969772004;
        Tue, 01 Sep 2020 07:16:12 -0700 (PDT)
Received: from bobo.ibm.com ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id w9sm2212816pgg.76.2020.09.01.07.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 07:16:11 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@kernel.org>
Subject: [PATCH v3 06/23] csky: use asm-generic/mmu_context.h for no-op implementations
Date:   Wed,  2 Sep 2020 00:15:22 +1000
Message-Id: <20200901141539.1757549-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200901141539.1757549-1-npiggin@gmail.com>
References: <20200901141539.1757549-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: linux-csky@vger.kernel.org
Acked-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/csky/include/asm/mmu_context.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/csky/include/asm/mmu_context.h b/arch/csky/include/asm/mmu_context.h
index abdf1f1cb6ec..b227d29393a8 100644
--- a/arch/csky/include/asm/mmu_context.h
+++ b/arch/csky/include/asm/mmu_context.h
@@ -24,11 +24,6 @@
 #define cpu_asid(mm)		(atomic64_read(&mm->context.asid) & ASID_MASK)
 
 #define init_new_context(tsk,mm)	({ atomic64_set(&(mm)->context.asid, 0); 0; })
-#define activate_mm(prev,next)		switch_mm(prev, next, current)
-
-#define destroy_context(mm)		do {} while (0)
-#define enter_lazy_tlb(mm, tsk)		do {} while (0)
-#define deactivate_mm(tsk, mm)		do {} while (0)
 
 void check_and_switch_context(struct mm_struct *mm, unsigned int cpu);
 
@@ -46,4 +41,7 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 
 	flush_icache_deferred(next);
 }
+
+#include <asm-generic/mmu_context.h>
+
 #endif /* __ASM_CSKY_MMU_CONTEXT_H */
-- 
2.23.0


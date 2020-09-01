Return-Path: <SRS0=ECFR=CK=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335F2C433E6
	for <linux-arch@archiver.kernel.org>; Tue,  1 Sep 2020 14:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E66B2206CD
	for <linux-arch@archiver.kernel.org>; Tue,  1 Sep 2020 14:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbCIVvEz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgIAOQd (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbgIAOP5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 10:15:57 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07615C06125F;
        Tue,  1 Sep 2020 07:15:57 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ls14so673987pjb.3;
        Tue, 01 Sep 2020 07:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ypq4V2n6hl0lHX9y7DtLS7ZcrqEPUBbxsLMtFlrStVc=;
        b=dbCIVvEzwJuO+omKZYGl30Jm5UXT6FFIqT47ktoREvEjVKZpwSdT69hMlvg9PQwQTB
         mihJpL+5DkDOOetBf+zFTpyVQwWusTQRnbfIEJFcWW/xufoyBvc96pPwyonS9uDO3hC7
         UqU7+RTGCP5VYQTurJ4gv5xZx7OFv1ZNE8QVXUbXBIt+4EGknUwjyClJ2vW3fmCJ/5dN
         cnC3XBy8kpEArVpfpSMgPkUUVLVBMjEv0vf/4VDXr0xzgW6qowREjyPH69ksazjSqQac
         xMuvOnpQwhE/S5FZkTD3LPeL49fFgNQfzKIJGovNvaAA3UrTdMfv3xsrJ9+ATYugLsLX
         kRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ypq4V2n6hl0lHX9y7DtLS7ZcrqEPUBbxsLMtFlrStVc=;
        b=rzMkbnKQNRiKPv8itphEeZ4gaRowIhsFobzqMlRz0HE5SVbqim4BxjDl5xeC0xqMpQ
         +Vvh6FonDgygLxivExq9xI/rYuLi5IYRm2qc2hi7r0Eu02xKMmowTAn9ljuyxPYle6Bl
         VRwyNyykpggXwI0KDcFOj9l2D5GGaVzperCdp11+LSWmxwSXzjFCvFgy5DolscPdutPz
         /MGlsoq+eQN3k33a++Mo6dO+AL/8bz+oz7YhM06woKd/3tFjKmTOHavUlgjFm6Sx28Qn
         ODrEoESxE9ongV6q61F0tItljjEhO61SU4Tm06hdpdkbe9HdODMorz/N7E1BQpWwTvfT
         0J1w==
X-Gm-Message-State: AOAM532Ps3kScN4HsBvuygEV+cgGWndt9NzsCYPU2jJMykOSv7hXAtOX
        gorCoITCStlGd4WcROle2xappgfvu5Q=
X-Google-Smtp-Source: ABdhPJyO0woqavVhMdTRr3W6I7mhJVIY/BQdP03aVwxP6SXaAUdSR9MeoyVKLSK/fY6DFmxiP+ZOjA==
X-Received: by 2002:a17:902:7e86:: with SMTP id z6mr1573791pla.316.1598969756406;
        Tue, 01 Sep 2020 07:15:56 -0700 (PDT)
Received: from bobo.ibm.com ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id w9sm2212816pgg.76.2020.09.01.07.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 07:15:55 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: [PATCH v3 02/23] alpha: use asm-generic/mmu_context.h for no-op implementations
Date:   Wed,  2 Sep 2020 00:15:18 +1000
Message-Id: <20200901141539.1757549-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200901141539.1757549-1-npiggin@gmail.com>
References: <20200901141539.1757549-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

Please ack or nack if you object to this being mered via
Arnd's tree.

 arch/alpha/include/asm/mmu_context.h | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/alpha/include/asm/mmu_context.h b/arch/alpha/include/asm/mmu_context.h
index 6d7d9bc1b4b8..4eea7c616992 100644
--- a/arch/alpha/include/asm/mmu_context.h
+++ b/arch/alpha/include/asm/mmu_context.h
@@ -214,8 +214,6 @@ ev4_activate_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm)
 	tbiap();
 }
 
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
 #ifdef CONFIG_ALPHA_GENERIC
 # define switch_mm(a,b,c)	alpha_mv.mv_switch_mm((a),(b),(c))
 # define activate_mm(x,y)	alpha_mv.mv_activate_mm((x),(y))
@@ -229,6 +227,7 @@ ev4_activate_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm)
 # endif
 #endif
 
+#define init_new_context init_new_context
 static inline int
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
@@ -242,12 +241,7 @@ init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	return 0;
 }
 
-extern inline void
-destroy_context(struct mm_struct *mm)
-{
-	/* Nothing to do.  */
-}
-
+#define enter_lazy_tlb enter_lazy_tlb
 static inline void
 enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
@@ -255,6 +249,8 @@ enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 	  = ((unsigned long)mm->pgd - IDENT_ADDR) >> PAGE_SHIFT;
 }
 
+#include <asm-generic/mmu_context.h>
+
 #ifdef __MMU_EXTERN_INLINE
 #undef __EXTERN_INLINE
 #undef __MMU_EXTERN_INLINE
-- 
2.23.0


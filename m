Return-Path: <SRS0=Iq1u=CE=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D41C433E1
	for <linux-arch@archiver.kernel.org>; Wed, 26 Aug 2020 14:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB72B221E2
	for <linux-arch@archiver.kernel.org>; Wed, 26 Aug 2020 14:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uSNxJCCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgHZOzy (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbgHZOyH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 10:54:07 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93ADAC061574;
        Wed, 26 Aug 2020 07:54:07 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id t9so1104550pfq.8;
        Wed, 26 Aug 2020 07:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zBLkp4ACPTazmjPNrlv/57ssiAbYaRhM1wboTYBBHDY=;
        b=uSNxJCClbqUuUEiL7mllj0REZCxj02jP+VSTCg3tcnylJDmNQH4a5oyn88Bt+3eHUt
         bP6O5AD3MwNhFSH8Q0PFYDNR2VCysyCxqesgLG4NhSisN4fNx6swSxxr5Rn4iHq8S0fR
         m8O5J5JhMom+ifRYFniXvRy6s3w5+Nct8qgQR1IHBC8WIjz1HmP73703CEUIx9Hr5CkA
         q4E8oFBATyEdLyBKzG0ktNJA7Hpu1B2BrpUU2qNkZI2cRBpf1nDFb8H3uBFyGUBmqzWM
         Okp80aCvl7+nj+4TXB2CG6EZhUETKljPPNG7PbsdJILAJIxpt4bc5ekzMY00SjK2awhR
         u17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zBLkp4ACPTazmjPNrlv/57ssiAbYaRhM1wboTYBBHDY=;
        b=sXRgl2oImYdviApXrAyqE7eSnSr+FgvsSgy5WLzLRgddQUDNkdr2kIhf1/lv+Xblz8
         taHfUlYWr+JKeuemeJJvjaE8l/qyyhhtRKHIJSldgm9DdlHHfr7ECrUAmk8OEOjj7WQd
         E0KQ13XFZC0p0S/+ExNmMAtATjOZfSuch+z02iShtLu/VJgw9k/fbxylzO+NIFbAiatU
         nzrQdzHpJNyW+dWmBToB0BN6dc3VdPWIYb0/NRA/TXyd/U9E1UHvI5+FP1IBnnRPXBlx
         jYAcWfrkAo2vOYJh0wF+VCeuyAaEtWBsMXSFq2K5mv2RDInsFVgOeMrYnly7WGpW9Nbx
         4SeQ==
X-Gm-Message-State: AOAM530a37Xj9ULPjlJ8gdxVXpTPUGEH1LctpgR44T4AoU2yNCxza9vc
        LHmMFBUn1PbzEuxhzpFWMi3NUF7nTfA=
X-Google-Smtp-Source: ABdhPJxDJLTwl2v7C8g+nyXKqYtHmkN28jUfxjmjM3NvMv1M+2qk9vPQk9UmGDyP90WNq4KKmAi2Dg==
X-Received: by 2002:aa7:8182:: with SMTP id g2mr12519947pfi.261.1598453646914;
        Wed, 26 Aug 2020 07:54:06 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id r7sm3327140pfl.186.2020.08.26.07.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:54:06 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH v2 18/23] s390: use asm-generic/mmu_context.h for no-op implementations
Date:   Thu, 27 Aug 2020 00:52:44 +1000
Message-Id: <20200826145249.745432-19-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200826145249.745432-1-npiggin@gmail.com>
References: <20200826145249.745432-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/s390/include/asm/mmu_context.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index c9f3d8a52756..66f9cf0a07e3 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -15,6 +15,7 @@
 #include <asm/ctl_reg.h>
 #include <asm-generic/mm_hooks.h>
 
+#define init_new_context init_new_context
 static inline int init_new_context(struct task_struct *tsk,
 				   struct mm_struct *mm)
 {
@@ -69,8 +70,6 @@ static inline int init_new_context(struct task_struct *tsk,
 	return 0;
 }
 
-#define destroy_context(mm)             do { } while (0)
-
 static inline void set_user_asce(struct mm_struct *mm)
 {
 	S390_lowcore.user_asce = mm->context.asce;
@@ -125,9 +124,7 @@ static inline void finish_arch_post_lock_switch(void)
 	set_fs(current->thread.mm_segment);
 }
 
-#define enter_lazy_tlb(mm,tsk)	do { } while (0)
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev,
                                struct mm_struct *next)
 {
@@ -136,4 +133,6 @@ static inline void activate_mm(struct mm_struct *prev,
 	set_user_asce(next);
 }
 
+#include <asm-generic/mmu_context.h>
+
 #endif /* __S390_MMU_CONTEXT_H */
-- 
2.23.0


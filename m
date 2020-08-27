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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63445C433E4
	for <linux-arch@archiver.kernel.org>; Thu, 27 Aug 2020 10:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DB212075B
	for <linux-arch@archiver.kernel.org>; Thu, 27 Aug 2020 10:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtGH5F6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgH0KSd (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 27 Aug 2020 06:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbgH0KOg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 06:14:36 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FD9C061264;
        Thu, 27 Aug 2020 03:14:35 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id g6so2353032pjl.0;
        Thu, 27 Aug 2020 03:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=jvIU1C8xMP6WcFtiASQieWl9PBc0cM/X9m49AuYn3v4=;
        b=MtGH5F6JVuriOopERqxIJ5MWmzdSYALg+MZ6zMjBHNh2fDEj517cH8RDOLSEqcruQA
         qY5QhahgFbYY9ODI3OPGtHNJ35210kgCf8s3u7DlH8H+H7ESZWLLHDlshgShmeWK8oaL
         KQ3tzOzV9Q9DCcBSH8cXt3VidkWUNn/tIkamDbELoWF2RgDIH56Ztzccofz36M4ZCS01
         pBXJXSSAPLze+nvY2cEMVp9uBbwsM8/Ueo0HyRMjbsYwBjM8wYgJS51oBuEvKNjvwb10
         aIRAegKJHO/a0bILMRSfC9Z3YapS1s3gxTxnZJLV41AZ2WJCKoskdjGxo6+sx3ufCpip
         6RJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=jvIU1C8xMP6WcFtiASQieWl9PBc0cM/X9m49AuYn3v4=;
        b=lm1w+MaifO5xzzEtAPlsap2Xvh7vUJHJ5se3ofeHobmNenXoxUrvCrx6LuSMSRn+cW
         M3sxXLtJ2fRektmdlRaGv/DBDLaAtqVnILWxkGd8d0DMLeWmUjI4o+gadZW/AdJL7o44
         AM3j5+coKLJOA7dLoxitGAaZPKuo4FQi5dxz70KLLVbbMASxcjkzinsNZ1GZJ3sDMa3u
         kgSQvaQizVXQ89keKwYyuheb5bkfOa1HLQRXXyzHQ5fscHKlQ9dzyHafXTLckAw6QDzs
         a7dvz/ONHqagQzaWrw/2j8zmBHGRR4GTlEcG7oekJabHnmzzbp6N7nqlZFvW0+yQeark
         eJkw==
X-Gm-Message-State: AOAM531nUt+M87qlEsQ7Ri15SBhYk8aE6sawnpqKsu4Ysc28WWX/UU8g
        MnxzaQhMV4bs5rV96QCZIe0=
X-Google-Smtp-Source: ABdhPJyPSxYAT0eFZtjmdSmvlioTDc7oXqB5hls3x6WIv6TItYg3y+Yt3qlA/YngeKl/1ULKQ54/Rg==
X-Received: by 2002:a17:90a:c688:: with SMTP id n8mr9827755pjt.7.1598523275403;
        Thu, 27 Aug 2020 03:14:35 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id t10sm2333434pfq.52.2020.08.27.03.14.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 03:14:35 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     arnd@arndb.de
Cc:     rppt@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/23] KVM: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
Date:   Thu, 27 Aug 2020 18:14:08 +0800
Message-Id: <fac741b7bb9b93c30b5134eb9741bce344b9ef15.1598518912.git.brookxu@tencent.com>
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
 arch/x86/kvm/ioapic.h | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/kvm/ioapic.h b/arch/x86/kvm/ioapic.h
index 6604017..aa0c61a 100644
--- a/arch/x86/kvm/ioapic.h
+++ b/arch/x86/kvm/ioapic.h
@@ -94,14 +94,7 @@ struct kvm_ioapic {
 };
 
 #ifdef DEBUG
-#define ASSERT(x)  							\
-do {									\
-	if (!(x)) {							\
-		printk(KERN_EMERG "assertion failed %s: %d: %s\n",	\
-		       __FILE__, __LINE__, #x);				\
-		BUG();							\
-	}								\
-} while (0)
+#define ASSERT(x) ASSERT_FAIL(x)
 #else
 #define ASSERT(x) do { } while (0)
 #endif
-- 
1.8.3.1


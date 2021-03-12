Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F34C468BF
	for <linux-arch@archiver.kernel.org>; Fri, 12 Mar 2021 00:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9273A64F82
	for <linux-arch@archiver.kernel.org>; Fri, 12 Mar 2021 00:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhCLAtq (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 11 Mar 2021 19:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbhCLAt3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Mar 2021 19:49:29 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9841C061574
        for <linux-arch@vger.kernel.org>; Thu, 11 Mar 2021 16:49:28 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id x20so7354358qvd.21
        for <linux-arch@vger.kernel.org>; Thu, 11 Mar 2021 16:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=H7rLHacy3F07lJtMDfRAgErCQuUrrLGxI+6W0d6WNpU=;
        b=sUvmGnJ+rhgNMV6BMGfzMD6FhlSVemJZuz19BUK84N0z28Eoya5RelUNEB4bGszQ8g
         h59RKb80ZeuYZloMlKF0xAboydHMpXu92lVUTi82QMs81W8kTnYA1ZDNiNx3x+misJXL
         GM0Xkdrdn0O8zTvSRuEj345cHir/Ug/LUWrHGzcxiWWeQYb101FpAB0rLvX5F/W4gV7o
         YylaNmKIJoPpazOXW8XD4FPKiXg1EBF1QXOtdCNVG3JMSbC9vt6JCxYbBgz4DChIKPWL
         wQv7/tmAQxWr5y+X5O61j8AOyrVenfu0Qfcg0+4/OzYM99F4RhaIvLi87Qy1DQXYuiSQ
         dkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=H7rLHacy3F07lJtMDfRAgErCQuUrrLGxI+6W0d6WNpU=;
        b=L32lfQFa+nrJ+dK47v+z6cpgwYckD16Ix0aEt89bf6AIa3iXmLSyt8W2YHvlzdr4gU
         Z3NHWxiQTFHjgl9DgzcmYocYJG8+CEcqhi7AuDeqjFOJcqznMK49FpvN8v1YMjDUBhZN
         NUkiV3vfUa4Px34jOq+mo9Z+zL00ywE0m96Ecw9viEYC/jLWPciTbyq2zFlWDCSuGTpF
         338Uk8T56//cBF5AJppjlHpACkhK5JyymXvtCDtMPSVhgALQMUNq5YE/+UnYrYl3+U6y
         2+fD7LzqTcEqsJcDx0Gg8nH/TIdwUYHerknudjovEjs1SzULCxfujMowlKWcIZ2WgLdC
         yfNg==
X-Gm-Message-State: AOAM533DyuZmgLM42P5arOB4xVzG58i6gC4AuedTab2LMMk9Q2OHgEJe
        kQbDwq2s9aGYA6g73kuu4U5lhl/4ZW8oSbaS4vc=
X-Google-Smtp-Source: ABdhPJzcwYBUkwwPBHNvKt/g3QgQMzip9UKPQANWzW+ZzALJcGM1EFSFPH1hDnIaEovkHR0Pipxp3EXxwVLjJY4HWJw=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c86b:8269:af92:55a])
 (user=samitolvanen job=sendgmr) by 2002:a0c:f541:: with SMTP id
 p1mr10332251qvm.14.1615510168097; Thu, 11 Mar 2021 16:49:28 -0800 (PST)
Date:   Thu, 11 Mar 2021 16:49:06 -0800
In-Reply-To: <20210312004919.669614-1-samitolvanen@google.com>
Message-Id: <20210312004919.669614-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210312004919.669614-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 04/17] module: cfi: ensure __cfi_check alignment
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

CONFIG_CFI_CLANG_SHADOW assumes the __cfi_check() function is page
aligned and at the beginning of the .text section. While Clang would
normally align the function correctly, it fails to do so for modules
with no executable code.

This change ensures the correct __cfi_check() location and
alignment. It also discards the .eh_frame section, which Clang can
generate with certain sanitizers, such as CFI.

Link: https://bugs.llvm.org/show_bug.cgi?id=46293
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 scripts/module.lds.S | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 168cd27e6122..552ddb084f76 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -3,10 +3,13 @@
  * Archs are free to supply their own linker scripts.  ld will
  * combine them automatically.
  */
+#include <asm/page.h>
+
 SECTIONS {
 	/DISCARD/ : {
 		*(.discard)
 		*(.discard.*)
+		*(.eh_frame)
 	}
 
 	__ksymtab		0 : { *(SORT(___ksymtab+*)) }
@@ -40,7 +43,16 @@ SECTIONS {
 		*(.rodata..L*)
 	}
 
-	.text : { *(.text .text.[0-9a-zA-Z_]*) }
+#ifdef CONFIG_CFI_CLANG
+	/*
+	 * With CFI_CLANG, ensure __cfi_check is at the beginning of the
+	 * .text section, and that the section is aligned to page size.
+	 */
+	.text : ALIGN(PAGE_SIZE) {
+		*(.text.__cfi_check)
+		*(.text .text.[0-9a-zA-Z_]* .text..L.cfi*)
+	}
+#endif
 }
 
 /* bring in arch-specific sections */
-- 
2.31.0.rc2.261.g7f71774620-goog


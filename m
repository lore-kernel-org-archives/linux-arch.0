Return-Path: <SRS0=8KsW=C3=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0F2C43463
	for <linux-arch@archiver.kernel.org>; Fri, 18 Sep 2020 20:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F40023447
	for <linux-arch@archiver.kernel.org>; Fri, 18 Sep 2020 20:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TVxfXnF4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgIRUQG (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 18 Sep 2020 16:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgIRUP5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 16:15:57 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BD0C0613D8
        for <linux-arch@vger.kernel.org>; Fri, 18 Sep 2020 13:15:50 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id e6so6111283qtg.13
        for <linux-arch@vger.kernel.org>; Fri, 18 Sep 2020 13:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=FDO+ZF09uotnTu6WM5EnkpUkRKmQDNuzRpzleKkQ7Yo=;
        b=TVxfXnF4QbOPDMOs+zqprMl2MzHgkD6GHCP7JmlPrBoZmOkVnQx/H8w57iWBE6jaYf
         6+KkRK3tQNrNeiix7gFvoYRY8m013PG2qHvBhB7usMFzmH6as/mPJIJ0i1xJYkR6xOcN
         NBHnEyx+G51AeSvmq8253zxiLfvPoAtayITYFw57JnKIYoHuBvQlTEjn3JLNIpdkKk/R
         wAJfJUuh6er8cS8DBKpDt+WcOB99abRnmwdIFbnaz0FqbKU/UIqZu02x2Ix+ynYt2cU+
         uk5Y9gomclggvJtQ/OeFZIMHKEYveSFAxG5tPl5ZC3h8ga6eKx8TJpzeEBbhGIGPyZ1F
         9rHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FDO+ZF09uotnTu6WM5EnkpUkRKmQDNuzRpzleKkQ7Yo=;
        b=Mycj7qOyW4202YHMoU6ORnePTVQ+EG33fwn4tXgYEaGjB3CH63OgFDc8cTZq1PAL7q
         KF5Ytd4q54WqM7lV0byOr1zweM2n9JOyvcKXjH4vRXWsTgxbe8kC5GJdLSQt0VsPTDq4
         B9qba9Hus7p9YsUFfLVfia0qDko4S+xqns7hEyzoqP5ZsGlouOSFH2jPaPOoz4TRh41G
         WR7zz1yDJXe9LpuP0jQFH0ynaVTru7gpeG6y8SZ0U7LUZLb6i6dFwWpD6poD7OoPPrS/
         14ZyNfV4Xa1d/PcwdVSimSnY79RyY2D0F2k+MDxtLngRENFkVlMLezHb3ClvypM07Y1Y
         Rv5w==
X-Gm-Message-State: AOAM530wYV6rbkkRP1/LD0tM3FBk6wpKaAorYmgnjvxQEVt+KKK4mXRA
        yQwMZ/YNo5Yb2YJjIoK4IAkhv/aRxSAw0/RH7YI=
X-Google-Smtp-Source: ABdhPJze5jMIoa5F5/UqpO3D/iFpSGC3f1kIVz5ZhEpSgtL6QfaALCSDHhqVkIqGdPsyHGP7v5lpZGVr0MzGMD5vThc=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:5653:: with SMTP id
 bl19mr34387705qvb.7.1600460148677; Fri, 18 Sep 2020 13:15:48 -0700 (PDT)
Date:   Fri, 18 Sep 2020 13:14:35 -0700
In-Reply-To: <20200918201436.2932360-1-samitolvanen@google.com>
Message-Id: <20200918201436.2932360-30-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200918201436.2932360-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 29/30] x86, cpu: disable LTO for cpu.c
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Clang incorrectly inlines functions with differing stack protector
attributes, which breaks __restore_processor_state() that relies on
stack protector being disabled. This change disables LTO for cpu.c
to work aroung the bug.

Link: https://bugs.llvm.org/show_bug.cgi?id=47479
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/power/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/power/Makefile b/arch/x86/power/Makefile
index 6907b523e856..5f711a441623 100644
--- a/arch/x86/power/Makefile
+++ b/arch/x86/power/Makefile
@@ -5,5 +5,9 @@ OBJECT_FILES_NON_STANDARD_hibernate_asm_$(BITS).o := y
 # itself be stack-protected
 CFLAGS_cpu.o	:= -fno-stack-protector
 
+# Clang may incorrectly inline functions with stack protector enabled into
+# __restore_processor_state(): https://bugs.llvm.org/show_bug.cgi?id=47479
+CFLAGS_REMOVE_cpu.o := $(CC_FLAGS_LTO)
+
 obj-$(CONFIG_PM_SLEEP)		+= cpu.o
 obj-$(CONFIG_HIBERNATION)	+= hibernate_$(BITS).o hibernate_asm_$(BITS).o hibernate.o
-- 
2.28.0.681.g6f77f65b4e-goog


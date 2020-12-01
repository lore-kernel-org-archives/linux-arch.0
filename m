Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8293FC71155
	for <linux-arch@archiver.kernel.org>; Tue,  1 Dec 2020 21:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DE8B2085B
	for <linux-arch@archiver.kernel.org>; Tue,  1 Dec 2020 21:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N2hjZ+w1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390137AbgLAVjp (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 1 Dec 2020 16:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389977AbgLAVjd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Dec 2020 16:39:33 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFA9C09425A
        for <linux-arch@vger.kernel.org>; Tue,  1 Dec 2020 13:37:41 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v13so3969763ybe.18
        for <linux-arch@vger.kernel.org>; Tue, 01 Dec 2020 13:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=2x/zjVn7tqzzMwlgW94lOF/53GHge2qEfxVssZKSVKU=;
        b=N2hjZ+w1m+tzNKULGFriHMyI0W/WLxUEDGY1DnBMXxPtD5xhjPfovZ1l0CpNo2iRQO
         +tTomPyUoponyE1362CelbbrDZwWrvZ66ad2D/JxuGm1GX6gaUseX8hQbfi3OUGkhp0H
         9SmgV/+6Q7Bt3K0LuNqv/RrzRFY59diqYwZBhEZG9fnh7VFPaEUCT6hXis0JB7dm8/Jq
         tWSPkyod8RuoKjamef9WjpoKLdp1BdmoMZ4kk/XBfD1LF2w8eoyA6CMmckQwNxU7jj5H
         YD9zFativ+Sd8bT4A5VYcPCPPXLEbmnubfljTsMu/1a5ZsRn5Qy9mkUKuq9Y0tLJtllx
         jchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2x/zjVn7tqzzMwlgW94lOF/53GHge2qEfxVssZKSVKU=;
        b=c1MLAeKnG2wJJon1APHE7aJDxU5sFMF01Pu5qVvrfelMnyET5Ndvs5+d/3AnpsEeN5
         w4Z83gdtqDzZ9xlJHIObBrlCfWqbcCIvnLUPjF/BCwBcH70hkBSlUirC5HMmJnusJhA/
         6zmJgwwU3YFPn/8Epu6KdXWs3xop+NRsWkdfWbDvlhS32x69IJn2ubQCqtVpf8FLk1er
         7KyKzkpI6zSGZYJkNUgBWUTzAlLZyo05dRc40hQM153BsE55URul9GyqoNnQpJQq8hZd
         Jtzh3yWujL8TkSJ8Sbb+K88Cr8sWIwP4xLfJ+EG05CyGtUYJOuBkA2mpSNIqA1/AJ1kF
         vygw==
X-Gm-Message-State: AOAM5323lgEnsgzyT2m8p7YULnfXdata9g8uTRPDtCWutYsb1eP4/KwQ
        PHLKh7+ec226ChGbXVJf4jOByMuOAlVs1VXQqOU=
X-Google-Smtp-Source: ABdhPJxHcUCj2mucLF7aE1IOS9CUSMZkQ+YtaXx/Kwh7BPBYbWWQuO91AIxxkwqaFlZSB+yJbXqZO28tnCnqith2Mko=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:c106:: with SMTP id
 r6mr7621086ybf.519.1606858660290; Tue, 01 Dec 2020 13:37:40 -0800 (PST)
Date:   Tue,  1 Dec 2020 13:37:03 -0800
In-Reply-To: <20201201213707.541432-1-samitolvanen@google.com>
Message-Id: <20201201213707.541432-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201201213707.541432-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v8 12/16] efi/libstub: disable LTO
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With CONFIG_LTO_CLANG, we produce LLVM bitcode instead of ELF object
files. Since LTO is not really needed here and the Makefile assumes we
produce an object file, disable LTO for libstub.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 drivers/firmware/efi/libstub/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 8a94388e38b3..c23466e05e60 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -38,6 +38,8 @@ KBUILD_CFLAGS			:= $(cflags-y) -Os -DDISABLE_BRANCH_PROFILING \
 
 # remove SCS flags from all objects in this directory
 KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
+# disable LTO
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
 
 GCOV_PROFILE			:= n
 # Sanitizer runtimes are unavailable and cannot be linked here.
-- 
2.29.2.576.ga3fc446d84-goog


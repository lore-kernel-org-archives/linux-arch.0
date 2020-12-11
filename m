Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E1FC433FE
	for <linux-arch@archiver.kernel.org>; Fri, 11 Dec 2020 20:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCE5723125
	for <linux-arch@archiver.kernel.org>; Fri, 11 Dec 2020 20:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406239AbgLKSsn (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 11 Dec 2020 13:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404947AbgLKSsa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Dec 2020 13:48:30 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C2DC061143
        for <linux-arch@vger.kernel.org>; Fri, 11 Dec 2020 10:46:57 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id a27so7134285pga.6
        for <linux-arch@vger.kernel.org>; Fri, 11 Dec 2020 10:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=sUICI29mkgxH8XDf6qhMCrhn46+Hzc1owynREvsajYA=;
        b=Mt5+qfjfZ+VylSyluHh2VZfop+oBL3rJXxZDwRaX22l0TfpVmfjZWdRRf4EjcTdwNZ
         tI2smkjeD1V9WDfLcVGcM0q3lBKc5wUlQ0PV2xNazny/qeDxBgjfBw3M6ZeazZiiVTRk
         PuilV1bsANPSfYl5rf4CFzgLv9TH7xZEN6ZdlxzmXfi8iZ0NN8yPkHKEhjrDZeO93M3Z
         Is2ezXs/oAG91woA/WjRTGjceaiPw8zQ6gbt9xphaeSWeIK5J0CKds3mJv3qxGB+SGOL
         yPRehVrtvjhUpPjpNJk+E+PHpWf8LAXA2fOr5tqj7a6NYji5/SC+3IO85wAjvRUlfz9n
         9oSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sUICI29mkgxH8XDf6qhMCrhn46+Hzc1owynREvsajYA=;
        b=dFO4dKJwZNX36qpI1vcpEf8xptL/pmP3kvzUM+mjYvOjYQSq+F2pzE4ekJI+KizH6U
         o78d8Cc/eipRoBsfV3PNIbAekdlIlhW3OqOQ0GKKhz0mFHxqwpKtufkhptx3Y4UXAolW
         +/2k6hZoQxLU5DNDNDksZPnbsu2WQ8k01hRQJOpnKkHskguGJVMv9ZsMbzVK6KevpLxR
         kVrwWMJQgC/BDoPxdFumT+6u1gSC3bndspnWqew7oMhk/aoPNS3n9TsNmyxjjdpgLq24
         XepozRwGT/DB+CQzU+1zdCTXBat7ejCZghkJB5MjPydrdOw4g5SJPXrzsUj3O2raOgfR
         Hvug==
X-Gm-Message-State: AOAM532nG3Sq+PyhuRtnATMi6N8DQCr5eWhRAI65IuS7pbxbF9YsLdlb
        i2uJh9RJegJ9EUK0CN3LRRRgN8bL21pgbo4zu54=
X-Google-Smtp-Source: ABdhPJyLTnaXTvQFzdGZbemjJUsFLRdMqMxsuXqAqm5rCyQnrHrKDgTVs/Qim5syv8mGMDSyRXsRkeSRJzrM/1+uvUc=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a17:902:8343:b029:da:cf6a:f65c with
 SMTP id z3-20020a1709028343b02900dacf6af65cmr12048006pln.5.1607712417071;
 Fri, 11 Dec 2020 10:46:57 -0800 (PST)
Date:   Fri, 11 Dec 2020 10:46:28 -0800
In-Reply-To: <20201211184633.3213045-1-samitolvanen@google.com>
Message-Id: <20201211184633.3213045-12-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201211184633.3213045-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v9 11/16] scripts/mod: disable LTO for empty.c
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

With CONFIG_LTO_CLANG, clang generates LLVM IR instead of ELF object
files. As empty.o is used for probing target properties, disable LTO
for it to produce an object file instead.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 scripts/mod/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/mod/Makefile b/scripts/mod/Makefile
index 78071681d924..c9e38ad937fd 100644
--- a/scripts/mod/Makefile
+++ b/scripts/mod/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 OBJECT_FILES_NON_STANDARD := y
+CFLAGS_REMOVE_empty.o += $(CC_FLAGS_LTO)
 
 hostprogs-always-y	+= modpost mk_elfconfig
 always-y		+= empty.o
-- 
2.29.2.576.ga3fc446d84-goog


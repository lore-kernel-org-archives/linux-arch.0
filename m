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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A42C43460
	for <linux-arch@archiver.kernel.org>; Thu,  1 Apr 2021 23:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ADD561107
	for <linux-arch@archiver.kernel.org>; Thu,  1 Apr 2021 23:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbhDAXd7 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 1 Apr 2021 19:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236485AbhDAXdp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Apr 2021 19:33:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67169C05BD13
        for <linux-arch@vger.kernel.org>; Thu,  1 Apr 2021 16:32:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v186so7432285ybe.5
        for <linux-arch@vger.kernel.org>; Thu, 01 Apr 2021 16:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4zmDXsca0ECrWDzVS194BszWB+2fKXJW5Au7Imi/uhE=;
        b=PH3FtJBGBsmgrkbZDVz3BXtOomtM40isF73uxHHdcAgWFlI0hQzmJ+Yiu0Nbk36AiS
         oIUF/OouhVLXAHv5lePfztQEQCdoF3WKPYY1A6g21bn1QVawFocJ0FQMqW+JvkyRMXC0
         7MlgKTeKlTukJdkvN/08vCaQdhh5X+mvr2muSbV3dFgjINzTMQPZYmQpEcNiuXE8tNMf
         3VgtV0lRhBFCEGG3XpYQc/aLht2YKd/8ej+EsbM8UOkPXsBBShbt6fFkrZnQbYbNFDMD
         JSw7hOAw7svmOppJvJC33a/bIukeU+OjfUKoipleTgiaIG9tnHBTD0G84ol+6TIFQPCe
         UDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4zmDXsca0ECrWDzVS194BszWB+2fKXJW5Au7Imi/uhE=;
        b=t1BeFpxgnwGfGyN3RQl51chIGZz3q6wCJFt4/1okGNfwy/XrhX1v96znsUjCBY+YVq
         FTvk61kNy16A24RI2PjKjAffadvGlcgISdRLkLqbB+VmuCApxF07QiGL5jrpuLNQo//U
         g+b9BGQfQ9lp/DgmesOe6AoDsPd62W4POV+Q6AIWhs4/coiydtrh6pgi3gTtIJX58GX7
         1MS6Vc3DrcF9ZEijBk+Iz3y+c9QjDkKmmcia6d1X0x2LqWyfKrieE+jt1Xhdmhsm1ShM
         LD3cFtJyaN00374lPlLEK5MLx9cEKcdEWWOaaJsnvXm+UJteSA+KnI2pXL4leDasLmPN
         zG+Q==
X-Gm-Message-State: AOAM531xfs7hJagc3/VLBrll1qQEROZ2DSjAPxFJSVQejs91HyzIGlBb
        uXbv6SV+UqeXslKLC24DgiBnkzMkKOTPJPXh3qg=
X-Google-Smtp-Source: ABdhPJxZF9glk9+ZtBirKYDEGjQrdMhhNWgdR3tCZ5JLBfUCEc7h35+3XPVRFL47JJ5bGJZvKS8N/Lhi8ZZQtRsAJC4=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:4cd1:da86:e91b:70b4])
 (user=samitolvanen job=sendgmr) by 2002:a25:880c:: with SMTP id
 c12mr15159486ybl.399.1617319972614; Thu, 01 Apr 2021 16:32:52 -0700 (PDT)
Date:   Thu,  1 Apr 2021 16:32:14 -0700
In-Reply-To: <20210401233216.2540591-1-samitolvanen@google.com>
Message-Id: <20210401233216.2540591-17-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210401233216.2540591-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v5 16/18] arm64: ftrace: use function_nocfi for ftrace_call
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With CONFIG_CFI_CLANG, the compiler replaces function pointers with
jump table addresses, which breaks dynamic ftrace as the address of
ftrace_call is replaced with the address of ftrace_call.cfi_jt. Use
function_nocfi() to get the address of the actual function instead.

Suggested-by: Ben Dai <ben.dai@unisoc.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/kernel/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 86a5cf9bc19a..b5d3ddaf69d9 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -55,7 +55,7 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	unsigned long pc;
 	u32 new;
 
-	pc = (unsigned long)&ftrace_call;
+	pc = (unsigned long)function_nocfi(ftrace_call);
 	new = aarch64_insn_gen_branch_imm(pc, (unsigned long)func,
 					  AARCH64_INSN_BRANCH_LINK);
 
-- 
2.31.0.208.g409f899ff0-goog


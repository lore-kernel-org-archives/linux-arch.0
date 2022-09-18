Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2972DC32771
	for <linux-arch@archiver.kernel.org>; Sun, 18 Sep 2022 15:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiIRPxm (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sun, 18 Sep 2022 11:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiIRPxZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 18 Sep 2022 11:53:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7DC1F631;
        Sun, 18 Sep 2022 08:53:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADEA7615AA;
        Sun, 18 Sep 2022 15:53:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02694C4347C;
        Sun, 18 Sep 2022 15:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663516399;
        bh=DEvoceoa51GjIrkhPQ7BHRzc0Y6qi+1P763yh9ux/40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JhFp5reJF9cDjf6/Si7RZI2tQrtbVPM2/vkE9VqbSilKbjOwao9QPp9VVbaSzLjVK
         5Hbi5RWAzZMu3RmFzF6m/Qc9mjN7BLH9LONJmoeuIn8NNblCMG+k54WHtlwXpUY2DZ
         0dw3QcGiQJK7GNyIUMglnrWxoJPYuhEjIUKsnWuDADZ7tLffzpiniQry2Y4tXJyuV4
         oanQqNfESqmHGvoIEQMsoNGk9owY3A7lzgAG5igr+oVSKbTjjMwC6DYTvlN+EEauSJ
         BE6YhfVquM63iesh6Y6WMyswwdnQvDjnpvyJQEwhhE0sSjl4u4It5YFtTi7AFsGKbU
         3t6JM1U57qUSw==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Borislav Petkov <bp@alien8.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH V5 04/11] compiler_types.h: Add __noinstr_section() for noinstr
Date:   Sun, 18 Sep 2022 11:52:39 -0400
Message-Id: <20220918155246.1203293-5-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220918155246.1203293-1-guoren@kernel.org>
References: <20220918155246.1203293-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

And it will be extended for C entry code.

Cc: Borislav Petkov <bp@alien8.de>
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 include/linux/compiler_types.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 4f2a819fd60a..e9ce11ea4d8b 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -227,9 +227,11 @@ struct ftrace_likely_data {
 #endif
 
 /* Section for code which can't be instrumented at all */
-#define noinstr								\
-	noinline notrace __attribute((__section__(".noinstr.text")))	\
-	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
+#define __noinstr_section(section)				\
+	noinline notrace __section(section) __no_profile	\
+	__no_kcsan __no_sanitize_address __no_sanitize_coverage
+
+#define noinstr __noinstr_section(".noinstr.text")
 
 #endif /* __KERNEL__ */
 
-- 
2.36.1


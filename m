Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62F2C43331
	for <linux-arch@archiver.kernel.org>; Tue, 16 Mar 2021 01:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FFD164F89
	for <linux-arch@archiver.kernel.org>; Tue, 16 Mar 2021 01:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbhCPBzG (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 15 Mar 2021 21:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbhCPByd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Mar 2021 21:54:33 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CFFC061756;
        Mon, 15 Mar 2021 18:54:32 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id by2so8822257qvb.11;
        Mon, 15 Mar 2021 18:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DAuTHkwSalBqH8EpHoooy9z28mwSmA5j1f0I3O8Qj8s=;
        b=ijh4snlc2Amx6+CtrnrKHV8MK3Riz9uKwtUjT42NXePzWiQqcW/xuQQfjWYo4AZPIH
         1p990WXv87kHIBU/yo/8jO/FmrEE6wCTNyKqPGA8sxYQY8zORXiiEYWxkgbJVxFtyy/4
         jEzOSnBXP2+opPelPPTJ8h79QuENLiwy6k71baZVhaE8TrD2/7JKBjK3kmXdV90DyN9v
         KFvhvOXSp2b0a4OVjZSWpAEu0TQgy9MMEkXmzdnC5O0SLGdKVRYooFqavYm8AkEIDfIL
         HX6Sv2nArfYKSw0BzMg0n8HjWwHoIf2U7RG6GZZTY2ZZGmgBuUJqiWZxWkWbMeKZLwWW
         exSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DAuTHkwSalBqH8EpHoooy9z28mwSmA5j1f0I3O8Qj8s=;
        b=W42JYGWgxhZrNwvxjgGEpwoHlIFZbEjHhgDkKEuP01BHBNjv2if21oDeKIo9Rkp5ij
         38U9smbTa1h4WdxXi7paRF6+4DOhLFTe8fpJDA1LMjaCoy7bNMbrIrM/2Lmmxy2tDPLL
         H/1FG4ItL50M/AwtNAJbjHKJaEI0Sd+CXhKpWkH1srAC1CvNBd8vAj1j/PYmv5chFKBp
         e4pYQXdfPvQiI+P+o6XkUqZBOL7Tw0e1hz8xX/LCcS/Fuuhwnc9zy8NtyaA4gvALSPaY
         ZqAEi0j/n8oB9C4hQur+lsuQQBEjl32NweT29VAqErZaD+7qyTAFOR/1JOMUSAHjNqt4
         Bpfw==
X-Gm-Message-State: AOAM5332QEwCYf4NLehq+LcYkdPpAXBZciBK7SJ2RkTzhlQsbtUzuXzU
        +TMCPP99a/SxaY7ufHL9bCo23BLqbR0=
X-Google-Smtp-Source: ABdhPJxFKLjVczXxEW5+046lcFGvWLADwkc39aPemk1zKbGCcL0D6GJ3Ijj6n6Mf8iJGX3dpZUfNOw==
X-Received: by 2002:ad4:4991:: with SMTP id t17mr13491613qvx.33.1615859671930;
        Mon, 15 Mar 2021 18:54:31 -0700 (PDT)
Received: from localhost ([76.73.146.210])
        by smtp.gmail.com with ESMTPSA id k129sm14326595qkf.108.2021.03.15.18.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 18:54:31 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, linux-m68k@lists.linux-m68k.org,
        linux-arch@vger.kernel.org, linux-sh@vger.kernel.org,
        Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rich Felker <dalias@libc.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 03/13] arch: rearrange headers inclusion order in asm/bitops for m68k and sh
Date:   Mon, 15 Mar 2021 18:54:14 -0700
Message-Id: <20210316015424.1999082-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210316015424.1999082-1-yury.norov@gmail.com>
References: <20210316015424.1999082-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

m68k and sh include bitmap/{find,le}.h prior to ffs/fls headers. New
fast-path implementation in find.h requires ffs/fls. Reordering the
headers inclusion sequence helps to prevent compile-time implicit
function declaration error.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/include/asm/bitops.h | 6 +++---
 arch/sh/include/asm/bitops.h   | 5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
index 10133a968c8e..7b414099e5fc 100644
--- a/arch/m68k/include/asm/bitops.h
+++ b/arch/m68k/include/asm/bitops.h
@@ -440,8 +440,6 @@ static inline unsigned long ffz(unsigned long word)
 
 #endif
 
-#include <asm-generic/bitops/find.h>
-
 #ifdef __KERNEL__
 
 #if defined(CONFIG_CPU_HAS_NO_BITFIELDS)
@@ -525,10 +523,12 @@ static inline int __fls(int x)
 #define __clear_bit_unlock	clear_bit_unlock
 
 #include <asm-generic/bitops/ext2-atomic.h>
-#include <asm-generic/bitops/le.h>
 #include <asm-generic/bitops/fls64.h>
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/le.h>
 #endif /* __KERNEL__ */
 
+#include <asm-generic/bitops/find.h>
+
 #endif /* _M68K_BITOPS_H */
diff --git a/arch/sh/include/asm/bitops.h b/arch/sh/include/asm/bitops.h
index 450b5854d7c6..3b6c7b5b7ec9 100644
--- a/arch/sh/include/asm/bitops.h
+++ b/arch/sh/include/asm/bitops.h
@@ -58,15 +58,16 @@ static inline unsigned long __ffs(unsigned long word)
 	return result;
 }
 
-#include <asm-generic/bitops/find.h>
 #include <asm-generic/bitops/ffs.h>
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/lock.h>
 #include <asm-generic/bitops/sched.h>
-#include <asm-generic/bitops/le.h>
 #include <asm-generic/bitops/ext2-atomic.h>
 #include <asm-generic/bitops/fls.h>
 #include <asm-generic/bitops/__fls.h>
 #include <asm-generic/bitops/fls64.h>
 
+#include <asm-generic/bitops/le.h>
+#include <asm-generic/bitops/find.h>
+
 #endif /* __ASM_SH_BITOPS_H */
-- 
2.25.1


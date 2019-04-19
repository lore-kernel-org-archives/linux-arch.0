Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from condef-09.nifty.com ([202.248.20.74]:53141 "EHLO
        condef-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfDSSV5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Apr 2019 14:21:57 -0400
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 07/11] ARM: mark setup_machine_tags() stub as __init __noreturn
Date: Fri, 19 Apr 2019 18:47:50 +0900
Message-ID: <20190419094754.24667-8-yamada.masahiro@socionext.com>
In-Reply-To: <20190419094754.24667-1-yamada.masahiro@socionext.com>
References: <20190419094754.24667-1-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@c-s.fr>, Masahiro Yamada <yamada.masahiro@socionext.com>
Message-ID: <20190419094750.HPZcTn8vL67i7ZUbl6SagDDhK-P86l4T9x0uCxVoAZA@z>

This prepares to move CONFIG_OPTIMIZE_INLINING from x86 to a common
place. We need to eliminate potential issues beforehand.

If it is enabled for arm, Clang build results in the following modpost
warning:

WARNING: vmlinux.o(.text+0x1124): Section mismatch in reference from the function setup_machine_tags() to the function .init.text:early_print()
The function setup_machine_tags() references
the function __init early_print().
This is often because setup_machine_tags lacks a __init
annotation or the annotation of early_print is wrong.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - new patch

 arch/arm/kernel/atags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/atags.h b/arch/arm/kernel/atags.h
index 201100226301..067e12edc341 100644
--- a/arch/arm/kernel/atags.h
+++ b/arch/arm/kernel/atags.h
@@ -5,7 +5,7 @@ void convert_to_tag_list(struct tag *tags);
 const struct machine_desc *setup_machine_tags(phys_addr_t __atags_pointer,
 	unsigned int machine_nr);
 #else
-static inline const struct machine_desc *
+static inline const struct machine_desc * __init __noreturn
 setup_machine_tags(phys_addr_t __atags_pointer, unsigned int machine_nr)
 {
 	early_print("no ATAGS support: can't continue\n");
-- 
2.17.1

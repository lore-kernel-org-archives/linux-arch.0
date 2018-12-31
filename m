Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbeLaPf0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 Dec 2018 10:35:26 -0500
From: guoren@kernel.org
Subject: [PATCH 14/14] csky: Add EM_CSKY_OLD 39
Date: Mon, 31 Dec 2018 23:33:04 +0800
Message-ID: <1546270384-4590-12-git-send-email-guoren@kernel.org>
In-Reply-To: <1546270384-4590-1-git-send-email-guoren@kernel.org>
References: <1546270384-4590-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: guoren@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com, oleg@redhat.com, linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20181231153304.HUmXlG6cfnTdXTE-EHqVv9Fgo75VNRMb1-momHdZYtU@z>

From: Guo Ren <ren_guo@c-sky.com>

C-SKY historically used 39, the same value as MCORE, from which the
architecture was derived.

C-SKY binutils support both EM_CSKY and EM_CSKY_OLD, confirmed by
binutils:include/elf/common.h

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/elf.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/csky/include/asm/elf.h b/arch/csky/include/asm/elf.h
index d6dbc00..e1ec558 100644
--- a/arch/csky/include/asm/elf.h
+++ b/arch/csky/include/asm/elf.h
@@ -8,6 +8,7 @@
 #include <abi/regdef.h>
 
 #define ELF_ARCH EM_CSKY
+#define EM_CSKY_OLD 39
 
 /* CSKY Relocations */
 #define R_CSKY_NONE               0
@@ -43,7 +44,8 @@ typedef elf_greg_t elf_gregset_t[ELF_NGREG];
 /*
  * This is used to ensure we don't load something for the wrong architecture.
  */
-#define elf_check_arch(x) ((x)->e_machine == ELF_ARCH)
+#define elf_check_arch(x) (((x)->e_machine == ELF_ARCH) || \
+			   ((x)->e_machine == EM_CSKY_OLD))
 
 /*
  * These are used to set parameters in the core dumps.
-- 
2.7.4

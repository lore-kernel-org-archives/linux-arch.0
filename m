Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43461 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406257AbfHBTlk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Aug 2019 15:41:40 -0400
Received: by mail-qk1-f195.google.com with SMTP id m14so30011018qka.10
        for <linux-arch@vger.kernel.org>; Fri, 02 Aug 2019 12:41:39 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
Subject: [PATCH] asm-generic: fix variable 'p4d' set but not used
Date: Fri,  2 Aug 2019 15:41:22 -0400
Message-ID: <1564774882-22926-1-git-send-email-cai@lca.pw>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: arnd@arndb.de, kirill.shutemov@linux.intel.com, mhocko@suse.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Message-ID: <20190802194122.GDu9_QjtrzjuHwZDFHvDWrcfUyDIkLeuB7ptrfgiaUQ@z>

GCC throws a warning on an arm64 system since the commit 9849a5697d3d
("arch, mm: convert all architectures to use 5level-fixup.h"),

mm/kasan/init.c: In function 'kasan_free_p4d':
mm/kasan/init.c:344:9: warning: variable 'p4d' set but not used
[-Wunused-but-set-variable]
  p4d_t *p4d;
         ^~~

because p4d_none() in "5level-fixup.h" is compiled away while it is a
static inline function in "pgtable-nopud.h". However, if converted
p4d_none() to a static inline there, powerpc would be unhappy as it
reads those in assembler language in
"arch/powerpc/include/asm/book3s/64/pgtable.h",

./include/asm-generic/5level-fixup.h: Assembler messages:
./include/asm-generic/5level-fixup.h:20: Error: unrecognized opcode:
`static'
./include/asm-generic/5level-fixup.h:21: Error: junk at end of line,
first unrecognized character is `{'
./include/asm-generic/5level-fixup.h:22: Error: unrecognized opcode:
`return'
./include/asm-generic/5level-fixup.h:23: Error: junk at end of line,
first unrecognized character is `}'
./include/asm-generic/5level-fixup.h:25: Error: unrecognized opcode:
`static'
./include/asm-generic/5level-fixup.h:26: Error: junk at end of line,
first unrecognized character is `{'
./include/asm-generic/5level-fixup.h:27: Error: unrecognized opcode:
`return'
./include/asm-generic/5level-fixup.h:28: Error: junk at end of line,
first unrecognized character is `}'
./include/asm-generic/5level-fixup.h:30: Error: unrecognized opcode:
`static'
./include/asm-generic/5level-fixup.h:31: Error: junk at end of line,
first unrecognized character is `{'
./include/asm-generic/5level-fixup.h:32: Error: unrecognized opcode:
`return'
./include/asm-generic/5level-fixup.h:33: Error: junk at end of line,
first unrecognized character is `}'
make[2]: *** [scripts/Makefile.build:375:
arch/powerpc/kvm/book3s_hv_rmhandlers.o] Error 1

Fix it by reference the variable in the macro instead.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 include/asm-generic/5level-fixup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/5level-fixup.h b/include/asm-generic/5level-fixup.h
index bb6cb347018c..2c3e14c924b6 100644
--- a/include/asm-generic/5level-fixup.h
+++ b/include/asm-generic/5level-fixup.h
@@ -19,7 +19,7 @@
 
 #define p4d_alloc(mm, pgd, address)	(pgd)
 #define p4d_offset(pgd, start)		(pgd)
-#define p4d_none(p4d)			0
+#define p4d_none(p4d)			((void)p4d, 0)
 #define p4d_bad(p4d)			0
 #define p4d_present(p4d)		1
 #define p4d_ERROR(p4d)			do { } while (0)
-- 
1.8.3.1

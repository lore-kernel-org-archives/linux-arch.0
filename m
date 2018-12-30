From: Mathias Krause <minipli@googlemail.com>
Subject: [PATCH] kallsyms: lower alignment on ARM
Date: Sun, 30 Dec 2018 13:36:00 +0100
Message-ID: <1546173360-25573-1-git-send-email-minipli@googlemail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Mathias Krause <minipli@googlemail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

As mentioned in the info pages of gas, the '.align' pseudo op's
interpretation of the alignment value is architecture specific.
It might either be a byte value or taken to the power of two.

On ARM it's actually the latter which leads to unnecessary large
alignments of 16 bytes for 32 bit builds or 256 bytes for 64 bit
builds.

Fix this by switching to '.balign' instead which is consistent
across all architectures.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 scripts/kallsyms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 109a1af7e444..77cebad0474e 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -334,10 +334,10 @@ static void write_src(void)
 	printf("#include <asm/types.h>\n");
 	printf("#if BITS_PER_LONG == 64\n");
 	printf("#define PTR .quad\n");
-	printf("#define ALGN .align 8\n");
+	printf("#define ALGN .balign 8\n");
 	printf("#else\n");
 	printf("#define PTR .long\n");
-	printf("#define ALGN .align 4\n");
+	printf("#define ALGN .balign 4\n");
 	printf("#endif\n");
 
 	printf("\t.section .rodata, \"a\"\n");
-- 
2.19.2

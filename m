From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 4/5] x86/um: thin archives build fix
Date: Fri,  9 Jun 2017 15:24:16 +1000
Message-ID: <20170609052417.561-5-npiggin@gmail.com>
References: <20170609052417.561-1-npiggin@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34869 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbdFIFZH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jun 2017 01:25:07 -0400
In-Reply-To: <20170609052417.561-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net

The linker does not like vdso-syms.lds in input archive files.
Make it an extra-y instead.

Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

Arch maintainers please give an ack if we can take this through
the kbuild tree.

Thanks,
Nick

 arch/x86/um/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index d72dec406ccb..329406224330 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -53,7 +53,7 @@ CFLAGS_REMOVE_vdso-note.o = -pg -fprofile-arcs -ftest-coverage
 CFLAGS_REMOVE_um_vdso.o = -pg -fprofile-arcs -ftest-coverage
 
 targets += vdso-syms.lds
-obj-$(VDSO64-y)			+= vdso-syms.lds
+extra-$(VDSO64-y)			+= vdso-syms.lds
 
 #
 # Match symbols in the DSO that look like VDSO*; produce a file of constants.
-- 
2.11.0

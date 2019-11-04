Return-Path: <rppt@kernel.org>
From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v3 03/13] c6x: use pgtable-nopud instead of 4level-fixup
Date: Mon,  4 Nov 2019 08:56:17 +0200
Message-ID: <1572850587-20314-4-git-send-email-rppt@kernel.org>
In-Reply-To: <1572850587-20314-1-git-send-email-rppt@kernel.org>
References: <1572850587-20314-1-git-send-email-rppt@kernel.org>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Jeff Dike <jdike@addtoit.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Linus Torvalds <torvalds@linux-foundation.org>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Michal Simek <monstr@monstr.eu>, Peter Rosin <peda@axentia.se>, Richard Weinberger <richard@nod.at>, Rolf Eike Beer <eike-kernel@sf-tec.de>, Russell King <linux@armlinux.org.uk>, Sam Creasey <sammy@sammy.net>, Vincent Chen <deanbo422@gmail.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Mike Rapoport <rppt@kernel.org>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org, linux-um@lists.infradead.org, sparclinux@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191104065617.yA49OsrCgKe7Ljk_B4J7lw6dvwADM7_CUovXJBIl7xY@z>

From: Mike Rapoport <rppt@linux.ibm.com>

c6x is a nommu architecture and does not require fixup for upper layers of
the page tables because it is already handled by the generic nommu
implementation.

Replace usage of include/asm-generic/4level-fixup.h with
include/asm-generic/pgtable-nopud.h

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/c6x/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/c6x/include/asm/pgtable.h b/arch/c6x/include/asm/pgtable.h
index 0b6919c..197c473 100644
--- a/arch/c6x/include/asm/pgtable.h
+++ b/arch/c6x/include/asm/pgtable.h
@@ -8,7 +8,7 @@
 #ifndef _ASM_C6X_PGTABLE_H
 #define _ASM_C6X_PGTABLE_H
 
-#include <asm-generic/4level-fixup.h>
+#include <asm-generic/pgtable-nopud.h>
 
 #include <asm/setup.h>
 #include <asm/page.h>
-- 
2.7.4

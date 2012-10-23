From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH] asm-generic/io.h: remove asm/cacheflush.h include
Date: Tue, 23 Oct 2012 10:21:57 +0100
Message-ID: <1350984117-17369-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bounces@lists.openrisc.net>
List-Unsubscribe: <http://lists.openrisc.net/options/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=unsubscribe>
List-Archive: <http://lists.openrisc.net/pipermail/linux>
List-Post: <mailto:linux@lists.openrisc.net>
List-Help: <mailto:linux-request@lists.openrisc.net?subject=help>
List-Subscribe: <http://lists.openrisc.net/listinfo/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=subscribe>
Sender: linux-bounces@lists.openrisc.net
Errors-To: linux-bounces@lists.openrisc.net
To: Arnd Bergmann <arnd@arndb.de>, Jonas Bonn <jonas@southpole.se>
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org, James Hogan <james.hogan@imgtec.com>, Mike Frysinger <vapier@gentoo.org>, Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, linux@lists.openrisc.net, Guan Xuetao <gxt@mprc.pku.edu.cn>, uclinux-dist-devel@blackfin.uclinux.org, Chen Liqin <liqin.chen@sunplusct.com>, Lennox Wu <lennox.wu@gmail.com>
List-Id: linux-arch.vger.kernel.org

Including <asm/cacheflush.h> from <asm-generic/io.h> prevents
cacheflush.h being able to use I/O functions like readl and writel due
to circular include dependencies. It doesn't appear as if anything from
cacheflush.h is actually used by the generic io.h, so remove the
include.

I've compile tested a defconfig compilation of blackfin, openrisc (which
needed <asm/pgtable.h> including from it's <asm/io.h> to get the PAGE_*
definitions), and xtensa.

Other architectures which use asm-generic/io.h are score and unicore32,
and looking at their io.h I don't see any obvious problems.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Mike Frysinger <vapier@gentoo.org>
Cc: Chen Liqin <liqin.chen@sunplusct.com>
Cc: Lennox Wu <lennox.wu@gmail.com>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
---
Any compile testing of score and unicore32 anybody could provide would
be great.

 arch/openrisc/include/asm/io.h |    1 +
 include/asm-generic/io.h       |    1 -
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/openrisc/include/asm/io.h b/arch/openrisc/include/asm/io.h
index 07f5299..7c69139 100644
--- a/arch/openrisc/include/asm/io.h
+++ b/arch/openrisc/include/asm/io.h
@@ -30,6 +30,7 @@
 #define PIO_MASK		0
 
 #include <asm-generic/io.h>
+#include <asm/pgtable.h>
 
 extern void __iomem *__ioremap(phys_addr_t offset, unsigned long size,
 				pgprot_t prot);
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 448303b..616eea5 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -12,7 +12,6 @@
 #define __ASM_GENERIC_IO_H
 
 #include <asm/page.h> /* I/O is all done through memory accesses */
-#include <asm/cacheflush.h>
 #include <linux/types.h>
 
 #ifdef CONFIG_GENERIC_IOMAP
-- 
1.7.7.6

From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH 06/24] microblaze/uapi: Use Kbuild logic to include <asm-generic/types.h>
Date: Mon, 25 Nov 2013 09:55:16 +0100
Message-ID: <1385369734-24893-7-git-send-email-geert@linux-m68k.org>
References: <1385369734-24893-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <microblaze-linux-bounces-FR6EJeJVuqfA6Z3fQjNZrN9u6TNh0Fb7@public.gmane.org>
In-Reply-To: <1385369734-24893-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
List-Unsubscribe: <https://lists.eait.uq.edu.au/mailman/options/microblaze-linux>,
 <mailto:microblaze-linux-request-FR6EJeJVuqfA6Z3fQjNZrN9u6TNh0Fb7@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.eait.uq.edu.au/pipermail/microblaze-linux>
List-Post: <mailto:microblaze-linux-FR6EJeJVuqfA6Z3fQjNZrN9u6TNh0Fb7@public.gmane.org>
List-Help: <mailto:microblaze-linux-request-FR6EJeJVuqfA6Z3fQjNZrN9u6TNh0Fb7@public.gmane.org?subject=help>
List-Subscribe: <https://lists.eait.uq.edu.au/mailman/listinfo/microblaze-linux>,
 <mailto:microblaze-linux-request-FR6EJeJVuqfA6Z3fQjNZrN9u6TNh0Fb7@public.gmane.org?subject=subscribe>
Errors-To: microblaze-linux-bounces-FR6EJeJVuqfA6Z3fQjNZrN9u6TNh0Fb7@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
Cc: microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org
---
 arch/microblaze/include/uapi/asm/Kbuild  |    3 ++-
 arch/microblaze/include/uapi/asm/types.h |    1 -
 2 files changed, 2 insertions(+), 2 deletions(-)
 delete mode 100644 arch/microblaze/include/uapi/asm/types.h

diff --git a/arch/microblaze/include/uapi/asm/Kbuild b/arch/microblaze/include/uapi/asm/Kbuild
index 6d7d7f4aaae8..1aac99f87df1 100644
--- a/arch/microblaze/include/uapi/asm/Kbuild
+++ b/arch/microblaze/include/uapi/asm/Kbuild
@@ -1,6 +1,8 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
+generic-y += types.h
+
 header-y += auxvec.h
 header-y += bitsperlong.h
 header-y += byteorder.h
@@ -31,5 +33,4 @@ header-y += statfs.h
 header-y += swab.h
 header-y += termbits.h
 header-y += termios.h
-header-y += types.h
 header-y += unistd.h
diff --git a/arch/microblaze/include/uapi/asm/types.h b/arch/microblaze/include/uapi/asm/types.h
deleted file mode 100644
index b9e79bc580dd..000000000000
--- a/arch/microblaze/include/uapi/asm/types.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/types.h>
-- 
1.7.9.5

_______________________________________________
microblaze-linux mailing list
microblaze-linux-FR6EJeJVuqfA6Z3fQjNZrN9u6TNh0Fb7@public.gmane.org
https://lists.eait.uq.edu.au/mailman/listinfo/microblaze-linux

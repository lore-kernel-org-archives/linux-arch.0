From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH 09/17] microblaze: Remove duplicate declarations of _stext[] and _etext[]
Date: Tue, 12 Nov 2013 20:42:19 +0100
Message-ID: <1384285347-13506-10-git-send-email-geert@linux-m68k.org>
References: <1384285347-13506-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <microblaze-linux-bounces-FR6EJeJVuqfA6Z3fQjNZrN9u6TNh0Fb7@public.gmane.org>
In-Reply-To: <1384285347-13506-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
List-Unsubscribe: <https://lists.eait.uq.edu.au/mailman/options/microblaze-linux>,
 <mailto:microblaze-linux-request-FR6EJeJVuqfA6Z3fQjNZrN9u6TNh0Fb7@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.eait.uq.edu.au/pipermail/microblaze-linux>
List-Post: <mailto:microblaze-linux-FR6EJeJVuqfA6Z3fQjNZrN9u6TNh0Fb7@public.gmane.org>
List-Help: <mailto:microblaze-linux-request-FR6EJeJVuqfA6Z3fQjNZrN9u6TNh0Fb7@public.gmane.org?subject=help>
List-Subscribe: <https://lists.eait.uq.edu.au/mailman/listinfo/microblaze-linux>,
 <mailto:microblaze-linux-request-FR6EJeJVuqfA6Z3fQjNZrN9u6TNh0Fb7@public.gmane.org?subject=subscribe>
Errors-To: microblaze-linux-bounces-FR6EJeJVuqfA6Z3fQjNZrN9u6TNh0Fb7@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

They're already provided by <asm/sections.h>.

Signed-off-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
Cc: microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org
---
 arch/microblaze/include/asm/sections.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/microblaze/include/asm/sections.h b/arch/microblaze/include/asm/sections.h
index c07ed5d2a820..1b281d3ea734 100644
--- a/arch/microblaze/include/asm/sections.h
+++ b/arch/microblaze/include/asm/sections.h
@@ -16,7 +16,6 @@
 # ifndef __ASSEMBLY__
 extern char _ssbss[], _esbss[];
 extern unsigned long __ivt_start[], __ivt_end[];
-extern char _etext[], _stext[];
 
 extern u32 _fdt_start[], _fdt_end[];
 
-- 
1.7.9.5

_______________________________________________
microblaze-linux mailing list
microblaze-linux-FR6EJeJVuqfA6Z3fQjNZrN9u6TNh0Fb7@public.gmane.org
https://lists.eait.uq.edu.au/mailman/listinfo/microblaze-linux

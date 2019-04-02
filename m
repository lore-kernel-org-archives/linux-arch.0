Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:41472 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729872AbfDBJIl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Apr 2019 05:08:41 -0400
Message-ID: <5ad9ed13155f55e1715274561354aa7ab57973fc.1554195798.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1554195798.git.christophe.leroy@c-s.fr>
References: <cover.1554195798.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 4/9] powerpc/prom_init: get rid of PROM_SCRATCH_SIZE
Date: Tue,  2 Apr 2019 09:08:38 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, danielwa@cisco.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
Message-ID: <20190402090838.GvpI7ymgkrYmarzK-I4K_gsUcTBovpKF_sy-gAUh_P8@z>

PROM_SCRATCH_SIZE is same as sizeof(prom_scratch)

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/prom_init.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index a6cd52240c58..d4889ba04ddd 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -154,10 +154,8 @@ static struct prom_t __prombss prom;
 
 static unsigned long __prombss prom_entry;
 
-#define PROM_SCRATCH_SIZE 256
-
 static char __prombss of_stdout_device[256];
-static char __prombss prom_scratch[PROM_SCRATCH_SIZE];
+static char __prombss prom_scratch[256];
 
 static unsigned long __prombss dt_header_start;
 static unsigned long __prombss dt_struct_start, dt_struct_end;
@@ -1486,8 +1484,8 @@ static void __init prom_init_mem(void)
 		endp = p + (plen / sizeof(cell_t));
 
 #ifdef DEBUG_PROM
-		memset(path, 0, PROM_SCRATCH_SIZE);
-		call_prom("package-to-path", 3, 1, node, path, PROM_SCRATCH_SIZE-1);
+		memset(path, 0, sizeof(prom_scratch));
+		call_prom("package-to-path", 3, 1, node, path, sizeof(prom_scratch) - 1);
 		prom_debug("  node %s :\n", path);
 #endif /* DEBUG_PROM */
 
@@ -1795,10 +1793,10 @@ static void __init prom_initialize_tce_table(void)
 			local_alloc_bottom = base;
 
 		/* It seems OF doesn't null-terminate the path :-( */
-		memset(path, 0, PROM_SCRATCH_SIZE);
+		memset(path, 0, sizeof(prom_scratch));
 		/* Call OF to setup the TCE hardware */
 		if (call_prom("package-to-path", 3, 1, node,
-			      path, PROM_SCRATCH_SIZE-1) == PROM_ERROR) {
+			      path, sizeof(prom_scratch) - 1) == PROM_ERROR) {
 			prom_printf("package-to-path failed\n");
 		}
 
@@ -2159,14 +2157,14 @@ static void __init prom_check_displays(void)
 
 		/* It seems OF doesn't null-terminate the path :-( */
 		path = prom_scratch;
-		memset(path, 0, PROM_SCRATCH_SIZE);
+		memset(path, 0, sizeof(prom_scratch));
 
 		/*
 		 * leave some room at the end of the path for appending extra
 		 * arguments
 		 */
 		if (call_prom("package-to-path", 3, 1, node, path,
-			      PROM_SCRATCH_SIZE-10) == PROM_ERROR)
+			      sizeof(prom_scratch) - 10) == PROM_ERROR)
 			continue;
 		prom_printf("found display   : %s, opening... ", path);
 		
@@ -2362,8 +2360,8 @@ static void __init scan_dt_build_struct(phandle node, unsigned long *mem_start,
 
 	/* get it again for debugging */
 	path = prom_scratch;
-	memset(path, 0, PROM_SCRATCH_SIZE);
-	call_prom("package-to-path", 3, 1, node, path, PROM_SCRATCH_SIZE-1);
+	memset(path, 0, sizeof(prom_scratch));
+	call_prom("package-to-path", 3, 1, node, path, sizeof(prom_scratch) - 1);
 
 	/* get and store all properties */
 	prev_name = "";
-- 
2.13.3

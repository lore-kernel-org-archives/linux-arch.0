From: Toshi Kani <toshi.kani-ZPxbGqLxI0U@public.gmane.org>
Subject: [PATCH v3 14/17] x86, nvdimm,
 kexec: Use walk_iomem_res_desc() for iomem search
Date: Tue,  5 Jan 2016 11:54:38 -0700
Message-ID: <1452020081-26534-14-git-send-email-toshi.kani@hpe.com>
References: <1452020081-26534-1-git-send-email-toshi.kani@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1452020081-26534-1-git-send-email-toshi.kani-ZPxbGqLxI0U@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "kexec" <kexec-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Toshi Kani <toshi.kani-ZPxbGqLxI0U@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, Minfei Huang <mhuang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

Change the callers of walk_iomem_res() with the following names
to use walk_iomem_res(), instead.

 "ACPI Tables"
 "ACPI Non-volatile Storage"
 "Persistent Memory (legacy)"
 "Crash kernel"

Note, the caller of walk_iomem_res() with "GART" will be removed
in a later patch.

Cc: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Minfei Huang <mhuang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Cc: kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Signed-off-by: Toshi Kani <toshi.kani-ZPxbGqLxI0U@public.gmane.org>
---
 arch/x86/kernel/crash.c |    4 ++--
 arch/x86/kernel/pmem.c  |    4 ++--
 drivers/nvdimm/e820.c   |    2 +-
 kernel/kexec_file.c     |    8 ++++----
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 2c1910f..082373b 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -588,12 +588,12 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 	/* Add ACPI tables */
 	cmd.type = E820_ACPI;
 	flags = IORESOURCE_MEM | IORESOURCE_BUSY;
-	walk_iomem_res("ACPI Tables", flags, 0, -1, &cmd,
+	walk_iomem_res_desc(IORES_DESC_ACPI_TABLES, flags, 0, -1, &cmd,
 		       memmap_entry_callback);
 
 	/* Add ACPI Non-volatile Storage */
 	cmd.type = E820_NVS;
-	walk_iomem_res("ACPI Non-volatile Storage", flags, 0, -1, &cmd,
+	walk_iomem_res_desc(IORES_DESC_ACPI_NV_STORAGE, flags, 0, -1, &cmd,
 			memmap_entry_callback);
 
 	/* Add crashk_low_res region */
diff --git a/arch/x86/kernel/pmem.c b/arch/x86/kernel/pmem.c
index 14415af..92f7014 100644
--- a/arch/x86/kernel/pmem.c
+++ b/arch/x86/kernel/pmem.c
@@ -13,11 +13,11 @@ static int found(u64 start, u64 end, void *data)
 
 static __init int register_e820_pmem(void)
 {
-	char *pmem = "Persistent Memory (legacy)";
 	struct platform_device *pdev;
 	int rc;
 
-	rc = walk_iomem_res(pmem, IORESOURCE_MEM, 0, -1, NULL, found);
+	rc = walk_iomem_res_desc(IORES_DESC_PERSISTENT_MEMORY_LEGACY,
+				 IORESOURCE_MEM, 0, -1, NULL, found);
 	if (rc <= 0)
 		return 0;
 
diff --git a/drivers/nvdimm/e820.c b/drivers/nvdimm/e820.c
index b0045a5..95825b3 100644
--- a/drivers/nvdimm/e820.c
+++ b/drivers/nvdimm/e820.c
@@ -55,7 +55,7 @@ static int e820_pmem_probe(struct platform_device *pdev)
 	for (p = iomem_resource.child; p ; p = p->sibling) {
 		struct nd_region_desc ndr_desc;
 
-		if (strncmp(p->name, "Persistent Memory (legacy)", 26) != 0)
+		if (p->desc != IORES_DESC_PERSISTENT_MEMORY_LEGACY)
 			continue;
 
 		memset(&ndr_desc, 0, sizeof(ndr_desc));
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index c245085..6e31cea 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -522,10 +522,10 @@ int kexec_add_buffer(struct kimage *image, char *buffer, unsigned long bufsz,
 
 	/* Walk the RAM ranges and allocate a suitable range for the buffer */
 	if (image->type == KEXEC_TYPE_CRASH)
-		ret = walk_iomem_res("Crash kernel",
-				     IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
-				     crashk_res.start, crashk_res.end, kbuf,
-				     locate_mem_hole_callback);
+		ret = walk_iomem_res_desc(crashk_res.desc,
+				IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
+				crashk_res.start, crashk_res.end, kbuf,
+				locate_mem_hole_callback);
 	else
 		ret = walk_system_ram_res(0, -1, kbuf,
 					  locate_mem_hole_callback);

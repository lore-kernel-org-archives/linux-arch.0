From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 09/10] arch: introduce memremap()
Date: Sun, 19 Jul 2015 20:18:23 -0400
Message-ID: <20150720001822.30857.65670.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20150720001614.30857.89063.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150720001614.30857.89063.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com
Cc: linux-arch@vger.kernel.org, tony.luck@intel.com, linux@arm.linux.org.uk, arnd@arndb.de, benh@kernel.crashing.org, mcgrof@suse.com, x86@kernel.org, linux-kernel@vger.kernel.org, ralf@linux-mips.org, Andy Shevchenko <andy.shevchenko@gmail.com>, geert@linux-m68k.org, toshi.kani@hp.com, ross.zwisler@linux.intel.com, hch@lst.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Existing users of ioremap_cache() are mapping memory that is known in
advance to not have i/o side effects.  These users are forced to cast
away the __iomem annotation, or otherwise neglect to fix the sparse
errors thrown when dereferencing pointers to this memory.  Provide
memremap() as a non __iomem annotated ioremap_*() in the case when
ioremap is otherwise a pointer to memory.

The ARCH_HAS_MEMREMAP kconfig symbol is introduced for archs to assert
that it is safe to recast / reuse the return value from ioremap as a
normal pointer to memory.  In other words, archs that mandate specific
accessors for __iomem are not memremap() capable and drivers that care,
like pmem, can add a dependency to disable themselves on these archs.

Note, that memremap is a break from the ioremap implementation pattern
of adding a new memremap_<type>() for each mapping type.  Instead,
the implementation defines flags that are passed to the central
memremap() implementation.

Outside of ioremap() and ioremap_nocache(), the expectation is that most
calls to ioremap_<type>() are seeking memory-like semantics (e.g.
speculative reads, and prefetching permitted).  These callsites can be
moved to memremap() over time.

Cc: Arnd Bergmann <arnd@arndb.de>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/arm/Kconfig                     |    1 +
 arch/arm64/Kconfig                   |    1 +
 arch/arm64/kernel/efi.c              |    7 ++---
 arch/arm64/kernel/smp_spin_table.c   |   17 +++++------
 arch/frv/Kconfig                     |    1 +
 arch/m68k/Kconfig                    |    1 +
 arch/metag/Kconfig                   |    1 +
 arch/mips/Kconfig                    |    1 +
 arch/powerpc/Kconfig                 |    1 +
 arch/x86/Kconfig                     |    1 +
 arch/x86/kernel/crash_dump_64.c      |    6 ++--
 arch/x86/kernel/kdebugfs.c           |    8 +++--
 arch/x86/kernel/ksysfs.c             |   28 +++++++++----------
 arch/x86/mm/ioremap.c                |   10 +++----
 arch/xtensa/Kconfig                  |    1 +
 drivers/acpi/apei/einj.c             |    9 +++---
 drivers/acpi/apei/erst.c             |    6 ++--
 drivers/firmware/google/memconsole.c |    5 ++-
 include/linux/device.h               |    5 +++
 include/linux/io.h                   |   11 +++++++
 kernel/resource.c                    |   51 +++++++++++++++++++++++++++++++++-
 lib/Kconfig                          |    5 +++
 22 files changed, 126 insertions(+), 51 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1c5021002fe4..1d64aae0a226 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -3,6 +3,7 @@ config ARM
 	default y
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_ELF_RANDOMIZE
+	select ARCH_HAS_MEMREMAP
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select ARCH_HAS_GCOV_PROFILE_ALL
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 318175f62c24..305def28385f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -6,6 +6,7 @@ config ARM64
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_MEMREMAP
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_USE_CMPXCHG_LOCKREF
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 9d4aa18f2a82..ed363a0202b9 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -290,8 +290,7 @@ static int __init arm64_enable_runtime_services(void)
 	pr_info("Remapping and enabling EFI services.\n");
 
 	mapsize = memmap.map_end - memmap.map;
-	memmap.map = (__force void *)ioremap_cache((phys_addr_t)memmap.phys_map,
-						   mapsize);
+	memmap.map = memremap(memmap.phys_map, mapsize, MEMREMAP_CACHE);
 	if (!memmap.map) {
 		pr_err("Failed to remap EFI memory map\n");
 		return -1;
@@ -299,8 +298,8 @@ static int __init arm64_enable_runtime_services(void)
 	memmap.map_end = memmap.map + mapsize;
 	efi.memmap = &memmap;
 
-	efi.systab = (__force void *)ioremap_cache(efi_system_table,
-						   sizeof(efi_system_table_t));
+	efi.systab = memremap(efi_system_table, sizeof(efi_system_table_t),
+			MEMREMAP_CACHE);
 	if (!efi.systab) {
 		pr_err("Failed to remap EFI System Table\n");
 		return -1;
diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/smp_spin_table.c
index aef3605a8c47..b9caf6cd44e6 100644
--- a/arch/arm64/kernel/smp_spin_table.c
+++ b/arch/arm64/kernel/smp_spin_table.c
@@ -73,19 +73,19 @@ static int smp_spin_table_cpu_init(unsigned int cpu)
 
 static int smp_spin_table_cpu_prepare(unsigned int cpu)
 {
-	__le64 __iomem *release_addr;
+	__le64 *release_addr;
 
 	if (!cpu_release_addr[cpu])
 		return -ENODEV;
 
 	/*
 	 * The cpu-release-addr may or may not be inside the linear mapping.
-	 * As ioremap_cache will either give us a new mapping or reuse the
-	 * existing linear mapping, we can use it to cover both cases. In
-	 * either case the memory will be MT_NORMAL.
+	 * As memremap will either give us a new mapping or reuse the existing
+	 * linear mapping, we can use it to cover both cases. In either case
+	 * the memory will be MT_NORMAL.
 	 */
-	release_addr = ioremap_cache(cpu_release_addr[cpu],
-				     sizeof(*release_addr));
+	release_addr = memremap(cpu_release_addr[cpu], sizeof(*release_addr),
+			MEMREMAP_CACHE);
 	if (!release_addr)
 		return -ENOMEM;
 
@@ -97,15 +97,14 @@ static int smp_spin_table_cpu_prepare(unsigned int cpu)
 	 * the boot protocol.
 	 */
 	writeq_relaxed(__pa(secondary_holding_pen), release_addr);
-	__flush_dcache_area((__force void *)release_addr,
-			    sizeof(*release_addr));
+	__flush_dcache_area(release_addr, sizeof(*release_addr));
 
 	/*
 	 * Send an event to wake up the secondary CPU.
 	 */
 	sev();
 
-	iounmap(release_addr);
+	memunmap(release_addr);
 
 	return 0;
 }
diff --git a/arch/frv/Kconfig b/arch/frv/Kconfig
index 34aa19352dc1..2373bf183527 100644
--- a/arch/frv/Kconfig
+++ b/arch/frv/Kconfig
@@ -14,6 +14,7 @@ config FRV
 	select OLD_SIGSUSPEND3
 	select OLD_SIGACTION
 	select HAVE_DEBUG_STACKOVERFLOW
+	select ARCH_HAS_MEMREMAP
 
 config ZONE_DMA
 	bool
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 2dd8f63bfbbb..831b1be8c43d 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -23,6 +23,7 @@ config M68K
 	select MODULES_USE_ELF_RELA
 	select OLD_SIGSUSPEND3
 	select OLD_SIGACTION
+	select ARCH_HAS_MEMREMAP
 
 config RWSEM_GENERIC_SPINLOCK
 	bool
diff --git a/arch/metag/Kconfig b/arch/metag/Kconfig
index 0b389a81c43a..5669fe3eb807 100644
--- a/arch/metag/Kconfig
+++ b/arch/metag/Kconfig
@@ -24,6 +24,7 @@ config METAG
 	select HAVE_PERF_EVENTS
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UNDERSCORE_SYMBOL_PREFIX
+	select ARCH_HAS_MEMREMAP
 	select IRQ_DOMAIN
 	select MODULES_USE_ELF_RELA
 	select OF
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index aab7e46cadd5..ac9da90931b9 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -59,6 +59,7 @@ config MIPS
 	select SYSCTL_EXCEPTION_TRACE
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select HAVE_IRQ_TIME_ACCOUNTING
+	select ARCH_HAS_MEMREMAP
 
 menu "Machine selection"
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 5ef27113b898..50889c7b5c81 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -89,6 +89,7 @@ config PPC
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select BINFMT_ELF
 	select ARCH_HAS_ELF_RANDOMIZE
+	select ARCH_HAS_MEMREMAP
 	select OF
 	select OF_EARLY_FLATTREE
 	select OF_RESERVED_MEM
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3dbb7e7909ca..80eb19c8b62d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -27,6 +27,7 @@ config X86
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_MEMREMAP
 	select ARCH_HAS_PMEM_API
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
diff --git a/arch/x86/kernel/crash_dump_64.c b/arch/x86/kernel/crash_dump_64.c
index afa64adb75ee..b87ca059e5fc 100644
--- a/arch/x86/kernel/crash_dump_64.c
+++ b/arch/x86/kernel/crash_dump_64.c
@@ -31,19 +31,19 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 	if (!csize)
 		return 0;
 
-	vaddr = ioremap_cache(pfn << PAGE_SHIFT, PAGE_SIZE);
+	vaddr = memremap(pfn << PAGE_SHIFT, PAGE_SIZE, MEMREMAP_CACHE);
 	if (!vaddr)
 		return -ENOMEM;
 
 	if (userbuf) {
 		if (copy_to_user(buf, vaddr + offset, csize)) {
-			iounmap(vaddr);
+			memunmap(vaddr);
 			return -EFAULT;
 		}
 	} else
 		memcpy(buf, vaddr + offset, csize);
 
 	set_iounmap_nonlazy();
-	iounmap(vaddr);
+	memunmap(vaddr);
 	return csize;
 }
diff --git a/arch/x86/kernel/kdebugfs.c b/arch/x86/kernel/kdebugfs.c
index dc1404bf8e4b..a2248482c14b 100644
--- a/arch/x86/kernel/kdebugfs.c
+++ b/arch/x86/kernel/kdebugfs.c
@@ -49,7 +49,7 @@ static ssize_t setup_data_read(struct file *file, char __user *user_buf,
 	pa = node->paddr + sizeof(struct setup_data) + pos;
 	pg = pfn_to_page((pa + count - 1) >> PAGE_SHIFT);
 	if (PageHighMem(pg)) {
-		p = ioremap_cache(pa, count);
+		p = memremap(pa, count, MEMREMAP_CACHE);
 		if (!p)
 			return -ENXIO;
 	} else
@@ -58,7 +58,7 @@ static ssize_t setup_data_read(struct file *file, char __user *user_buf,
 	remain = copy_to_user(user_buf, p, count);
 
 	if (PageHighMem(pg))
-		iounmap(p);
+		memunmap(p);
 
 	if (remain)
 		return -EFAULT;
@@ -128,7 +128,7 @@ static int __init create_setup_data_nodes(struct dentry *parent)
 
 		pg = pfn_to_page((pa_data+sizeof(*data)-1) >> PAGE_SHIFT);
 		if (PageHighMem(pg)) {
-			data = ioremap_cache(pa_data, sizeof(*data));
+			data = memremap(pa_data, sizeof(*data), MEMREMAP_CACHE);
 			if (!data) {
 				kfree(node);
 				error = -ENXIO;
@@ -144,7 +144,7 @@ static int __init create_setup_data_nodes(struct dentry *parent)
 		pa_data = data->next;
 
 		if (PageHighMem(pg))
-			iounmap(data);
+			memunmap(data);
 		if (error)
 			goto err_dir;
 		no++;
diff --git a/arch/x86/kernel/ksysfs.c b/arch/x86/kernel/ksysfs.c
index c2bedaea11f7..d2670bb75a08 100644
--- a/arch/x86/kernel/ksysfs.c
+++ b/arch/x86/kernel/ksysfs.c
@@ -16,8 +16,8 @@
 #include <linux/stat.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
+#include <linux/io.h>
 
-#include <asm/io.h>
 #include <asm/setup.h>
 
 static ssize_t version_show(struct kobject *kobj,
@@ -79,12 +79,12 @@ static int get_setup_data_paddr(int nr, u64 *paddr)
 			*paddr = pa_data;
 			return 0;
 		}
-		data = ioremap_cache(pa_data, sizeof(*data));
+		data = memremap(pa_data, sizeof(*data), MEMREMAP_CACHE);
 		if (!data)
 			return -ENOMEM;
 
 		pa_data = data->next;
-		iounmap(data);
+		memunmap(data);
 		i++;
 	}
 	return -EINVAL;
@@ -97,17 +97,17 @@ static int __init get_setup_data_size(int nr, size_t *size)
 	u64 pa_data = boot_params.hdr.setup_data;
 
 	while (pa_data) {
-		data = ioremap_cache(pa_data, sizeof(*data));
+		data = memremap(pa_data, sizeof(*data), MEMREMAP_CACHE);
 		if (!data)
 			return -ENOMEM;
 		if (nr == i) {
 			*size = data->len;
-			iounmap(data);
+			memunmap(data);
 			return 0;
 		}
 
 		pa_data = data->next;
-		iounmap(data);
+		memunmap(data);
 		i++;
 	}
 	return -EINVAL;
@@ -127,12 +127,12 @@ static ssize_t type_show(struct kobject *kobj,
 	ret = get_setup_data_paddr(nr, &paddr);
 	if (ret)
 		return ret;
-	data = ioremap_cache(paddr, sizeof(*data));
+	data = memremap(paddr, sizeof(*data), MEMREMAP_CACHE);
 	if (!data)
 		return -ENOMEM;
 
 	ret = sprintf(buf, "0x%x\n", data->type);
-	iounmap(data);
+	memunmap(data);
 	return ret;
 }
 
@@ -154,7 +154,7 @@ static ssize_t setup_data_data_read(struct file *fp,
 	ret = get_setup_data_paddr(nr, &paddr);
 	if (ret)
 		return ret;
-	data = ioremap_cache(paddr, sizeof(*data));
+	data = memremap(paddr, sizeof(*data), MEMREMAP_CACHE);
 	if (!data)
 		return -ENOMEM;
 
@@ -170,15 +170,15 @@ static ssize_t setup_data_data_read(struct file *fp,
 		goto out;
 
 	ret = count;
-	p = ioremap_cache(paddr + sizeof(*data), data->len);
+	p = memremap(paddr + sizeof(*data), data->len, MEMREMAP_CACHE);
 	if (!p) {
 		ret = -ENOMEM;
 		goto out;
 	}
 	memcpy(buf, p + off, count);
-	iounmap(p);
+	memunmap(p);
 out:
-	iounmap(data);
+	memunmap(data);
 	return ret;
 }
 
@@ -250,13 +250,13 @@ static int __init get_setup_data_total_num(u64 pa_data, int *nr)
 	*nr = 0;
 	while (pa_data) {
 		*nr += 1;
-		data = ioremap_cache(pa_data, sizeof(*data));
+		data = memremap(pa_data, sizeof(*data), MEMREMAP_CACHE);
 		if (!data) {
 			ret = -ENOMEM;
 			goto out;
 		}
 		pa_data = data->next;
-		iounmap(data);
+		memunmap(data);
 	}
 
 out:
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index ccf5c867b2eb..4920f735f551 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -401,12 +401,10 @@ void *xlate_dev_mem_ptr(phys_addr_t phys)
 	if (page_is_ram(start >> PAGE_SHIFT))
 		return __va(phys);
 
-	vaddr = ioremap_cache(start, PAGE_SIZE);
-	/* Only add the offset on success and return NULL if the ioremap() failed: */
+	vaddr = memremap(start, PAGE_SIZE, MEMREMAP_CACHE);
 	if (vaddr)
-		vaddr += offset;
-
-	return vaddr;
+		return vaddr + offset;
+	return NULL;
 }
 
 void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr)
@@ -414,7 +412,7 @@ void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr)
 	if (page_is_ram(phys >> PAGE_SHIFT))
 		return;
 
-	iounmap((void __iomem *)((unsigned long)addr & PAGE_MASK));
+	memunmap((void *)((unsigned long)addr & PAGE_MASK));
 }
 
 static pte_t bm_pte[PAGE_SIZE/sizeof(pte_t)] __page_aligned_bss;
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index e5b872ba2484..da1078692c41 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -3,6 +3,7 @@ config ZONE_DMA
 
 config XTENSA
 	def_bool y
+	select ARCH_HAS_MEMREMAP
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select ARCH_WANT_OPTIONAL_GPIOLIB
diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index a095d4f858da..d4992fea6994 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -318,7 +318,8 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 			    sizeof(*trigger_tab) - 1);
 		goto out;
 	}
-	trigger_tab = ioremap_cache(trigger_paddr, sizeof(*trigger_tab));
+	trigger_tab = memremap(trigger_paddr, sizeof(*trigger_tab),
+			MEMREMAP_CACHE);
 	if (!trigger_tab) {
 		pr_err(EINJ_PFX "Failed to map trigger table!\n");
 		goto out_rel_header;
@@ -346,8 +347,8 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 		       (unsigned long long)trigger_paddr + table_size - 1);
 		goto out_rel_header;
 	}
-	iounmap(trigger_tab);
-	trigger_tab = ioremap_cache(trigger_paddr, table_size);
+	memunmap(trigger_tab);
+	trigger_tab = memremap(trigger_paddr, table_size, MEMREMAP_CACHE);
 	if (!trigger_tab) {
 		pr_err(EINJ_PFX "Failed to map trigger table!\n");
 		goto out_rel_entry;
@@ -409,7 +410,7 @@ out_rel_header:
 	release_mem_region(trigger_paddr, sizeof(*trigger_tab));
 out:
 	if (trigger_tab)
-		iounmap(trigger_tab);
+		memunmap(trigger_tab);
 
 	return rc;
 }
diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 3670bbab57a3..dc49b0b42d65 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -77,7 +77,7 @@ static struct acpi_table_erst *erst_tab;
 static struct erst_erange {
 	u64 base;
 	u64 size;
-	void __iomem *vaddr;
+	void *vaddr;
 	u32 attr;
 } erst_erange;
 
@@ -1185,8 +1185,8 @@ static int __init erst_init(void)
 		goto err_unmap_reg;
 	}
 	rc = -ENOMEM;
-	erst_erange.vaddr = ioremap_cache(erst_erange.base,
-					  erst_erange.size);
+	erst_erange.vaddr = memremap(erst_erange.base, erst_erange.size,
+			MEMREMAP_CACHE);
 	if (!erst_erange.vaddr)
 		goto err_release_erange;
 
diff --git a/drivers/firmware/google/memconsole.c b/drivers/firmware/google/memconsole.c
index 2f569aaed4c7..2b8160d12ad6 100644
--- a/drivers/firmware/google/memconsole.c
+++ b/drivers/firmware/google/memconsole.c
@@ -52,14 +52,15 @@ static ssize_t memconsole_read(struct file *filp, struct kobject *kobp,
 	char *memconsole;
 	ssize_t ret;
 
-	memconsole = ioremap_cache(memconsole_baseaddr, memconsole_length);
+	memconsole = memremap(memconsole_baseaddr, memconsole_length,
+			MEMREMAP_CACHE);
 	if (!memconsole) {
 		pr_err("memconsole: ioremap_cache failed\n");
 		return -ENOMEM;
 	}
 	ret = memory_read_from_buffer(buf, count, &pos, memconsole,
 				      memconsole_length);
-	iounmap(memconsole);
+	memunmap(memconsole);
 	return ret;
 }
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 5a31bf3a4024..04e53eab71c5 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -668,6 +668,11 @@ extern void devm_free_pages(struct device *dev, unsigned long addr);
 
 void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res);
 
+static inline void *devm_memremap_resource(struct device *dev, struct resource *res)
+{
+	return (void __force *) devm_ioremap_resource(dev, res);
+}
+
 /* allows to add/remove a custom action to devres stack */
 int devm_add_action(struct device *dev, void (*action)(void *), void *data);
 void devm_remove_action(struct device *dev, void (*action)(void *), void *data);
diff --git a/include/linux/io.h b/include/linux/io.h
index 080a4fbf2ba4..2983b6e63970 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -192,4 +192,15 @@ static inline int arch_phys_wc_index(int handle)
 #endif
 #endif
 
+enum {
+	MEMREMAP_WB = 1 << 0,
+	MEMREMAP_WT = 1 << 1,
+	MEMREMAP_WC = 1 << 2,
+	MEMREMAP_STRICT = 1 << 3,
+	MEMREMAP_CACHE = MEMREMAP_WB,
+};
+
+extern void *memremap(resource_size_t offset, size_t size, unsigned long flags);
+extern void memunmap(void *addr);
+
 #endif /* _LINUX_IO_H */
diff --git a/kernel/resource.c b/kernel/resource.c
index fed052a1bc9f..a96376be513a 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -23,7 +23,7 @@
 #include <linux/pfn.h>
 #include <linux/mm.h>
 #include <linux/resource_ext.h>
-#include <asm/io.h>
+#include <linux/io.h>
 
 
 struct resource ioport_resource = {
@@ -528,6 +528,55 @@ int region_is_ram(resource_size_t start, unsigned long size)
 	return ret;
 }
 
+#ifdef CONFIG_ARCH_HAS_MEMREMAP
+/*
+ * memremap() is "ioremap" for cases where it is known that the resource
+ * being mapped does not have i/o side effects and the __iomem
+ * annotation is not applicable.
+ */
+static bool memremap_valid(resource_size_t offset, size_t size)
+{
+	if (region_is_ram(offset, size) != 0) {
+		WARN_ONCE(1, "memremap attempted on ram %pa size: %zu\n",
+				&offset, size);
+		return false;
+	}
+	return true;
+}
+
+void *memremap(resource_size_t offset, size_t size, unsigned long flags)
+{
+	void __iomem *addr = NULL;
+
+	if (!memremap_valid(offset, size))
+		return NULL;
+
+	/* try all mapping types requested until one returns non-NULL */
+	if (flags & MEMREMAP_CACHE) {
+		if (flags & MEMREMAP_STRICT)
+			addr = strict_ioremap_cache(offset, size);
+		else
+			addr = ioremap_cache(offset, size);
+	}
+
+	if (!addr && (flags & MEMREMAP_WT)) {
+		if (flags & MEMREMAP_STRICT)
+			addr = strict_ioremap_wt(offset, size);
+		else
+			addr = ioremap_wt(offset, size);
+	}
+
+	return (void __force *) addr;
+}
+EXPORT_SYMBOL(memremap);
+
+void memunmap(void *addr)
+{
+	iounmap((void __iomem __force *) addr);
+}
+EXPORT_SYMBOL(memunmap);
+#endif /* CONFIG_ARCH_HAS_MEMREMAP */
+
 void __weak arch_remove_reservations(struct resource *avail)
 {
 }
diff --git a/lib/Kconfig b/lib/Kconfig
index 3a2ef67db6c7..097b99073924 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -526,7 +526,10 @@ source "lib/fonts/Kconfig"
 #
 
 config ARCH_HAS_SG_CHAIN
-	def_bool n
+	bool
+
+config ARCH_HAS_MEMREMAP
+	bool
 
 config ARCH_HAS_PMEM_API
 	bool

From: Mike Rapoport <rppt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/6] mm: introduce secretmemfd system call to create "secret" memory areas
Date: Mon, 20 Jul 2020 12:24:32 +0300
Message-ID: <20200720092435.17469-4-rppt@kernel.org>
References: <20200720092435.17469-1-rppt@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200720092435.17469-1-rppt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Alexander Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Christopher Lameter <cl-vYTEC60ixJUAvxtiuMwx3w@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Elena Reshetova <elena.reshetova-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Idan Yaniv <idan.yaniv-qyM6JfAXOaQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, James Bottomley <jejb-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, "Kirill A. Shutemov" <kirill-oKw7cIdHH8eLwutG50LtGA@public.gmane.org>, Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Mike Rapoport <rppt-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, Mike Rapoport <rppt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Palmer Dabbelt <palmer-96lFi9zoCfxBDgjK7y7TUQ@public.gmane.org>, Paul Walmsley <paul.walmsley-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

From: Mike Rapoport <rppt-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>

Introduce "secretmemfd" system call with the ability to create memory areas
visible only in the context of the owning process and not mapped not only
to other processes but in the kernel page tables as well.

The user will create a file descriptor using the secretmemfd system call
where flags supplied as a parameter to this system call will define the
desired protection mode for the memory associated with that file
descriptor. Currently there are two protection modes:

* exclusive - the memory area is unmapped from the kernel direct map and it
              is present only in the page tables of the owning mm.
* uncached  - the memory area is present only in the page tables of the
              owning mm and it is mapped there as uncached.

For instance, the following example will create an uncached mapping (error
handling is omitted):

	fd = secretmemfd(SECRETMEM_UNCACHED);
	ftruncate(fd, MAP_SIZE);
	ptr = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED,
		   fd, 0);

Signed-off-by: Mike Rapoport <rppt-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
---
 include/uapi/linux/magic.h     |   1 +
 include/uapi/linux/secretmem.h |   9 ++
 mm/Kconfig                     |   4 +
 mm/Makefile                    |   1 +
 mm/secretmem.c                 | 263 +++++++++++++++++++++++++++++++++
 5 files changed, 278 insertions(+)
 create mode 100644 include/uapi/linux/secretmem.h
 create mode 100644 mm/secretmem.c

diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index f3956fc11de6..35687dcb1a42 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -97,5 +97,6 @@
 #define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
 #define Z3FOLD_MAGIC		0x33
 #define PPC_CMM_MAGIC		0xc7571590
+#define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
 
 #endif /* __LINUX_MAGIC_H__ */
diff --git a/include/uapi/linux/secretmem.h b/include/uapi/linux/secretmem.h
new file mode 100644
index 000000000000..cef7a59f7492
--- /dev/null
+++ b/include/uapi/linux/secretmem.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_SECRERTMEM_H
+#define _UAPI_LINUX_SECRERTMEM_H
+
+/* secretmem operation modes */
+#define SECRETMEM_EXCLUSIVE	0x1
+#define SECRETMEM_UNCACHED	0x2
+
+#endif /* _UAPI_LINUX_SECRERTMEM_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index f2104cc0d35c..c5aa948214f9 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -872,4 +872,8 @@ config ARCH_HAS_HUGEPD
 config MAPPING_DIRTY_HELPERS
         bool
 
+config SECRETMEM
+        def_bool ARCH_HAS_SET_DIRECT_MAP
+	select GENERIC_ALLOCATOR
+
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index 6e9d46b2efc9..c2aa7a393b73 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -121,3 +121,4 @@ obj-$(CONFIG_MEMFD_CREATE) += memfd.o
 obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
 obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
 obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
+obj-$(CONFIG_SECRETMEM) += secretmem.o
diff --git a/mm/secretmem.c b/mm/secretmem.c
new file mode 100644
index 000000000000..2f65219baf80
--- /dev/null
+++ b/mm/secretmem.c
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/mm.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/memfd.h>
+#include <linux/bitops.h>
+#include <linux/printk.h>
+#include <linux/pagemap.h>
+#include <linux/syscalls.h>
+#include <linux/pseudo_fs.h>
+#include <linux/set_memory.h>
+#include <linux/sched/signal.h>
+
+#include <uapi/linux/secretmem.h>
+#include <uapi/linux/magic.h>
+
+#include <asm/tlbflush.h>
+
+#include "internal.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt) "secretmem: " fmt
+
+#define SECRETMEM_MODE_MASK	(SECRETMEM_EXCLUSIVE | SECRETMEM_UNCACHED)
+#define SECRETMEM_FLAGS_MASK	SECRETMEM_MODE_MASK
+
+struct secretmem_ctx {
+	unsigned int mode;
+};
+
+static struct page *secretmem_alloc_page(gfp_t gfp)
+{
+	/*
+	 * FIXME: use a cache of large pages to reduce the direct map
+	 * fragmentation
+	 */
+	return alloc_page(gfp);
+}
+
+static vm_fault_t secretmem_fault(struct vm_fault *vmf)
+{
+	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
+	struct inode *inode = file_inode(vmf->vma->vm_file);
+	pgoff_t offset = vmf->pgoff;
+	unsigned long addr;
+	struct page *page;
+	int ret = 0;
+
+	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
+		return vmf_error(-EINVAL);
+
+	page = find_get_entry(mapping, offset);
+	if (!page) {
+		page = secretmem_alloc_page(vmf->gfp_mask);
+		if (!page)
+			return vmf_error(-ENOMEM);
+
+		ret = add_to_page_cache(page, mapping, offset, vmf->gfp_mask);
+		if (unlikely(ret))
+			goto err_put_page;
+
+		ret = set_direct_map_invalid_noflush(page);
+		if (ret)
+			goto err_del_page_cache;
+
+		addr = (unsigned long)page_address(page);
+		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+
+		__SetPageUptodate(page);
+
+		ret = VM_FAULT_LOCKED;
+	}
+
+	vmf->page = page;
+	return ret;
+
+err_del_page_cache:
+	delete_from_page_cache(page);
+err_put_page:
+	put_page(page);
+	return vmf_error(ret);
+}
+
+static const struct vm_operations_struct secretmem_vm_ops = {
+	.fault = secretmem_fault,
+};
+
+static int secretmem_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct secretmem_ctx *ctx = file->private_data;
+	unsigned long mode = ctx->mode;
+	unsigned long len = vma->vm_end - vma->vm_start;
+
+	if (!mode)
+		return -EINVAL;
+
+	if (mlock_future_check(vma->vm_mm, vma->vm_flags | VM_LOCKED, len))
+		return -EAGAIN;
+
+	switch (mode) {
+	case SECRETMEM_UNCACHED:
+		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+		fallthrough;
+	case SECRETMEM_EXCLUSIVE:
+		vma->vm_ops = &secretmem_vm_ops;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	vma->vm_flags |= VM_LOCKED;
+
+	return 0;
+}
+
+const struct file_operations secretmem_fops = {
+	.mmap		= secretmem_mmap,
+};
+
+static bool secretmem_isolate_page(struct page *page, isolate_mode_t mode)
+{
+	return false;
+}
+
+static int secretmem_migratepage(struct address_space *mapping,
+				 struct page *newpage, struct page *page,
+				 enum migrate_mode mode)
+{
+	return -EBUSY;
+}
+
+static void secretmem_freepage(struct page *page)
+{
+	set_direct_map_default_noflush(page);
+}
+
+static const struct address_space_operations secretmem_aops = {
+	.freepage	= secretmem_freepage,
+	.migratepage	= secretmem_migratepage,
+	.isolate_page	= secretmem_isolate_page,
+};
+
+static struct vfsmount *secretmem_mnt;
+
+static struct file *secretmem_file_create(unsigned long flags)
+{
+	struct file *file = ERR_PTR(-ENOMEM);
+	struct secretmem_ctx *ctx;
+	struct inode *inode;
+
+	inode = alloc_anon_inode(secretmem_mnt->mnt_sb);
+	if (IS_ERR(inode))
+		return ERR_CAST(inode);
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		goto err_free_inode;
+
+	file = alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
+				 O_RDWR, &secretmem_fops);
+	if (IS_ERR(file))
+		goto err_free_ctx;
+
+	mapping_set_unevictable(inode->i_mapping);
+
+	inode->i_mapping->private_data = ctx;
+	inode->i_mapping->a_ops = &secretmem_aops;
+
+	/* pretend we are a normal file with zero size */
+	inode->i_mode |= S_IFREG;
+	inode->i_size = 0;
+
+	file->private_data = ctx;
+
+	ctx->mode = flags & SECRETMEM_MODE_MASK;
+
+	return file;
+
+err_free_ctx:
+	kfree(ctx);
+err_free_inode:
+	iput(inode);
+	return file;
+}
+
+SYSCALL_DEFINE1(secretmemfd, unsigned long, flags)
+{
+	struct file *file;
+	unsigned int mode;
+	int fd, err;
+
+	/* make sure local flags do not confict with global fcntl.h */
+	BUILD_BUG_ON(SECRETMEM_FLAGS_MASK & O_CLOEXEC);
+
+	if (flags & ~(SECRETMEM_FLAGS_MASK | O_CLOEXEC))
+		return -EINVAL;
+
+	/* modes are mutually exclusive, only one mode bit should be set */
+	mode = flags & SECRETMEM_FLAGS_MASK;
+	if (ffs(mode) != fls(mode))
+		return -EINVAL;
+
+	fd = get_unused_fd_flags(flags & O_CLOEXEC);
+	if (fd < 0)
+		return fd;
+
+	file = secretmem_file_create(flags);
+	if (IS_ERR(file)) {
+		err = PTR_ERR(file);
+		goto err_put_fd;
+	}
+
+	file->f_flags |= O_LARGEFILE;
+
+	fd_install(fd, file);
+	return fd;
+
+err_put_fd:
+	put_unused_fd(fd);
+	return err;
+}
+
+static void secretmem_evict_inode(struct inode *inode)
+{
+	struct secretmem_ctx *ctx = inode->i_private;
+
+	truncate_inode_pages_final(&inode->i_data);
+	clear_inode(inode);
+	kfree(ctx);
+}
+
+static const struct super_operations secretmem_super_ops = {
+	.evict_inode = secretmem_evict_inode,
+};
+
+static int secretmem_init_fs_context(struct fs_context *fc)
+{
+	struct pseudo_fs_context *ctx = init_pseudo(fc, SECRETMEM_MAGIC);
+
+	if (!ctx)
+		return -ENOMEM;
+	ctx->ops = &secretmem_super_ops;
+
+	return 0;
+}
+
+static struct file_system_type secretmem_fs = {
+	.name		= "secretmem",
+	.init_fs_context = secretmem_init_fs_context,
+	.kill_sb	= kill_anon_super,
+};
+
+static int secretmem_init(void)
+{
+	int ret = 0;
+
+	secretmem_mnt = kern_mount(&secretmem_fs);
+	if (IS_ERR(secretmem_mnt))
+		ret = PTR_ERR(secretmem_mnt);
+
+	return ret;
+}
+fs_initcall(secretmem_init);
-- 
2.26.2

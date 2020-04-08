Return-Path: <SRS0=F7pE=5Y=kvack.org=owner-linux-mm@kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 20/28] mm: remove the pgprot argument to __vmalloc
Date: Wed,  8 Apr 2020 13:59:18 +0200
Message-ID: <20200408115926.1467567-21-hch@lst.de>
In-Reply-To: <20200408115926.1467567-1-hch@lst.de>
References: <20200408115926.1467567-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, x86@kernel.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200408115918.SUWIF9cvc330q77bt6SlRMd_1kpf-TyaFJ8Qbvt7B9o@z>

The pgprot argument to __vmalloc is always PROT_KERNEL now, so remove
it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/hyperv/hv_init.c              |  3 +--
 arch/x86/include/asm/kvm_host.h        |  3 +--
 arch/x86/kvm/svm.c                     |  3 +--
 drivers/block/drbd/drbd_bitmap.c       |  4 +---
 drivers/gpu/drm/etnaviv/etnaviv_dump.c |  4 ++--
 drivers/lightnvm/pblk-init.c           |  5 ++---
 drivers/md/dm-bufio.c                  |  4 ++--
 drivers/mtd/ubi/io.c                   |  4 ++--
 drivers/scsi/sd_zbc.c                  |  3 +--
 fs/gfs2/dir.c                          |  9 ++++-----
 fs/gfs2/quota.c                        |  2 +-
 fs/nfs/blocklayout/extent_tree.c       |  2 +-
 fs/ntfs/malloc.h                       |  2 +-
 fs/ubifs/debug.c                       |  2 +-
 fs/ubifs/lprops.c                      |  2 +-
 fs/ubifs/lpt_commit.c                  |  4 ++--
 fs/ubifs/orphan.c                      |  2 +-
 fs/xfs/kmem.c                          |  2 +-
 include/linux/vmalloc.h                |  2 +-
 kernel/bpf/core.c                      |  6 +++---
 kernel/groups.c                        |  2 +-
 kernel/module.c                        |  3 +--
 mm/nommu.c                             | 15 +++++++--------
 mm/page_alloc.c                        |  2 +-
 mm/percpu.c                            |  2 +-
 mm/vmalloc.c                           |  4 ++--
 net/bridge/netfilter/ebtables.c        |  6 ++----
 sound/core/memalloc.c                  |  2 +-
 sound/core/pcm_memory.c                |  2 +-
 29 files changed, 47 insertions(+), 59 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 5a4b363ba67b..a3d689dfc745 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -95,8 +95,7 @@ static int hv_cpu_init(unsigned int cpu)
 	 * not be stopped in the case of CPU offlining and the VM will hang.
 	 */
 	if (!*hvp) {
-		*hvp =3D __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO,
-				 PAGE_KERNEL);
+		*hvp =3D __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO);
 	}
=20
 	if (*hvp) {
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
index 42a2d0d3984a..71bc09bff01a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1280,8 +1280,7 @@ extern struct kmem_cache *x86_fpu_cache;
 #define __KVM_HAVE_ARCH_VM_ALLOC
 static inline struct kvm *kvm_arch_alloc_vm(void)
 {
-	return __vmalloc(kvm_x86_ops.vm_size,
-			 GFP_KERNEL_ACCOUNT | __GFP_ZERO, PAGE_KERNEL);
+	return __vmalloc(kvm_x86_ops.vm_size, GFP_KERNEL_ACCOUNT | __GFP_ZERO);
 }
 void kvm_arch_free_vm(struct kvm *kvm);
=20
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 851e9cc79930..83e8323ba4f2 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -1927,8 +1927,7 @@ static struct page **sev_pin_memory(struct kvm *kvm=
, unsigned long uaddr,
 	/* Avoid using vmalloc for smaller buffers. */
 	size =3D npages * sizeof(struct page *);
 	if (size > PAGE_SIZE)
-		pages =3D __vmalloc(size, GFP_KERNEL_ACCOUNT | __GFP_ZERO,
-				  PAGE_KERNEL);
+		pages =3D __vmalloc(size, GFP_KERNEL_ACCOUNT | __GFP_ZERO);
 	else
 		pages =3D kmalloc(size, GFP_KERNEL_ACCOUNT);
=20
diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_b=
itmap.c
index 15e99697234a..df53dca5d02c 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -396,9 +396,7 @@ static struct page **bm_realloc_pages(struct drbd_bit=
map *b, unsigned long want)
 	bytes =3D sizeof(struct page *)*want;
 	new_pages =3D kzalloc(bytes, GFP_NOIO | __GFP_NOWARN);
 	if (!new_pages) {
-		new_pages =3D __vmalloc(bytes,
-				GFP_NOIO | __GFP_ZERO,
-				PAGE_KERNEL);
+		new_pages =3D __vmalloc(bytes, GFP_NOIO | __GFP_ZERO);
 		if (!new_pages)
 			return NULL;
 	}
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_dump.c b/drivers/gpu/drm/etn=
aviv/etnaviv_dump.c
index 648cf0207309..706af0304ca4 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_dump.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_dump.c
@@ -154,8 +154,8 @@ void etnaviv_core_dump(struct etnaviv_gem_submit *sub=
mit)
 	file_size +=3D sizeof(*iter.hdr) * n_obj;
=20
 	/* Allocate the file in vmalloc memory, it's likely to be big */
-	iter.start =3D __vmalloc(file_size, GFP_KERNEL | __GFP_NOWARN | __GFP_N=
ORETRY,
-			       PAGE_KERNEL);
+	iter.start =3D __vmalloc(file_size, GFP_KERNEL | __GFP_NOWARN |
+			__GFP_NORETRY);
 	if (!iter.start) {
 		mutex_unlock(&gpu->mmu_context->lock);
 		dev_warn(gpu->dev, "failed to allocate devcoredump file\n");
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 9a967a2e83dd..6e677ff62cc9 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -145,9 +145,8 @@ static int pblk_l2p_init(struct pblk *pblk, bool fact=
ory_init)
 	int ret =3D 0;
=20
 	map_size =3D pblk_trans_map_size(pblk);
-	pblk->trans_map =3D __vmalloc(map_size, GFP_KERNEL | __GFP_NOWARN
-					| __GFP_RETRY_MAYFAIL | __GFP_HIGHMEM,
-					PAGE_KERNEL);
+	pblk->trans_map =3D __vmalloc(map_size, GFP_KERNEL | __GFP_NOWARN |
+				    __GFP_RETRY_MAYFAIL | __GFP_HIGHMEM);
 	if (!pblk->trans_map) {
 		pblk_err(pblk, "failed to allocate L2P (need %zu of memory)\n",
 				map_size);
diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 2d519c223562..d1786cfd7f22 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -400,13 +400,13 @@ static void *alloc_buffer_data(struct dm_bufio_clie=
nt *c, gfp_t gfp_mask,
 	 */
 	if (gfp_mask & __GFP_NORETRY) {
 		unsigned noio_flag =3D memalloc_noio_save();
-		void *ptr =3D __vmalloc(c->block_size, gfp_mask, PAGE_KERNEL);
+		void *ptr =3D __vmalloc(c->block_size, gfp_mask);
=20
 		memalloc_noio_restore(noio_flag);
 		return ptr;
 	}
=20
-	return __vmalloc(c->block_size, gfp_mask, PAGE_KERNEL);
+	return __vmalloc(c->block_size, gfp_mask);
 }
=20
 /*
diff --git a/drivers/mtd/ubi/io.c b/drivers/mtd/ubi/io.c
index b57b84fb97d0..14d890b00d2c 100644
--- a/drivers/mtd/ubi/io.c
+++ b/drivers/mtd/ubi/io.c
@@ -1297,7 +1297,7 @@ static int self_check_write(struct ubi_device *ubi,=
 const void *buf, int pnum,
 	if (!ubi_dbg_chk_io(ubi))
 		return 0;
=20
-	buf1 =3D __vmalloc(len, GFP_NOFS, PAGE_KERNEL);
+	buf1 =3D __vmalloc(len, GFP_NOFS);
 	if (!buf1) {
 		ubi_err(ubi, "cannot allocate memory to check writes");
 		return 0;
@@ -1361,7 +1361,7 @@ int ubi_self_check_all_ff(struct ubi_device *ubi, i=
nt pnum, int offset, int len)
 	if (!ubi_dbg_chk_io(ubi))
 		return 0;
=20
-	buf =3D __vmalloc(len, GFP_NOFS, PAGE_KERNEL);
+	buf =3D __vmalloc(len, GFP_NOFS);
 	if (!buf) {
 		ubi_err(ubi, "cannot allocate memory to check for 0xFFs");
 		return 0;
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index f45c22b09726..8be27426aa66 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -136,8 +136,7 @@ static void *sd_zbc_alloc_report_buffer(struct scsi_d=
isk *sdkp,
=20
 	while (bufsize >=3D SECTOR_SIZE) {
 		buf =3D __vmalloc(bufsize,
-				GFP_KERNEL | __GFP_ZERO | __GFP_NORETRY,
-				PAGE_KERNEL);
+				GFP_KERNEL | __GFP_ZERO | __GFP_NORETRY);
 		if (buf) {
 			*buflen =3D bufsize;
 			return buf;
diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index c3f7732415be..c0f2875c946c 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -354,7 +354,7 @@ static __be64 *gfs2_dir_get_hash_table(struct gfs2_in=
ode *ip)
=20
 	hc =3D kmalloc(hsize, GFP_NOFS | __GFP_NOWARN);
 	if (hc =3D=3D NULL)
-		hc =3D __vmalloc(hsize, GFP_NOFS, PAGE_KERNEL);
+		hc =3D __vmalloc(hsize, GFP_NOFS);
=20
 	if (hc =3D=3D NULL)
 		return ERR_PTR(-ENOMEM);
@@ -1166,7 +1166,7 @@ static int dir_double_exhash(struct gfs2_inode *dip=
)
=20
 	hc2 =3D kmalloc_array(hsize_bytes, 2, GFP_NOFS | __GFP_NOWARN);
 	if (hc2 =3D=3D NULL)
-		hc2 =3D __vmalloc(hsize_bytes * 2, GFP_NOFS, PAGE_KERNEL);
+		hc2 =3D __vmalloc(hsize_bytes * 2, GFP_NOFS);
=20
 	if (!hc2)
 		return -ENOMEM;
@@ -1327,7 +1327,7 @@ static void *gfs2_alloc_sort_buffer(unsigned size)
 	if (size < KMALLOC_MAX_SIZE)
 		ptr =3D kmalloc(size, GFP_NOFS | __GFP_NOWARN);
 	if (!ptr)
-		ptr =3D __vmalloc(size, GFP_NOFS, PAGE_KERNEL);
+		ptr =3D __vmalloc(size, GFP_NOFS);
 	return ptr;
 }
=20
@@ -1987,8 +1987,7 @@ static int leaf_dealloc(struct gfs2_inode *dip, u32=
 index, u32 len,
=20
 	ht =3D kzalloc(size, GFP_NOFS | __GFP_NOWARN);
 	if (ht =3D=3D NULL)
-		ht =3D __vmalloc(size, GFP_NOFS | __GFP_NOWARN | __GFP_ZERO,
-			       PAGE_KERNEL);
+		ht =3D __vmalloc(size, GFP_NOFS | __GFP_NOWARN | __GFP_ZERO);
 	if (!ht)
 		return -ENOMEM;
=20
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index cc0c4b5800be..b84ac5843ec4 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -1368,7 +1368,7 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 	sdp->sd_quota_bitmap =3D kzalloc(bm_size, GFP_NOFS | __GFP_NOWARN);
 	if (sdp->sd_quota_bitmap =3D=3D NULL)
 		sdp->sd_quota_bitmap =3D __vmalloc(bm_size, GFP_NOFS |
-						 __GFP_ZERO, PAGE_KERNEL);
+						 __GFP_ZERO);
 	if (!sdp->sd_quota_bitmap)
 		return error;
=20
diff --git a/fs/nfs/blocklayout/extent_tree.c b/fs/nfs/blocklayout/extent=
_tree.c
index 7a57ff2528af..8f7cff7a4293 100644
--- a/fs/nfs/blocklayout/extent_tree.c
+++ b/fs/nfs/blocklayout/extent_tree.c
@@ -582,7 +582,7 @@ ext_tree_prepare_commit(struct nfs4_layoutcommit_args=
 *arg)
 		if (!arg->layoutupdate_pages)
 			return -ENOMEM;
=20
-		start_p =3D __vmalloc(buffer_size, GFP_NOFS, PAGE_KERNEL);
+		start_p =3D __vmalloc(buffer_size, GFP_NOFS);
 		if (!start_p) {
 			kfree(arg->layoutupdate_pages);
 			return -ENOMEM;
diff --git a/fs/ntfs/malloc.h b/fs/ntfs/malloc.h
index 842b0bfc3ac9..7068425735f1 100644
--- a/fs/ntfs/malloc.h
+++ b/fs/ntfs/malloc.h
@@ -34,7 +34,7 @@ static inline void *__ntfs_malloc(unsigned long size, g=
fp_t gfp_mask)
 		/* return (void *)__get_free_page(gfp_mask); */
 	}
 	if (likely((size >> PAGE_SHIFT) < totalram_pages()))
-		return __vmalloc(size, gfp_mask, PAGE_KERNEL);
+		return __vmalloc(size, gfp_mask);
 	return NULL;
 }
=20
diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index 0f5a480fe264..31288d8fa2ce 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -815,7 +815,7 @@ void ubifs_dump_leb(const struct ubifs_info *c, int l=
num)
=20
 	pr_err("(pid %d) start dumping LEB %d\n", current->pid, lnum);
=20
-	buf =3D __vmalloc(c->leb_size, GFP_NOFS, PAGE_KERNEL);
+	buf =3D __vmalloc(c->leb_size, GFP_NOFS);
 	if (!buf) {
 		ubifs_err(c, "cannot allocate memory for dumping LEB %d", lnum);
 		return;
diff --git a/fs/ubifs/lprops.c b/fs/ubifs/lprops.c
index 29826c51883a..22bfda158f7f 100644
--- a/fs/ubifs/lprops.c
+++ b/fs/ubifs/lprops.c
@@ -1095,7 +1095,7 @@ static int scan_check_cb(struct ubifs_info *c,
 		return LPT_SCAN_CONTINUE;
 	}
=20
-	buf =3D __vmalloc(c->leb_size, GFP_NOFS, PAGE_KERNEL);
+	buf =3D __vmalloc(c->leb_size, GFP_NOFS);
 	if (!buf)
 		return -ENOMEM;
=20
diff --git a/fs/ubifs/lpt_commit.c b/fs/ubifs/lpt_commit.c
index ff5e0411cf2d..d76a19e460cd 100644
--- a/fs/ubifs/lpt_commit.c
+++ b/fs/ubifs/lpt_commit.c
@@ -1596,7 +1596,7 @@ static int dbg_check_ltab_lnum(struct ubifs_info *c=
, int lnum)
 	if (!dbg_is_chk_lprops(c))
 		return 0;
=20
-	buf =3D p =3D __vmalloc(c->leb_size, GFP_NOFS, PAGE_KERNEL);
+	buf =3D p =3D __vmalloc(c->leb_size, GFP_NOFS);
 	if (!buf) {
 		ubifs_err(c, "cannot allocate memory for ltab checking");
 		return 0;
@@ -1845,7 +1845,7 @@ static void dump_lpt_leb(const struct ubifs_info *c=
, int lnum)
 	void *buf, *p;
=20
 	pr_err("(pid %d) start dumping LEB %d\n", current->pid, lnum);
-	buf =3D p =3D __vmalloc(c->leb_size, GFP_NOFS, PAGE_KERNEL);
+	buf =3D p =3D __vmalloc(c->leb_size, GFP_NOFS);
 	if (!buf) {
 		ubifs_err(c, "cannot allocate memory to dump LPT");
 		return;
diff --git a/fs/ubifs/orphan.c b/fs/ubifs/orphan.c
index 283f9eb48410..2c294085ffed 100644
--- a/fs/ubifs/orphan.c
+++ b/fs/ubifs/orphan.c
@@ -977,7 +977,7 @@ static int dbg_scan_orphans(struct ubifs_info *c, str=
uct check_info *ci)
 	if (c->no_orphs)
 		return 0;
=20
-	buf =3D __vmalloc(c->leb_size, GFP_NOFS, PAGE_KERNEL);
+	buf =3D __vmalloc(c->leb_size, GFP_NOFS);
 	if (!buf) {
 		ubifs_err(c, "cannot allocate memory to check orphans");
 		return 0;
diff --git a/fs/xfs/kmem.c b/fs/xfs/kmem.c
index 1da94237a8cf..f1366475c389 100644
--- a/fs/xfs/kmem.c
+++ b/fs/xfs/kmem.c
@@ -48,7 +48,7 @@ __kmem_vmalloc(size_t size, xfs_km_flags_t flags)
 	if (flags & KM_NOFS)
 		nofs_flag =3D memalloc_nofs_save();
=20
-	ptr =3D __vmalloc(size, lflags, PAGE_KERNEL);
+	ptr =3D __vmalloc(size, lflags);
=20
 	if (flags & KM_NOFS)
 		memalloc_nofs_restore(nofs_flag);
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 9273b1a91ca5..c1b9d6eca05f 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -110,7 +110,7 @@ extern void *vmalloc_user_node_flags(unsigned long si=
ze, int node, gfp_t flags);
 extern void *vmalloc_exec(unsigned long size);
 extern void *vmalloc_32(unsigned long size);
 extern void *vmalloc_32_user(unsigned long size);
-extern void *__vmalloc(unsigned long size, gfp_t gfp_mask, pgprot_t prot=
);
+extern void *__vmalloc(unsigned long size, gfp_t gfp_mask);
 extern void *__vmalloc_node_range(unsigned long size, unsigned long alig=
n,
 			unsigned long start, unsigned long end, gfp_t gfp_mask,
 			pgprot_t prot, unsigned long vm_flags, int node,
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 916f5132a984..c712de560357 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -82,7 +82,7 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int s=
ize, gfp_t gfp_extra_flag
 	struct bpf_prog *fp;
=20
 	size =3D round_up(size, PAGE_SIZE);
-	fp =3D __vmalloc(size, gfp_flags, PAGE_KERNEL);
+	fp =3D __vmalloc(size, gfp_flags);
 	if (fp =3D=3D NULL)
 		return NULL;
=20
@@ -232,7 +232,7 @@ struct bpf_prog *bpf_prog_realloc(struct bpf_prog *fp=
_old, unsigned int size,
 	if (ret)
 		return NULL;
=20
-	fp =3D __vmalloc(size, gfp_flags, PAGE_KERNEL);
+	fp =3D __vmalloc(size, gfp_flags);
 	if (fp =3D=3D NULL) {
 		__bpf_prog_uncharge(fp_old->aux->user, delta);
 	} else {
@@ -1089,7 +1089,7 @@ static struct bpf_prog *bpf_prog_clone_create(struc=
t bpf_prog *fp_other,
 	gfp_t gfp_flags =3D GFP_KERNEL | __GFP_ZERO | gfp_extra_flags;
 	struct bpf_prog *fp;
=20
-	fp =3D __vmalloc(fp_other->pages * PAGE_SIZE, gfp_flags, PAGE_KERNEL);
+	fp =3D __vmalloc(fp_other->pages * PAGE_SIZE, gfp_flags);
 	if (fp !=3D NULL) {
 		/* aux->prog still points to the fp_other one, so
 		 * when promoting the clone to the real program,
diff --git a/kernel/groups.c b/kernel/groups.c
index daae2f2dc6d4..6ee6691f6839 100644
--- a/kernel/groups.c
+++ b/kernel/groups.c
@@ -20,7 +20,7 @@ struct group_info *groups_alloc(int gidsetsize)
 	len =3D sizeof(struct group_info) + sizeof(kgid_t) * gidsetsize;
 	gi =3D kmalloc(len, GFP_KERNEL_ACCOUNT|__GFP_NOWARN|__GFP_NORETRY);
 	if (!gi)
-		gi =3D __vmalloc(len, GFP_KERNEL_ACCOUNT, PAGE_KERNEL);
+		gi =3D __vmalloc(len, GFP_KERNEL_ACCOUNT);
 	if (!gi)
 		return NULL;
=20
diff --git a/kernel/module.c b/kernel/module.c
index 3447f3b74870..c607fed4e617 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2946,8 +2946,7 @@ static int copy_module_from_user(const void __user =
*umod, unsigned long len,
 		return err;
=20
 	/* Suck in entire file: we'll want most of it. */
-	info->hdr =3D __vmalloc(info->len,
-			GFP_KERNEL | __GFP_NOWARN, PAGE_KERNEL);
+	info->hdr =3D __vmalloc(info->len, GFP_KERNEL | __GFP_NOWARN);
 	if (!info->hdr)
 		return -ENOMEM;
=20
diff --git a/mm/nommu.c b/mm/nommu.c
index 4f07b7ef0297..2df549adb22b 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -140,7 +140,7 @@ void vfree(const void *addr)
 }
 EXPORT_SYMBOL(vfree);
=20
-void *__vmalloc(unsigned long size, gfp_t gfp_mask, pgprot_t prot)
+void *__vmalloc(unsigned long size, gfp_t gfp_mask)
 {
 	/*
 	 *  You can't specify __GFP_HIGHMEM with kmalloc() since kmalloc()
@@ -152,14 +152,14 @@ EXPORT_SYMBOL(__vmalloc);
=20
 void *__vmalloc_node_flags(unsigned long size, int node, gfp_t flags)
 {
-	return __vmalloc(size, flags, PAGE_KERNEL);
+	return __vmalloc(size, flags);
 }
=20
 static void *__vmalloc_user_flags(unsigned long size, gfp_t flags)
 {
 	void *ret;
=20
-	ret =3D __vmalloc(size, flags, PAGE_KERNEL);
+	ret =3D __vmalloc(size, flags);
 	if (ret) {
 		struct vm_area_struct *vma;
=20
@@ -230,7 +230,7 @@ long vwrite(char *buf, char *addr, unsigned long coun=
t)
  */
 void *vmalloc(unsigned long size)
 {
-       return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL);
+       return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM);
 }
 EXPORT_SYMBOL(vmalloc);
=20
@@ -248,8 +248,7 @@ EXPORT_SYMBOL(vmalloc);
  */
 void *vzalloc(unsigned long size)
 {
-	return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO,
-			PAGE_KERNEL);
+	return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO);
 }
 EXPORT_SYMBOL(vzalloc);
=20
@@ -302,7 +301,7 @@ EXPORT_SYMBOL(vzalloc_node);
=20
 void *vmalloc_exec(unsigned long size)
 {
-	return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL_EXEC);
+	return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM);
 }
=20
 /**
@@ -314,7 +313,7 @@ void *vmalloc_exec(unsigned long size)
  */
 void *vmalloc_32(unsigned long size)
 {
-	return __vmalloc(size, GFP_KERNEL, PAGE_KERNEL);
+	return __vmalloc(size, GFP_KERNEL);
 }
 EXPORT_SYMBOL(vmalloc_32);
=20
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 114c56c3685d..53d43f72bcd8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8237,7 +8237,7 @@ void *__init alloc_large_system_hash(const char *ta=
blename,
 				table =3D memblock_alloc_raw(size,
 							   SMP_CACHE_BYTES);
 		} else if (get_order(size) >=3D MAX_ORDER || hashdist) {
-			table =3D __vmalloc(size, gfp_flags, PAGE_KERNEL);
+			table =3D __vmalloc(size, gfp_flags);
 			virt =3D true;
 		} else {
 			/*
diff --git a/mm/percpu.c b/mm/percpu.c
index d7e3bc649f4e..1e278099e185 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -481,7 +481,7 @@ static void *pcpu_mem_zalloc(size_t size, gfp_t gfp)
 	if (size <=3D PAGE_SIZE)
 		return kzalloc(size, gfp);
 	else
-		return __vmalloc(size, gfp | __GFP_ZERO, PAGE_KERNEL);
+		return __vmalloc(size, gfp | __GFP_ZERO);
 }
=20
 /**
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 334c75251ddb..466a449b3a15 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2563,9 +2563,9 @@ static void *__vmalloc_node(unsigned long size, uns=
igned long align,
 				gfp_mask, prot, 0, node, caller);
 }
=20
-void *__vmalloc(unsigned long size, gfp_t gfp_mask, pgprot_t prot)
+void *__vmalloc(unsigned long size, gfp_t gfp_mask)
 {
-	return __vmalloc_node(size, 1, gfp_mask, prot, NUMA_NO_NODE,
+	return __vmalloc_node(size, 1, gfp_mask, PAGE_KERNEL, NUMA_NO_NODE,
 				__builtin_return_address(0));
 }
 EXPORT_SYMBOL(__vmalloc);
diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtab=
les.c
index 78db58c7aec2..7e869284e052 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1095,16 +1095,14 @@ static int do_replace(struct net *net, const void=
 __user *user,
 	tmp.name[sizeof(tmp.name) - 1] =3D 0;
=20
 	countersize =3D COUNTER_OFFSET(tmp.nentries) * nr_cpu_ids;
-	newinfo =3D __vmalloc(sizeof(*newinfo) + countersize, GFP_KERNEL_ACCOUN=
T,
-			    PAGE_KERNEL);
+	newinfo =3D __vmalloc(sizeof(*newinfo) + countersize, GFP_KERNEL_ACCOUN=
T);
 	if (!newinfo)
 		return -ENOMEM;
=20
 	if (countersize)
 		memset(newinfo->counters, 0, countersize);
=20
-	newinfo->entries =3D __vmalloc(tmp.entries_size, GFP_KERNEL_ACCOUNT,
-				     PAGE_KERNEL);
+	newinfo->entries =3D __vmalloc(tmp.entries_size, GFP_KERNEL_ACCOUNT);
 	if (!newinfo->entries) {
 		ret =3D -ENOMEM;
 		goto free_newinfo;
diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index a83553fbedf0..bea46ed157a6 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -143,7 +143,7 @@ int snd_dma_alloc_pages(int type, struct device *devi=
ce, size_t size,
 		break;
 	case SNDRV_DMA_TYPE_VMALLOC:
 		gfp =3D snd_mem_get_gfp_flags(device, GFP_KERNEL | __GFP_HIGHMEM);
-		dmab->area =3D __vmalloc(size, gfp, PAGE_KERNEL);
+		dmab->area =3D __vmalloc(size, gfp);
 		dmab->addr =3D 0;
 		break;
 #ifdef CONFIG_HAS_DMA
diff --git a/sound/core/pcm_memory.c b/sound/core/pcm_memory.c
index fcab37ea6641..860935e3aea4 100644
--- a/sound/core/pcm_memory.c
+++ b/sound/core/pcm_memory.c
@@ -460,7 +460,7 @@ int _snd_pcm_lib_alloc_vmalloc_buffer(struct snd_pcm_=
substream *substream,
 			return 0; /* already large enough */
 		vfree(runtime->dma_area);
 	}
-	runtime->dma_area =3D __vmalloc(size, gfp_flags, PAGE_KERNEL);
+	runtime->dma_area =3D __vmalloc(size, gfp_flags);
 	if (!runtime->dma_area)
 		return -ENOMEM;
 	runtime->dma_bytes =3D size;
--=20
2.25.1

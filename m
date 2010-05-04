From: Takuya Yoshikawa <takuya.yoshikawa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC][PATCH 3/12] KVM: introduce wrapper functions to create and
 destroy dirty bitmaps
Date: Tue, 4 May 2010 22:01:22 +0900
Message-ID: <20100504220122.0706ea6b.takuya.yoshikawa@gmail.com>
References: <20100504215645.6448af8f.takuya.yoshikawa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-ppc-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100504215645.6448af8f.takuya.yoshikawa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: kvm-ppc-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takuya Yoshikawa <takuya.yoshikawa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: avi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, yoshikawa.takuya-gVGce1chcLdL9jVzuh4AOg@public.gmane.org, fernando-gVGce1chcLdL9jVzuh4AOg@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-ppc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

We will change the vmalloc() and vfree() to do_mmap() and do_munmap() later.
This patch makes it easy and cleanup the code.

Signed-off-by: Takuya Yoshikawa <yoshikawa.takuya-gVGce1chcLdL9jVzuh4AOg@public.gmane.org>
Signed-off-by: Fernando Luis Vazquez Cao <fernando-gVGce1chcLdL9jVzuh4AOg@public.gmane.org>
---
 virt/kvm/kvm_main.c |   27 ++++++++++++++++++++-------
 1 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 7ab6312..3e3acad 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -435,6 +435,12 @@ out_err_nodisable:
 	return ERR_PTR(r);
 }
 
+static void kvm_destroy_dirty_bitmap(struct kvm_memory_slot *memslot)
+{
+	vfree(memslot->dirty_bitmap);
+	memslot->dirty_bitmap = NULL;
+}
+
 /*
  * Free any memory in @free but not in @dont.
  */
@@ -447,7 +453,7 @@ static void kvm_free_physmem_slot(struct kvm_memory_slot *free,
 		vfree(free->rmap);
 
 	if (!dont || free->dirty_bitmap != dont->dirty_bitmap)
-		vfree(free->dirty_bitmap);
+		kvm_destroy_dirty_bitmap(free);
 
 
 	for (i = 0; i < KVM_NR_PAGE_SIZES - 1; ++i) {
@@ -458,7 +464,6 @@ static void kvm_free_physmem_slot(struct kvm_memory_slot *free,
 	}
 
 	free->npages = 0;
-	free->dirty_bitmap = NULL;
 	free->rmap = NULL;
 }
 
@@ -520,6 +525,18 @@ static int kvm_vm_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static int kvm_create_dirty_bitmap(struct kvm_memory_slot *memslot)
+{
+	unsigned long dirty_bytes = kvm_dirty_bitmap_bytes(memslot);
+
+	memslot->dirty_bitmap = vmalloc(dirty_bytes);
+	if (!memslot->dirty_bitmap)
+		return -ENOMEM;
+
+	memset(memslot->dirty_bitmap, 0, dirty_bytes);
+	return 0;
+}
+
 /*
  * Allocate some memory and give it an address in the guest physical address
  * space.
@@ -653,12 +670,8 @@ skip_lpage:
 
 	/* Allocate page dirty bitmap if needed */
 	if ((new.flags & KVM_MEM_LOG_DIRTY_PAGES) && !new.dirty_bitmap) {
-		unsigned long dirty_bytes = kvm_dirty_bitmap_bytes(&new);
-
-		new.dirty_bitmap = vmalloc(dirty_bytes);
-		if (!new.dirty_bitmap)
+		if (kvm_create_dirty_bitmap(&new) < 0)
 			goto out_free;
-		memset(new.dirty_bitmap, 0, dirty_bytes);
 		/* destroy any largepage mappings for dirty tracking */
 		if (old.npages)
 			flush_shadow = 1;
-- 
1.7.0.4

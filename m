Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268836AbUIHAob@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:52374 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268828AbUIHAob (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Sep 2004 20:44:31 -0400
Date: Wed, 8 Sep 2004 10:43:44 +1000
From: Anton Blanchard <anton@samba.org>
Subject: [PATCH] [ppc64] Fix compat NUMA API on big endian 64bit
Message-ID: <20040908004344.GE25278@krispykreme>
References: <Pine.LNX.4.58.0409042055460.2331@ppc970.osdl.org> <20040904211749.3f713a8a.pj@sgi.com> <20040904215205.0a067ab8.pj@sgi.com> <20040906182330.GA79122@muc.de> <Pine.LNX.4.58.0409061147220.28608@ppc970.osdl.org> <20040906141142.663941fb.pj@sgi.com> <Pine.LNX.4.58.0409070736100.2299@ppc970.osdl.org> <20040908002408.GA25278@krispykreme> <20040908003359.GC25278@krispykreme> <20040908004040.GD25278@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908004040.GD25278@krispykreme>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, ak@muc.de, Andrew Morton <akpm@osdl.org>, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>


Switch the NUMA API to use compat_get_bitmap/compat_put_bitmap. In order
to use compat_alloc_userspace instead of set_fs tricks, we have to do a
few copies.

This is what we are currently using on ppc64 but are willing to
entertain the idea of going to a 32bit bitmap, especially considering
how much hoops we have to go through to get it right in this patch.

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN mm/mempolicy.c~numa_api mm/mempolicy.c
--- gr_work/mm/mempolicy.c~numa_api	2004-09-04 21:14:44.595414365 -0500
+++ gr_work-anton/mm/mempolicy.c	2004-09-05 09:19:10.475691107 -0500
@@ -525,20 +525,82 @@ asmlinkage long sys_get_mempolicy(int __
 }
 
 #ifdef CONFIG_COMPAT
-/* The other functions are compatible */
+
 asmlinkage long compat_get_mempolicy(int __user *policy,
-				  unsigned __user *nmask, unsigned  maxnode,
-				  unsigned addr, unsigned  flags)
+				     compat_ulong_t __user *nmask,
+				     compat_ulong_t maxnode,
+				     compat_ulong_t addr, compat_ulong_t flags)
 {
 	long err;
 	unsigned long __user *nm = NULL;
+	unsigned long nr_bits, alloc_size;
+	DECLARE_BITMAP(bm, MAX_NUMNODES);
+
+	nr_bits = min_t(unsigned long, maxnode-1, MAX_NUMNODES);
+	alloc_size = ALIGN(nr_bits, BITS_PER_LONG) / 8;
+
 	if (nmask)
-		nm = compat_alloc_user_space(ALIGN(maxnode-1, 64) / 8);
-	err = sys_get_mempolicy(policy, nm, maxnode, addr, flags);
-	if (!err && copy_in_user(nmask, nm, ALIGN(maxnode-1, 32)/8))
-		err = -EFAULT;
+		nm = compat_alloc_user_space(alloc_size);
+
+	err = sys_get_mempolicy(policy, nm, nr_bits+1, addr, flags);
+
+	if (!err && nmask) {
+		err = copy_from_user(bm, nm, alloc_size);
+		/* ensure entire bitmap is zeroed */
+		err |= clear_user(nmask, ALIGN(maxnode-1, 8) / 8);
+		err |= compat_put_bitmap(nmask, bm, nr_bits);
+	}
+
 	return err;
 }
+
+asmlinkage long compat_set_mempolicy(int mode, compat_ulong_t __user *nmask,
+				     compat_ulong_t maxnode)
+{
+	long err;
+	unsigned long __user *nm = NULL;
+	unsigned long nr_bits, alloc_size;
+	DECLARE_BITMAP(bm, MAX_NUMNODES);
+
+	nr_bits = min_t(unsigned long, maxnode-1, MAX_NUMNODES);
+	alloc_size = ALIGN(nr_bits, BITS_PER_LONG) / 8;
+
+	if (nmask) {
+		err = compat_get_bitmap(bm, nmask, nr_bits);
+		nm = compat_alloc_user_space(alloc_size);
+		err |= copy_to_user(nm, bm, alloc_size);
+	}
+
+	if (err)
+		return -EFAULT;
+
+	return sys_set_mempolicy(mode, nm, nr_bits+1);
+}
+
+asmlinkage long compat_mbind(compat_ulong_t start, compat_ulong_t len,
+			     compat_ulong_t mode, compat_ulong_t __user *nmask,
+			     compat_ulong_t maxnode, compat_ulong_t flags)
+{
+	long err;
+	unsigned long __user *nm = NULL;
+	unsigned long nr_bits, alloc_size;
+	DECLARE_BITMAP(bm, MAX_NUMNODES);
+
+	nr_bits = min_t(unsigned long, maxnode-1, MAX_NUMNODES);
+	alloc_size = ALIGN(nr_bits, BITS_PER_LONG) / 8;
+
+	if (nmask) {
+		err = compat_get_bitmap(bm, nmask, nr_bits);
+		nm = compat_alloc_user_space(alloc_size);
+		err |= copy_to_user(nm, bm, alloc_size);
+	}
+
+	if (err)
+		return -EFAULT;
+
+	return sys_mbind(start, len, mode, nm, nr_bits+1, flags);
+}
+
 #endif
 
 /* Return effective policy for a VMA */

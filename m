Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268824AbUIHAjS@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:45206 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268817AbUIHAjS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Sep 2004 20:39:18 -0400
Date: Wed, 8 Sep 2004 10:33:59 +1000
From: Anton Blanchard <anton@samba.org>
Subject: [PATCH] [ppc64] compat_get_bitmap/compat_put_bitmap
Message-ID: <20040908003359.GC25278@krispykreme>
References: <Pine.LNX.4.58.0409041827280.2331@ppc970.osdl.org> <20040904204850.48b7cfbd.pj@sgi.com> <Pine.LNX.4.58.0409042055460.2331@ppc970.osdl.org> <20040904211749.3f713a8a.pj@sgi.com> <20040904215205.0a067ab8.pj@sgi.com> <20040906182330.GA79122@muc.de> <Pine.LNX.4.58.0409061147220.28608@ppc970.osdl.org> <20040906141142.663941fb.pj@sgi.com> <Pine.LNX.4.58.0409070736100.2299@ppc970.osdl.org> <20040908002408.GA25278@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908002408.GA25278@krispykreme>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, ak@muc.de, Andrew Morton <akpm@osdl.org>, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>


Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN kernel/compat.c~compat_bitmap kernel/compat.c
--- gr_work/kernel/compat.c~compat_bitmap	2004-09-04 00:56:24.297280051 -0500
+++ gr_work-anton/kernel/compat.c	2004-09-04 00:56:24.313277511 -0500
@@ -590,3 +590,83 @@ long compat_clock_nanosleep(clockid_t wh
 
 /* timer_create is architecture specific because it needs sigevent conversion */
 
+long compat_get_bitmap(unsigned long *mask, compat_ulong_t __user *umask,
+		       unsigned long bitmap_size)
+{
+	int i, j;
+	unsigned long m;
+	compat_ulong_t um;
+	unsigned long nr_compat_longs;
+
+	/* align bitmap up to nearest compat_long_t boundary */
+	bitmap_size = ALIGN(bitmap_size, BITS_PER_COMPAT_LONG);
+
+	if (verify_area(VERIFY_READ, umask, bitmap_size / 8))
+		return -EFAULT;
+
+	nr_compat_longs = BITS_TO_COMPAT_LONGS(bitmap_size);
+
+	for (i = 0; i < BITS_TO_LONGS(bitmap_size); i++) {
+		m = 0;
+
+		for (j = 0; j < sizeof(m)/sizeof(um); j++) {
+			/*
+			 * We dont want to read past the end of the userspace
+			 * bitmap. We must however ensure the end of the
+			 * kernel bitmap is zeroed.
+			 */
+			if (nr_compat_longs-- > 0) {
+				if (__get_user(um, umask))
+					return -EFAULT;
+			} else {
+				um = 0;
+			}
+
+			umask++;
+			m |= (long)um << (j * BITS_PER_COMPAT_LONG);
+		}
+		*mask++ = m;
+	}
+
+	return 0;
+}
+
+long compat_put_bitmap(compat_ulong_t __user *umask, unsigned long *mask,
+		       unsigned long bitmap_size)
+{
+	int i, j;
+	unsigned long m;
+	compat_ulong_t um;
+	unsigned long nr_compat_longs;
+
+	/* align bitmap up to nearest compat_long_t boundary */
+	bitmap_size = ALIGN(bitmap_size, BITS_PER_COMPAT_LONG);
+
+	if (verify_area(VERIFY_WRITE, umask, bitmap_size / 8))
+		return -EFAULT;
+
+	nr_compat_longs = BITS_TO_COMPAT_LONGS(bitmap_size);
+
+	for (i = 0; i < BITS_TO_LONGS(bitmap_size); i++) {
+		m = *mask++;
+
+		for (j = 0; j < sizeof(m)/sizeof(um); j++) {
+			um = m;
+
+			/*
+			 * We dont want to write past the end of the userspace
+			 * bitmap.
+			 */
+			if (nr_compat_longs-- > 0) {
+				if (__put_user(um, umask))
+					return -EFAULT;
+			}
+
+			umask++;
+			m >>= 4*sizeof(um);
+			m >>= 4*sizeof(um);
+		}
+	}
+
+	return 0;
+}
diff -puN include/linux/compat.h~compat_bitmap include/linux/compat.h
--- gr_work/include/linux/compat.h~compat_bitmap	2004-09-04 00:56:24.302279257 -0500
+++ gr_work-anton/include/linux/compat.h	2004-09-04 00:56:24.314277352 -0500
@@ -132,5 +132,15 @@ asmlinkage long compat_sys_select(int n,
 		compat_ulong_t __user *outp, compat_ulong_t __user *exp,
 		struct compat_timeval __user *tvp);
 
+#define BITS_PER_COMPAT_LONG    (8*sizeof(compat_long_t))
+
+#define BITS_TO_COMPAT_LONGS(bits) \
+	(((bits)+BITS_PER_COMPAT_LONG-1)/BITS_PER_COMPAT_LONG)
+
+long compat_get_bitmap(unsigned long *mask, compat_ulong_t __user *umask,
+		       unsigned long bitmap_size);
+long compat_put_bitmap(compat_ulong_t __user *umask, unsigned long *mask,
+		       unsigned long bitmap_size);
+
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */
_

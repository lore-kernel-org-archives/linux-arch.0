From: Takuya Yoshikawa <takuya.yoshikawa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC][PATCH 7/12 not tested yet] PPC: introduce __set_bit() like
 function for bitmaps in user space
Date: Tue, 4 May 2010 22:04:18 +0900
Message-ID: <20100504220418.083929bc.takuya.yoshikawa@gmail.com>
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

During the work of KVM's dirty page logging optimization, we encountered
the need of manipulating bitmaps in user space efficiantly. To achive this,
we introduce a uaccess function for setting a bit in user space following
Avi's suggestion.

  KVM is now using dirty bitmaps for live-migration and VGA. Although we need
  to update them from kernel side, copying them every time for updating the
  dirty log is a big bottleneck. Especially, we tested that zero-copy bitmap
  manipulation improves responses of GUI manipulations a lot.

We also found one similar need in drivers/vhost/vhost.c in which the author
implemented set_bit_to_user() locally using inefficient functions: see TODO
at the top of that.

Probably, this kind of need would be common for virtualization area.

So we introduce a function set_bit_user_non_atomic().

Signed-off-by: Takuya Yoshikawa <yoshikawa.takuya-gVGce1chcLdL9jVzuh4AOg@public.gmane.org>
Signed-off-by: Fernando Luis Vazquez Cao <fernando-gVGce1chcLdL9jVzuh4AOg@public.gmane.org>
CC: Alexander Graf <agraf-l3A5Bk7waGM@public.gmane.org>
CC: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
CC: Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
---
 arch/powerpc/include/asm/uaccess.h |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 3a01ce8..f878326 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -321,6 +321,25 @@ do {								\
 	__gu_err;						\
 })
 
+static inline int set_bit_user_non_atomic(int nr, void __user *addr)
+{
+	u8 __user *p;
+	u8 val;
+
+	p = (u8 __user *)((unsigned long)addr + nr / BITS_PER_BYTE);
+	if (!access_ok(VERIFY_WRITE, p, 1))
+		return -EFAULT;
+
+	if (__get_user(val, p))
+		return -EFAULT;
+
+	val |= 1U << (nr % BITS_PER_BYTE);
+	if (__put_user(val, p))
+		return -EFAULT;
+
+	return 0;
+}
+
 
 /* more complex routines */
 
-- 
1.7.0.4

From: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Subject: - kvm-provide-kvmh-for-all-architecture-fixes-headers_install.patch removed from -mm tree
Date: Mon, 10 Mar 2008 23:12:46 -0700
Message-ID: <200803110622.m2B6MJRi026108@imap1.linux-foundation.org>
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: borntraeger-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org, avi-atKUWr5tajBWk0Htik3J/w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org, mm-commits-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


The patch titled
     kvm: provide kvm.h for all architecture: fixes headers_install
has been removed from the -mm tree.  Its filename was
     kvm-provide-kvmh-for-all-architecture-fixes-headers_install.patch

This patch was dropped because it had testing failures

The current -mm tree may be found at http://userweb.kernel.org/~akpm/mmotm/

------------------------------------------------------
Subject: kvm: provide kvm.h for all architecture: fixes headers_install
From: Christian Borntraeger <borntraeger-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>

Currently include/linux/kvm.h is not considered by make headers_install,
because Kbuild cannot handle " unifdef-$(CONFIG_FOO) += foo.h.  This problem
was introduced by 040922c04cf2c8ac70be2e88a8a9614ecdb41d2e, which makes this
an 2.6.25 regression.

One way of solving the issue is to enhance Kbuild, but Avi and David conviced
me, that changing headers_install is not the way to go.  This patch changes
the definition for linux/kvm.h to unifdef-y.

If unifdef-y is used for linux/kvm.h "make headers_check" will fail on all
architectures without asm/kvm.h.  Therefore, this patch also provides
asm/kvm.h on all architectures.

Signed-off-by: Christian Borntraeger <borntraeger-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
Acked-by: Avi Kivity <avi-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
Cc: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
---

 include/asm-alpha/kvm.h     |    6 ++++++
 include/asm-arm/kvm.h       |    6 ++++++
 include/asm-avr32/kvm.h     |    6 ++++++
 include/asm-blackfin/kvm.h  |    6 ++++++
 include/asm-cris/kvm.h      |    6 ++++++
 include/asm-frv/kvm.h       |    6 ++++++
 include/asm-h8300/kvm.h     |    6 ++++++
 include/asm-ia64/kvm.h      |    6 ++++++
 include/asm-m32r/kvm.h      |    6 ++++++
 include/asm-m68k/kvm.h      |    6 ++++++
 include/asm-m68knommu/kvm.h |    6 ++++++
 include/asm-mips/kvm.h      |    6 ++++++
 include/asm-mn10300/kvm.h   |    6 ++++++
 include/asm-parisc/kvm.h    |    6 ++++++
 include/asm-powerpc/kvm.h   |    6 ++++++
 include/asm-s390/kvm.h      |    6 ++++++
 include/asm-sh/kvm.h        |    6 ++++++
 include/asm-sparc/kvm.h     |    6 ++++++
 include/asm-sparc64/kvm.h   |    6 ++++++
 include/asm-v850/kvm.h      |    6 ++++++
 include/asm-xtensa/kvm.h    |    6 ++++++
 include/linux/Kbuild        |    2 +-
 22 files changed, 127 insertions(+), 1 deletion(-)

diff -puN /dev/null include/asm-alpha/kvm.h
--- /dev/null
+++ a/include/asm-alpha/kvm.h
@@ -0,0 +1,6 @@
+#ifndef __LINUX_KVM_ALPHA_H
+#define __LINUX_KVM_ALPHA_H
+
+/* alpha does not support KVM */
+
+#endif
diff -puN /dev/null include/asm-arm/kvm.h
--- /dev/null
+++ a/include/asm-arm/kvm.h
@@ -0,0 +1,6 @@
+#ifndef __LINUX_KVM_ARM_H
+#define __LINUX_KVM_ARM_H
+
+/* arm does not support KVM */
+
+#endif
diff -puN /dev/null include/asm-avr32/kvm.h
--- /dev/null
+++ a/include/asm-avr32/kvm.h
@@ -0,0 +1,6 @@
+#ifndef __LINUX_KVM_AVR32_H
+#define __LINUX_KVM_AVR32_H
+
+/* avr32 does not support KVM */
+
+#endif
diff -puN /dev/null include/asm-blackfin/kvm.h
--- /dev/null
+++ a/include/asm-blackfin/kvm.h
@@ -0,0 +1,6 @@
+#ifndef __LINUX_KVM_BLACKFIN_H
+#define __LINUX_KVM_BLACKFIN_H
+
+/* blackfin does not support KVM */
+
+#endif
diff -puN /dev/null include/asm-cris/kvm.h
--- /dev/null
+++ a/include/asm-cris/kvm.h
@@ -0,0 +1,6 @@
+#ifndef __LINUX_KVM_CRIS_H
+#define __LINUX_KVM_CRIS_H
+
+/* cris does not support KVM */
+
+#endif
diff -puN /dev/null include/asm-frv/kvm.h
--- /dev/null
+++ a/include/asm-frv/kvm.h
@@ -0,0 +1,6 @@
+#ifndef __LINUX_KVM_FRV_H
+#define __LINUX_KVM_FRV_H
+
+/* frv does not support KVM */
+
+#endif
diff -puN /dev/null include/asm-h8300/kvm.h
--- /dev/null
+++ a/include/asm-h8300/kvm.h
@@ -0,0 +1,6 @@
+#ifndef __LINUX_KVM_H8300_H
+#define __LINUX_KVM_H8300_H
+
+/* h8300 does not support KVM */
+
+#endif
diff -puN /dev/null include/asm-ia64/kvm.h
--- /dev/null
+++ a/include/asm-ia64/kvm.h
@@ -0,0 +1,6 @@
+#ifndef __LINUX_KVM_IA64_H
+#define __LINUX_KVM_IA64_H
+
+/* ia64 does not support KVM */
+
+#endif
diff -puN /dev/null include/asm-m32r/kvm.h
--- /dev/null
+++ a/include/asm-m32r/kvm.h
@@ -0,0 +1,6 @@
+#ifndef __LINUX_KVM_M32R_H
+#define __LINUX_KVM_M32R_H
+
+/* m32r does not support KVM */
+
+#endif
diff -puN /dev/null include/asm-m68k/kvm.h
--- /dev/null
+++ a/include/asm-m68k/kvm.h
@@ -0,0 +1,6 @@
+#ifndef __LINUX_KVM_M68K_H
+#define __LINUX_KVM_M68K_H
+
+/* m68k does not support KVM */
+
+#endif
diff -puN /dev/null include/asm-m68knommu/kvm.h
--- /dev/null
+++ a/include/asm-m68knommu/kvm.h
@@ -0,0 +1,6 @@
+#ifndef __LINUX_KVM_M68KNOMMU_H
+#define __LINUX_KVM_M68KNOMMU_H
+
+/* m68knommu does not support KVM */
+
+#endif
diff -puN /dev/null include/asm-mips/kvm.h
--- /dev/null
+++ a/include/asm-mips/kvm.h
@@ -0,0 +1,6 @@
+#ifndef __LINUX_KVM_MIPS_H
+#define __LINUX_KVM_MIPS_H
+
+/* mips does not support KVM */
+
+#endif
diff -puN /dev/null include/asm-mn10300/kvm.h
--- /dev/null
+++ a/include/asm-mn10300/kvm.h
@@ -0,0 +1,6 @@
+#ifndef __LINUX_KVM_MN10300_H
+#define __LINUX_KVM_MN10300_H
+
+/* mn10300 does not support KVM */
+
+#endif
diff -puN /dev/null include/asm-parisc/kvm.h
--- /dev/null
+++ a/include/asm-parisc/kvm.h
@@ -0,0 +1,6 @@
+#ifndef __LINUX_KVM_PARISC_H
+#define __LINUX_KVM_PARISC_H
+
+/* parisc does not support KVM */
+
+#endif
diff -puN /dev/null include/asm-powerpc/kvm.h
--- /dev/null
+++ a/include/asm-powerpc/kvm.h
@@ -0,0 +1,6 @@
+#ifndef __LINUX_KVM_POWERPC_H
+#define __LINUX_KVM_POWERPC_H
+
+/* powerpc does not support KVM */
+
+#endif
diff -puN /dev/null include/asm-s390/kvm.h
--- /dev/null
+++ a/include/asm-s390/kvm.h
@@ -0,0 +1,6 @@
+#ifndef __LINUX_KVM_S390_H
+#define __LINUX_KVM_S390_H
+
+/* s390 does not support KVM */
+
+#endif
diff -puN /dev/null include/asm-sh/kvm.h
--- /dev/null
+++ a/include/asm-sh/kvm.h
@@ -0,0 +1,6 @@
+#ifndef __LINUX_KVM_SH_H
+#define __LINUX_KVM_SH_H
+
+/* sh does not support KVM */
+
+#endif
diff -puN /dev/null include/asm-sparc/kvm.h
--- /dev/null
+++ a/include/asm-sparc/kvm.h
@@ -0,0 +1,6 @@
+#ifndef __LINUX_KVM_SPARC_H
+#define __LINUX_KVM_SPARC_H
+
+/* sparc does not support KVM */
+
+#endif
diff -puN /dev/null include/asm-sparc64/kvm.h
--- /dev/null
+++ a/include/asm-sparc64/kvm.h
@@ -0,0 +1,6 @@
+#ifndef __LINUX_KVM_SPARC64_H
+#define __LINUX_KVM_SPARC64_H
+
+/* sparc64 does not support KVM */
+
+#endif
diff -puN /dev/null include/asm-v850/kvm.h
--- /dev/null
+++ a/include/asm-v850/kvm.h
@@ -0,0 +1,6 @@
+#ifndef __LINUX_KVM_V850_H
+#define __LINUX_KVM_V850_H
+
+/* v850 does not support KVM */
+
+#endif
diff -puN /dev/null include/asm-xtensa/kvm.h
--- /dev/null
+++ a/include/asm-xtensa/kvm.h
@@ -0,0 +1,6 @@
+#ifndef __LINUX_KVM_XTENSA_H
+#define __LINUX_KVM_XTENSA_H
+
+/* xtensa does not support KVM */
+
+#endif
diff -puN include/linux/Kbuild~kvm-provide-kvmh-for-all-architecture-fixes-headers_install include/linux/Kbuild
--- a/include/linux/Kbuild~kvm-provide-kvmh-for-all-architecture-fixes-headers_install
+++ a/include/linux/Kbuild
@@ -257,7 +257,7 @@ unifdef-y += kd.h
 unifdef-y += kernelcapi.h
 unifdef-y += kernel.h
 unifdef-y += keyboard.h
-unifdef-$(CONFIG_HAVE_KVM) += kvm.h
+unifdef-y += kvm.h
 unifdef-y += llc.h
 unifdef-y += loop.h
 unifdef-y += lp.h
_

Patches currently in -mm which might be from borntraeger-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org are

kvm-provide-kvmh-for-all-architecture-fixes-headers_install.patch
git-kvm.patch

--
To unsubscribe from this list: send the line "unsubscribe linux-arch" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

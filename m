From: Hitoshi Mitake <h.mitake@gmail.com>
Subject: Re: [PATCH 1/1] edac x38: new MC driver module
Date: Tue, 25 Nov 2008 11:55:10 +0900
Message-ID: <20081125115510.108fa886.h.mitake@gmail.com>
References: <20081105222911.d76e7e1c.mitake@clustcom.com>
	<413709.12821.qm@web50106.mail.re2.yahoo.com>
	<20081106164641.ed369060.akpm@linux-foundation.org>
	<20081107152830.a42766f3.mitake@clustcom.com>
	<20081106223122.8a255211.akpm@linux-foundation.org>
	<20081107153824.0ec934e6.mitake@clustcom.com>
	<20081106231102.aab83cd4.akpm@linux-foundation.org>
	<a6b9f31a0811090710y17e956bawf20675d6678b145e@mail.gmail.com>
	<20081109112646.97c594b5.akpm@linux-foundation.org>
	<20081118121620.GB8625@linux-mips.org>
	<20081118123215.GB30509@flint.arm.linux.org.uk>
	<20081121011941.26e05a25.h.mitake@gmail.com>
	<4929ECB7.8080108@zytor.com>
	<57C9024A16AD2D4C97DC78E552063EA35C517F42@orsmsx505.amr.corp.intel.com>
	<492AEC40.5060009@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:10551 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751AbYKYCzQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 24 Nov 2008 21:55:16 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1126609wah.21
        for <linux-arch@vger.kernel.org>; Mon, 24 Nov 2008 18:55:15 -0800 (PST)
In-Reply-To: <492AEC40.5060009@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, Russell King <rmk+lkml@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@linux-foundation.org>, Doug Thompson <norsk5@yahoo.com>, "dougthompson@xmission.com" <dougthompson@xmission.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Mon, 24 Nov 2008 10:02:40 -0800
"H. Peter Anvin" <hpa@zytor.com> wrote:

Thanks for your reviews and advices, Peter and Tony.

> Luck, Tony wrote:
> >>       volatile u32 __iomem *__p = addr;
> >>       u32 __l, __h;
> > 
> > Do we really need all the "__" inside an inline function?  Why
> > not just call these "p", "l" and "h"?
> 
> Sorry, user space habit (in userspace, and in anything that can be
> included from userspace, one needs the __ to keep the namespace clean.)

I think which need __ is variable type name, not each variable name.
Name of each local variables can't effect namespace.
And I found this comment in asm-generic/int-ll64.h,
/*
 * __xx is ok: it doesn't pollute the POSIX namespace. Use these in the
 * header files exported to user space
 */

According to your advice, I rewrote the patch, how is this?

description of this patch: Adding config value to x86 architecture to determine existence of readq/writeq

Signed-off-by: Hitoshi Mitake <h.mitake@gmail.com>
---
 arch/x86/Kconfig          |    3 +++
 arch/x86/include/asm/io.h |   17 +++++++++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ac22bb7..8f3c949 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -11,9 +11,12 @@ config 64BIT
 
 config X86_32
 	def_bool !64BIT
+	select ARCH_HAS_READQ
 
 config X86_64
 	def_bool 64BIT
+	select ARCH_HAS_READQ
+	select ARCH_HAS_WRITEQ
 
 ### Arch settings
 config X86
diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index ac2abc8..5322d18 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -4,6 +4,7 @@
 #define ARCH_HAS_IOREMAP_WC
 
 #include <linux/compiler.h>
+#include <asm-generic/int-ll64.h>
 
 #define build_mmio_read(name, size, type, reg, barrier) \
 static inline type name(const volatile void __iomem *addr) \
@@ -57,6 +58,22 @@ build_mmio_write(__writeq, "q", unsigned long, "r", )
 /* Let people know we have them */
 #define readq readq
 #define writeq writeq
+
+#else  /* CONFIG_X86_32 from here */
+
+static inline __u64 readq(const volatile void __iomem *addr)
+{
+	const volatile u32 __iomem *p = addr;
+	u32 l, h;
+
+	l = readl(p);
+	h = readl(p+1);
+
+	return l + ((u64)h << 32);
+}
+
+#define readq readq
+
 #endif
 
 extern int iommu_bio_merge;
-- 
1.5.6.5

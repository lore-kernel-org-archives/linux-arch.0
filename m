Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58714 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727662AbeKIWS1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Nov 2018 17:18:27 -0500
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 05/27] kernel: Add clock_mode support
Date: Fri,  9 Nov 2018 12:37:08 +0000
Message-ID: <20181109123730.8743-6-vincenzo.frascino@arm.com>
In-Reply-To: <20181109123730.8743-1-vincenzo.frascino@arm.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20181109123708.IFtrv8qO1aFTBN271Tfx0PkUWsTHimHa2SMbx1DcsBw@z>

Some architectures store the clock mode into the vDSO datapage,
consequently the generic datapage needs to be aligned to expose this
information.

This patch adds support for clock_mode in datapage.h.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/vdso/datapage.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index fb6ce4c3f2d0..9a934158f1b8 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -43,6 +43,7 @@ struct vdso_data {
 	__u32 tz_minuteswest;	/* Whacky timezone stuff */
 	__u32 tz_dsttime;
 	__u32 use_syscall;
+	__u32 clock_mode;
 };
 
 #endif /* !__ASSEMBLY__ */
-- 
2.19.1

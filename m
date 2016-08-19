Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754462AbcHSVrZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Aug 2016 17:47:25 -0400
From: mcgrof@kernel.org
Subject: [PATCH v4 02/16] dell-smo8800: include uaccess.h
Date: Fri, 19 Aug 2016 14:32:51 -0700
Message-ID: <1471642385-5629-3-git-send-email-mcgrof@kernel.org>
In-Reply-To: <1471642385-5629-1-git-send-email-mcgrof@kernel.org>
References: <1471642385-5629-1-git-send-email-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, jpoimboe@redhat.com, bp@alien8.de, linux@arm.linux.org.uk, mhiramat@kernel.org, masami.hiramatsu.pt@hitachi.com, jbaron@akamai.com, heiko.carstens@de.ibm.com, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, realmz6@gmail.com
Cc: x86@kernel.org, luto@amacapital.net, keescook@chromium.org, torvalds@linux-foundation.org, gregkh@linuxfoundation.org, rusty@rustcorp.com.au, gnomes@lxorguk.ukuu.org.uk, alan@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, ming.lei@canonical.com, linux-arch@vger.kernel.org, benh@kernel.crashing.org, ananth@in.ibm.com, pebolle@tiscali.nl, fontana@sharpeleven.org, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, andrew.cooper3@citrix.com, andriy.shevchenko@linux.intel.com, paul.gortmaker@windriver.com, xen-devel@lists.xensource.com, ak@linux.intel.com, pali.rohar@gmail.com, dvhart@infradead.org, platform-driver-x86@vger.kernel.org, mmarek@suse.com, linux@rasmusvillemoes.dk, jkosina@suse.cz, korea.drzix@gmail.com, linux-kbuild@vger.kernel.org, tony.luck@intel.com, akpm@linux-foundation.org, linux-ia64@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, rostedt@goodmis.org, jani.nikula@intel.com, mchehab@osg.samsung.com, markus.heiser@darmarit.de, acme@redhat.com, jolsa@kernel.org, msalter@redhat.com, chris@zankel.net, jcmvbkbc@gmail.com, linux-xtensa@linux-xtensa.org, paulus@samba.org, mpe@ellerman.id.au, James.Bottomley@HansenPartnership.com, "Luis R. Rodriguez" <mcgrof@kernel.org>
Message-ID: <20160819213251.dQzG5MtThL4DrWfKf2ov5SYZp3SpjmaJ72-M3dw7Qdc@z>

From: "Luis R. Rodriguez" <mcgrof@kernel.org>

sections.h is currently included and it provides dell-smo8800
with what it needs, an upcoming change will decouple uaccess.h
from sections.h. This driver needs to explicitly require uaccess.h
before this change.

v3: new to this series -- needed due to collateral of the split of
    old linker tables from tables.h into 3 files: sections.h, ranges.h
    and tables.h

Reviewed-by: Pali Rohár <pali.rohar@gmail.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 drivers/platform/x86/dell-smo8800.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/dell-smo8800.c b/drivers/platform/x86/dell-smo8800.c
index 0aec4fd4c48e..37e646034ef8 100644
--- a/drivers/platform/x86/dell-smo8800.c
+++ b/drivers/platform/x86/dell-smo8800.c
@@ -24,6 +24,7 @@
 #include <linux/acpi.h>
 #include <linux/interrupt.h>
 #include <linux/miscdevice.h>
+#include <linux/uaccess.h>
 
 struct smo8800_device {
 	u32 irq;                     /* acpi device irq */
-- 
2.9.2


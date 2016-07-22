Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53004 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754099AbcGVVZZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 22 Jul 2016 17:25:25 -0400
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [RFC v3 08/13] firmware/Makefile: force recompilation if makefile changes
Date: Fri, 22 Jul 2016 14:24:42 -0700
Message-ID: <1469222687-1600-9-git-send-email-mcgrof@kernel.org>
In-Reply-To: <1469222687-1600-1-git-send-email-mcgrof@kernel.org>
References: <1469222687-1600-1-git-send-email-mcgrof@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, linux@arm.linux.org.uk, mhiramat@kernel.org, masami.hiramatsu.pt@hitachi.com, jbaron@akamai.com, heiko.carstens@de.ibm.com, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, realmz6@gmail.com
Cc: x86@kernel.org, luto@amacapital.net, keescook@chromium.org, torvalds@linux-foundation.org, gregkh@linuxfoundation.org, rusty@rustcorp.com.au, gnomes@lxorguk.ukuu.org.uk, alan@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, ming.lei@canonical.com, linux-arch@vger.kernel.org, benh@kernel.crashing.org, ananth@in.ibm.com, pebolle@tiscali.nl, fontana@sharpeleven.org, ciaran.farrell@suse.com, christopher.denicolo@suse.com, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, andrew.cooper3@citrix.com, andriy.shevchenko@linux.intel.com, paul.gortmaker@windriver.com, xen-devel@lists.xensource.com, ak@linux.intel.com, pali.rohar@gmail.com, dvhart@infradead.org, platform-driver-x86@vger.kernel.org, mmarek@suse.com, linux@rasmusvillemoes.dk, jkosina@suse.cz, korea.drzix@gmail.com, linux-kbuild@vger.kernel.org, tony.luck@intel.com, akpm@linux-foundation.org, linux-ia64@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, rostedt@goodmis.org, jpoimboe@redhat.com, "Luis R. Rodriguez" <mcgrof@kernel.org>
Message-ID: <20160722212442.XoWjPhSG97RTaOkXbq8HBnuIwSW1cTKKqL00aZzO0dg@z>

If you modify the target asm we currently do not force the
recompilation of the firmware files. The target asm is in
the firmware/Makefile, peg this file as a dependency to
require re-compilation of firmware targets when the asm
changes.

v3: introduced in this series

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 firmware/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/firmware/Makefile b/firmware/Makefile
index e297e1b52636..fa3e81c2a97b 100644
--- a/firmware/Makefile
+++ b/firmware/Makefile
@@ -176,7 +176,8 @@ quiet_cmd_fwbin = MK_FW   $@
 wordsize_deps := $(wildcard include/config/64bit.h include/config/32bit.h \
 		include/config/ppc32.h include/config/ppc64.h \
 		include/config/superh32.h include/config/superh64.h \
-		include/config/x86_32.h include/config/x86_64.h)
+		include/config/x86_32.h include/config/x86_64.h \
+		firmware/Makefile)
 
 $(patsubst %,$(obj)/%.gen.S, $(fw-shipped-y)): %: $(wordsize_deps)
 	$(call cmd,fwbin,$(patsubst %.gen.S,%,$@))
-- 
2.8.4


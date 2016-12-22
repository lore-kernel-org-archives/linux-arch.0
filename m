From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v2 5/6] tools: add __section() to compiler.h
Date: Wed, 21 Dec 2016 18:39:57 -0800
Message-ID: <20161222023958.21306-6-mcgrof@kernel.org>
References: <1471642875-5957-1-git-send-email-mcgrof@kernel.org>
 <20161222023958.21306-1-mcgrof@kernel.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938528AbcLVCk0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Dec 2016 21:40:26 -0500
In-Reply-To: <20161222023958.21306-1-mcgrof@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: hpa@zytor.com, acme@redhat.com, tglx@linutronix.de, mingo@redhat.com, jpoimboe@redhat.com, bp@alien8.de, npiggin@gmail.com, mhiramat@kernel.org, masami.hiramatsu.pt@hitachi.com, jbaron@akamai.com, heiko.carstens@de.ibm.com, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, realmz6@gmail.com, dalias@libc.org, linux@arm.linux.org.uk
Cc: x86@kernel.org, luto@amacapital.net, keescook@chromium.org, linux@roeck-us.net, torvalds@linux-foundation.org, gregkh@linuxfoundation.org, rusty@rustcorp.com.au, gnomes@lxorguk.ukuu.org.uk, alan@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, ming.lei@canonical.com, linux-arch@vger.kernel.org, benh@kernel.crashing.org, pebolle@tiscali.nl, fontana@sharpeleven.org, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, andrew.cooper3@citrix.com, andriy.shevchenko@linux.intel.com, paul.gortmaker@windriver.com, xen-devel@lists.xensource.com, ak@linux.intel.com, pali.rohar@gmail.com, dvhart@infradead.org, platform-driver-x86@vger.kernel.org, mmarek@suse.com, linux@rasmusvillemoes.dk, jkosina@suse.cz, korea.drzix@gmail.com, linux-kbuild@vger.kernel

This will be used later by the userspace linker table.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 tools/include/linux/compiler.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 556c991de212..6321265df00a 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -132,4 +132,6 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 #define WRITE_ONCE(x, val) \
 	({ union { typeof(x) __val; char __c[1]; } __u = { .__val = (val) }; __write_once_size(&(x), __u.__c, sizeof(x)); __u.__val; })
 
+#define __section(S)	__attribute__ ((__section__(#S)))
+
 #endif /* _TOOLS_LINUX_COMPILER_H */
-- 
2.10.1

Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755712AbcHSVfJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Aug 2016 17:35:09 -0400
From: mcgrof@kernel.org
Subject: [PATCH v4 11/16] jump_label: move guard #endif down where it belongs
Date: Fri, 19 Aug 2016 14:34:09 -0700
Message-ID: <1471642454-5679-12-git-send-email-mcgrof@kernel.org>
In-Reply-To: <1471642454-5679-1-git-send-email-mcgrof@kernel.org>
References: <1471642454-5679-1-git-send-email-mcgrof@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, jpoimboe@redhat.com, bp@alien8.de, linux@arm.linux.org.uk, mhiramat@kernel.org, masami.hiramatsu.pt@hitachi.com, jbaron@akamai.com, heiko.carstens@de.ibm.com, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, realmz6@gmail.com
Cc: x86@kernel.org, luto@amacapital.net, keescook@chromium.org, torvalds@linux-foundation.org, gregkh@linuxfoundation.org, rusty@rustcorp.com.au, gnomes@lxorguk.ukuu.org.uk, alan@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, ming.lei@canonical.com, linux-arch@vger.kernel.org, benh@kernel.crashing.org, ananth@in.ibm.com, pebolle@tiscali.nl, fontana@sharpeleven.org, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, andrew.cooper3@citrix.com, andriy.shevchenko@linux.intel.com, paul.gortmaker@windriver.com, xen-devel@lists.xensource.com, ak@linux.intel.com, pali.rohar@gmail.com, dvhart@infradead.org, platform-driver-x86@vger.kernel.org, mmarek@suse.com, linux@rasmusvillemoes.dk, jkosina@suse.cz, korea.drzix@gmail.com, linux-kbuild@vger.kernel.org, tony.luck@intel.com, akpm@linux-foundation.org, linux-ia64@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, rostedt@goodmis.org, jani.nikula@intel.com, mchehab@osg.samsung.com, markus.heiser@darmarit.de, acme@redhat.com, jolsa@kernel.org, msalter@redhat.com, chris@zankel.net, jcmvbkbc@gmail.com, linux-xtensa@linux-xtensa.org, paulus@samba.org, mpe@ellerman.id.au, James.Bottomley@HansenPartnership.com, "Luis R. Rodriguez" <mcgrof@kernel.org>
Message-ID: <20160819213409.mku35cmo8_JNUZ_6jJfG2Jj8kzbjURkgvDYJNSnY47A@z>

From: "Luis R. Rodriguez" <mcgrof@kernel.org>

The ending header guard is misplaced. This has no
functional change, this is just an eye-sore.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 include/linux/jump_label.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 661af564fae8..1256f543b002 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -384,6 +384,6 @@ extern bool ____wrong_branch_error(void);
 #define static_branch_enable(x)		static_key_enable(&(x)->key)
 #define static_branch_disable(x)	static_key_disable(&(x)->key)
 
-#endif	/* _LINUX_JUMP_LABEL_H */
-
 #endif /* __ASSEMBLY__ */
+
+#endif	/* _LINUX_JUMP_LABEL_H */
-- 
2.9.2


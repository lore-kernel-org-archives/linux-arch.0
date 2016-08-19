Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754611AbcHSVey (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Aug 2016 17:34:54 -0400
From: mcgrof@kernel.org
Subject: [PATCH v4 05/16] xtensa: skip adding literal when SORT() is used
Date: Fri, 19 Aug 2016 14:32:54 -0700
Message-ID: <1471642385-5629-6-git-send-email-mcgrof@kernel.org>
In-Reply-To: <1471642385-5629-1-git-send-email-mcgrof@kernel.org>
References: <1471642385-5629-1-git-send-email-mcgrof@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, jpoimboe@redhat.com, bp@alien8.de, linux@arm.linux.org.uk, mhiramat@kernel.org, masami.hiramatsu.pt@hitachi.com, jbaron@akamai.com, heiko.carstens@de.ibm.com, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, realmz6@gmail.com
Cc: x86@kernel.org, luto@amacapital.net, keescook@chromium.org, torvalds@linux-foundation.org, gregkh@linuxfoundation.org, rusty@rustcorp.com.au, gnomes@lxorguk.ukuu.org.uk, alan@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, ming.lei@canonical.com, linux-arch@vger.kernel.org, benh@kernel.crashing.org, ananth@in.ibm.com, pebolle@tiscali.nl, fontana@sharpeleven.org, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, andrew.cooper3@citrix.com, andriy.shevchenko@linux.intel.com, paul.gortmaker@windriver.com, xen-devel@lists.xensource.com, ak@linux.intel.com, pali.rohar@gmail.com, dvhart@infradead.org, platform-driver-x86@vger.kernel.org, mmarek@suse.com, linux@rasmusvillemoes.dk, jkosina@suse.cz, korea.drzix@gmail.com, linux-kbuild@vger.kernel.org, tony.luck@intel.com, akpm@linux-foundation.org, linux-ia64@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, rostedt@goodmis.org, jani.nikula@intel.com, mchehab@osg.samsung.com, markus.heiser@darmarit.de, acme@redhat.com, jolsa@kernel.org, msalter@redhat.com, chris@zankel.net, jcmvbkbc@gmail.com, linux-xtensa@linux-xtensa.org, paulus@samba.org, mpe@ellerman.id.au, James.Bottomley@HansenPartnership.com, "Luis R. Rodriguez" <mcgrof@kernel.org>
Message-ID: <20160819213254.NVS-u5dloRSSp_aU6jnJVj-KUbMJjsD0Y9tuoG5flB4@z>

From: "Luis R. Rodriguez" <mcgrof@kernel.org>

When SORT(foo.*) is used the current sed replacements add
SORT(foo.literal foo.*), this breaks linking. Avoid adding
literals for SORT globs, if needed, these need to be added
manually.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 arch/xtensa/kernel/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/xtensa/kernel/Makefile b/arch/xtensa/kernel/Makefile
index c31f5d5afc7d..8180850ed147 100644
--- a/arch/xtensa/kernel/Makefile
+++ b/arch/xtensa/kernel/Makefile
@@ -29,10 +29,10 @@ AFLAGS_mxhead.o += -mtext-section-literals
 #
 # Replicate rules in scripts/Makefile.build
 
-sed-y = -e ':a; s/\*(\([^)]*\)\.text\.unlikely/*(\1.literal.unlikely .{text}.unlikely/; ta; ' \
-	-e ':b; s/\*(\([^)]*\)\.text\(\.[a-z]*\)/*(\1.{text}\2.literal .{text}\2/; tb; ' \
-	-e ':c; s/\*(\([^)]*\)\(\.[a-z]*it\|\.ref\)\.text/*(\1\2.literal \2.{text}/; tc; ' \
-	-e ':d; s/\*(\([^)]\+ \|\)\.text/*(\1.literal .{text}/; td; ' \
+sed-y = -e ':a; s/\*(\([^)SORT]*\)\.text\.unlikely/*(\1.literal.unlikely .{text}.unlikely/; ta; ' \
+	-e ':b; s/\*(\([^)SORT]*\)\.text\(\.[a-z]*\)/*(\1.{text}\2.literal .{text}\2/; tb; ' \
+	-e ':c; s/\*(\([^SORT)]*\)\(\.[a-z]*it\|\.ref\)\.text/*(\1\2.literal \2.{text}/; tc; ' \
+	-e ':d; s/\*(\([^SORT)]\+ \|\)\.text/*(\1.literal .{text}/; td; ' \
 	-e 's/\.{text}/.text/g'
 
 quiet_cmd__cpp_lds_S = LDS     $@
-- 
2.9.2


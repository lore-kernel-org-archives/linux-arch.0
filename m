From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/5] kbuild: allow archs to select build for link dead code/data elimination
Date: Sun, 07 Aug 2016 22:26:19 +0200
Message-ID: <12986071.MeSB5hmlsH@wuerfel>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com> <1470399123-8455-3-git-send-email-npiggin@gmail.com> <20160807095739.GU20904@bubble.grove.modra.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:61893 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbcHGU00 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 7 Aug 2016 16:26:26 -0400
In-Reply-To: <20160807095739.GU20904@bubble.grove.modra.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alan Modra <amodra@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Nicolas Pitre <nico@linaro.org>, linux-kbuild@vger.kernel.org

On Sunday, August 7, 2016 7:27:39 PM CEST Alan Modra wrote:
> 
> If it can, then Nicholas' patch should be:
> 
>         *(.text.hot .text.hot.*) *(.text.unlikely .text.unlikely.*) *(.text .text.*)
> 
> If you can't put .text.fixup too far away then you may as well just use
> 
>         *(.text .text.*)

I tried this version:

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b1f8828e9eac..fc210dacac9a 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -438,7 +438,9 @@
  * during second ld run in second ld pass when generating System.map */
 #define TEXT_TEXT							\
 		ALIGN_FUNCTION();					\
-		*(.text.hot .text .text.fixup .text.unlikely .text.*)	\
+		*(.text.hot .text.hot.*)				\
+		*(.text.unlikely .text.fixup .text.unlikely.*)		\
+		*(.text .text.*)					\
 		*(.ref.text)						\
 	MEM_KEEP(init.text)						\
 	MEM_KEEP(exit.text)						\

but that failed to link an allyesconfig kernel because of references
from .fixup to .text.*. Trying your version now:

*(.text.hot .text.hot.*) *(.text.unlikely .text.unlikely.*) *(.text .text.*)

	Arnd

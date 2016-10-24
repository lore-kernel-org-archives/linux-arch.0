Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:64621 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941052AbcJXPHf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Oct 2016 11:07:35 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2, variant A] ARM: add hidden mmioset/mmiocpy prototypes
Date: Mon, 24 Oct 2016 17:06:20 +0200
Message-ID: <3518814.5oq8zhvvpL@wuerfel>
In-Reply-To: <3446653.W8FbGAKSeQ@wuerfel>
References: <20161017065131.GA27863@angband.pl> <20161020150814.42951f61@roar.ozlabs.ibm.com> <3446653.W8FbGAKSeQ@wuerfel>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Omar Sandoval <osandov@osandov.com>, Linus Torvalds <torvalds@linux-foundation.org>, adobriyan@gmail.com, sfr@canb.auug.org.au, viro@zeniv.linux.org.uk, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20161024150620.lXqGsl2F2kLTFuphiJ1h5rpYzv-6ZSOPOQ-q7qpJqmA@z>

The prototypes for mmioset/mmiocpy are intentionally hidden
inside of inline functions, which breaks the EXPORT_SYMBOL
statements when symbol versioning is enabled.

This adds a prototype to asm/asm-prototypes.h but hides it
in an #ifdef so normal drivers don't see it and won't be
able to abuse the interface.

Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/include/asm/asm-prototypes.h b/arch/arm/include/asm/asm-prototypes.h
index 04e5616a7b15..e46b09536b14 100644
--- a/arch/arm/include/asm/asm-prototypes.h
+++ b/arch/arm/include/asm/asm-prototypes.h
@@ -32,3 +32,8 @@ extern void __muldi3(void);
 extern void __ucmpdi2(void);
 extern void __udivsi3(void);
 extern void __umodsi3(void);
+
+#ifdef __GENKSYMS__
+extern void mmioset(void *, unsigned int, size_t);
+extern void mmiocpy(void *, const void *, size_t);
+#endif


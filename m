Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hoefnix.telenet-ops.be ([195.130.132.54]:57392 "EHLO
	hoefnix.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848AbXEAPy1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 1 May 2007 11:54:27 -0400
Received: from astra.telenet-ops.be (astra.telenet-ops.be [195.130.132.58])
	by hoefnix.telenet-ops.be (Postfix) with ESMTP id F3BD59DE9C
	for <linux-arch@vger.kernel.org>; Tue,  1 May 2007 17:54:20 +0200 (CEST)
Date: Tue, 1 May 2007 17:53:59 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: export csum_partial_copy_from_user (fwd)
Message-ID: <Pine.LNX.4.64.0705011753070.27246@anakin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>
List-ID: <linux-arch.vger.kernel.org>


FYI, so far only alpha/frv/ia64/m32r/parisc/sparc64/v850/x86_64 export it.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

---------- Forwarded message ----------
Date: Tue, 1 May 2007 17:52:44 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] m68k: export csum_partial_copy_from_user

net/rxrpc/af-rxrpc.ko needs csum_partial_copy_from_user

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/lib/checksum.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-m68k-2.6.21.orig/arch/m68k/lib/checksum.c
+++ linux-m68k-2.6.21/arch/m68k/lib/checksum.c
@@ -320,6 +320,9 @@ csum_partial_copy_from_user(const void _
 	return(sum);
 }
 
+EXPORT_SYMBOL(csum_partial_copy_from_user);
+
+
 /*
  * copy from kernel space while checksumming, otherwise like csum_partial
  */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

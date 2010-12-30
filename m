From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH/RFC] Re: Compilation of pktgen fails for ARCH=um
Date: Thu, 30 Dec 2010 09:39:25 -0800
Message-ID: <20101230093925.3d6b567e.randy.dunlap@oracle.com>
References: <201012301133.14524.christoph.paasch@uclouvain.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:55382 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754865Ab0L3RkU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 30 Dec 2010 12:40:20 -0500
In-Reply-To: <201012301133.14524.christoph.paasch@uclouvain.be>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: christoph.paasch@uclouvain.be
Cc: netdev@vger.kernel.org, linux-arch@vger.kernel.org

On Thu, 30 Dec 2010 11:33:14 +0100 Christoph Paasch wrote:

> Hi,
> 
> compiling the packet generator (NET_PKTGEN) for ARCH=um does not work.
> 
> Since commit 43d28b6515a6ea580a198df3e253e88236f08978 (pktgen: increasing 
> transmission granularity), function spin(...) uses ndelay(...), which is not 
> implemented for uml.
> 
> Should pktgen be disabled for uml?
> Or should ndelay be an empty macro? (in arch/um/include/asm/delay.h)

or ndelay() in arch/um/include/asm/delay.y can be removed completely
and then the default implementation of ndelay() will be used from
include/linux/delay.h.
This builds cleanly, but I don't know how well it would work.

---
From: Randy Dunlap <randy.dunlap@oracle.com>

Allow uml to use the default implementation of ndelay() from
<linux/delay.h>.  Fixes build error:

net/built-in.o: In function `spin':
pktgen.c:(.text+0x27391): undefined reference to `__unimplemented_ndelay'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 arch/um/include/asm/delay.h |    5 -----
 1 file changed, 5 deletions(-)

--- linux-next-20101214.orig/arch/um/include/asm/delay.h
+++ linux-next-20101214/arch/um/include/asm/delay.h
@@ -12,9 +12,4 @@ extern void __delay(unsigned long loops)
 #define udelay(n) ((__builtin_constant_p(n) && (n) > 20000) ? \
 	__bad_udelay() : __udelay(n))
 
-/* It appears that ndelay is not used at all for UML, and has never been
- * implemented. */
-extern void __unimplemented_ndelay(void);
-#define ndelay(n) __unimplemented_ndelay()
-
 #endif

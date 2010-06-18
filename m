From: Mathieu Lacage <mathieu.lacage@sophia.inria.fr>
Subject: PATCH : cmpxchg does not handle int * arguments on LP64
Date: Fri, 18 Jun 2010 14:51:56 +0200
Message-ID: <1276865516.1999.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-SHSmFS7YVL56sjW2ZELg"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail4-relais-sop.national.inria.fr ([192.134.164.105]:42298
	"EHLO mail4-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758258Ab0FRNCN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 18 Jun 2010 09:02:13 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org


--=-SHSmFS7YVL56sjW2ZELg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

hi,

I have been using the asm-generic/system.h header to implement my
version of arch/xx/include/asm/system.h: it appears that the version of
cmpxchg defined in this generic header does not handle correctly
non-long arguments on an LP64 arch. 

The attached patch appears to work on my port: I suspect that it's not
the right 'fix'. If so, I would be happy to be pointed in the right
direction. The following inline patch was generated against
davem/net-next-2.6/ (and attached to this email since I don't know what
the proper insertion policy is)

diff --git a/include/asm-generic/system.h b/include/asm-generic/system.h
index efa403b..da31909 100644
--- a/include/asm-generic/system.h
+++ b/include/asm-generic/system.h
@@ -136,24 +136,7 @@ unsigned long __xchg(unsigned long x, volatile void *ptr, int size)
 #define xchg(ptr, x) \
 	((__typeof__(*(ptr))) __xchg((unsigned long)(x), (ptr), sizeof(*(ptr))))
 
-static inline unsigned long __cmpxchg(volatile unsigned long *m,
-				      unsigned long old, unsigned long new)
-{
-	unsigned long retval;
-	unsigned long flags;
-
-	local_irq_save(flags);
-	retval = *m;
-	if (retval == old)
-		*m = new;
-	local_irq_restore(flags);
-	return retval;
-}
-
-#define cmpxchg(ptr, o, n)					\
-	((__typeof__(*(ptr))) __cmpxchg((unsigned long *)(ptr), \
-					(unsigned long)(o),	\
-					(unsigned long)(n)))
+#define cmpxchg(ptr, o, n) cmpxchg_local(ptr, o, n)
 
 #endif /* !__ASSEMBLY__ */
 


Mathieu
-- 
Mathieu Lacage <mathieu.lacage@sophia.inria.fr>
Tel: +33 4 9238 5056

--=-SHSmFS7YVL56sjW2ZELg
Content-Disposition: attachment; filename="system.patch"
Content-Type: text/x-patch; name="system.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff --git a/include/asm-generic/system.h b/include/asm-generic/system.h
index efa403b..da31909 100644
--- a/include/asm-generic/system.h
+++ b/include/asm-generic/system.h
@@ -136,24 +136,7 @@ unsigned long __xchg(unsigned long x, volatile void *ptr, int size)
 #define xchg(ptr, x) \
 	((__typeof__(*(ptr))) __xchg((unsigned long)(x), (ptr), sizeof(*(ptr))))
 
-static inline unsigned long __cmpxchg(volatile unsigned long *m,
-				      unsigned long old, unsigned long new)
-{
-	unsigned long retval;
-	unsigned long flags;
-
-	local_irq_save(flags);
-	retval = *m;
-	if (retval == old)
-		*m = new;
-	local_irq_restore(flags);
-	return retval;
-}
-
-#define cmpxchg(ptr, o, n)					\
-	((__typeof__(*(ptr))) __cmpxchg((unsigned long *)(ptr), \
-					(unsigned long)(o),	\
-					(unsigned long)(n)))
+#define cmpxchg(ptr, o, n) cmpxchg_local(ptr, o, n)
 
 #endif /* !__ASSEMBLY__ */
 

--=-SHSmFS7YVL56sjW2ZELg--

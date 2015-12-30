From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 02/34] asm-generic: guard smp_store_release/load_acquire
Date: Wed, 30 Dec 2015 15:24:20 +0200
Message-ID: <1451473761-30019-3-git-send-email-mst@redhat.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53064 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754022AbbL3NYX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Dec 2015 08:24:23 -0500
Content-Disposition: inline
In-Reply-To: <1451473761-30019-1-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Allow architectures to override smp_store_release
and smp_load_acquire by guarding the defines
in asm-generic/barrier.h with ifndef directives.

This is in preparation to reusing asm-generic/barrier.h
on architectures which have their own definition
of these macros.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/asm-generic/barrier.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index b42afad..538f8d1 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -104,13 +104,16 @@
 #define smp_mb__after_atomic()	smp_mb()
 #endif
 
+#ifndef smp_store_release
 #define smp_store_release(p, v)						\
 do {									\
 	compiletime_assert_atomic_type(*p);				\
 	smp_mb();							\
 	WRITE_ONCE(*p, v);						\
 } while (0)
+#endif
 
+#ifndef smp_load_acquire
 #define smp_load_acquire(p)						\
 ({									\
 	typeof(*p) ___p1 = READ_ONCE(*p);				\
@@ -118,6 +121,7 @@ do {									\
 	smp_mb();							\
 	___p1;								\
 })
+#endif
 
 #endif /* !__ASSEMBLY__ */
 #endif /* __ASM_GENERIC_BARRIER_H */
-- 
MST

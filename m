Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44991 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754947AbbL3NYv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Dec 2015 08:24:51 -0500
Date: Wed, 30 Dec 2015 15:24:47 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 08/34] asm-generic: smp_store_mb should use smp_mb
Message-ID: <1451473761-30019-9-git-send-email-mst@redhat.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1451473761-30019-1-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Message-ID: <20151230132447.SAdRTEydhg5j1KbMp9ZW4pXyQj4k6j6hY0gce3x4FMw@z>

asm-generic variant of smp_store_mb() calls mb() which is stronger
than implied by both the name and the documentation.

smp_store_mb is only used by core kernel code at the moment, so
we know no one mis-uses it for an MMIO barrier.
Make it call smp_mb consistently before some arch-specific
code uses it as such by mistake.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/asm-generic/barrier.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 538f8d1..987b2e0 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -93,7 +93,7 @@
 #endif	/* CONFIG_SMP */
 
 #ifndef smp_store_mb
-#define smp_store_mb(var, value)  do { WRITE_ONCE(var, value); mb(); } while (0)
+#define smp_store_mb(var, value)  do { WRITE_ONCE(var, value); smp_mb(); } while (0)
 #endif
 
 #ifndef smp_mb__before_atomic
-- 
MST


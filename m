From: Tejun Heo <tj@kernel.org>
Subject: [PATCH] percpu: use __weak only in the definition of weak percpu
 variables
Date: Mon, 29 Jun 2009 17:53:24 +0900
Message-ID: <4A488104.3080801@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38453 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752714AbZF2Ixl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 29 Jun 2009 04:53:41 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Ivan

__weak is necessary only for definition and might even not work in
declaration.  Drop it from declaration.

This change was suggested by Ivan Kokshaysky.

Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
---
Committed to percpu#for-next.  Thanks.

 include/linux/percpu-defs.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index cf32838..9b7a53c 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -56,7 +56,7 @@
  */
 #define DECLARE_PER_CPU_SECTION(type, name, sec)			\
 	extern __PCPU_DUMMY_ATTRS char __pcpu_scope_##name;		\
-	extern __PCPU_ATTRS(sec) __weak __typeof__(type) per_cpu__##name
+	extern __PCPU_ATTRS(sec) __typeof__(type) per_cpu__##name
 
 #define DEFINE_PER_CPU_SECTION(type, name, sec)				\
 	__PCPU_DUMMY_ATTRS char __pcpu_scope_##name;			\
-- 
1.6.0.2

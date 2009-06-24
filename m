Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50459 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758177AbZFXNas (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 24 Jun 2009 09:30:48 -0400
From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 01/10] x86: make pcpu_chunk_addr_search() matching stricter
Date: Wed, 24 Jun 2009 22:30:07 +0900
Message-ID: <1245850216-31653-2-git-send-email-tj@kernel.org>
In-Reply-To: <1245850216-31653-1-git-send-email-tj@kernel.org>
References: <1245850216-31653-1-git-send-email-tj@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, andi@firstfloor.org, hpa@zytor.com, tglx@linutronix.de, cl@linux-foundation.org, akpm@linux-foundation.org
Cc: Tejun Heo <tj@kernel.org>
Message-ID: <20090624133007.4UJwqCRR_NuZzCndMcjQeo4wW9DjomBW4vv-kP2P4rw@z>

The @addr passed into pcpu_chunk_addr_search() is unit0 based address
and thus should be matched inside unit0 area.  Currently, when it uses
chunk size when determining whether the address falls in the first
chunk.  Addresses in unitN where N>0 shouldn't be passed in anyway, so
this doesn't cause any malfunction but fix it for consistency.

[ Impact: mostly cleanup ]

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
---
 mm/percpu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index b149845..19dd83b 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -290,7 +290,7 @@ static struct pcpu_chunk *pcpu_chunk_addr_search(void *addr)
 	void *first_start = pcpu_first_chunk->vm->addr;
 
 	/* is it in the first chunk? */
-	if (addr >= first_start && addr < first_start + pcpu_chunk_size) {
+	if (addr >= first_start && addr < first_start + pcpu_unit_size) {
 		/* is it in the reserved area? */
 		if (addr < first_start + pcpu_reserved_chunk_limit)
 			return pcpu_reserved_chunk;
-- 
1.6.0.2


From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/6] x86: make pcpu_chunk_addr_search() matching stricter
Date: Wed, 17 Jun 2009 13:04:31 +0900
Message-ID: <1245211476-27015-2-git-send-email-tj@kernel.org>
References: <1245211476-27015-1-git-send-email-tj@kernel.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764702AbZFQEHO@vger.kernel.org>
In-Reply-To: <1245211476-27015-1-git-send-email-tj@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, andi@firstfloor.org, hpa@zytor.com, tglx@linutronix.de
Cc: Tejun Heo <tj@kernel.org>
List-Id: linux-arch.vger.kernel.org

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

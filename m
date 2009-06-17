From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 7/7] x86: ensure percpu lpage doesn't consume too much vmalloc space
Date: Wed, 17 Jun 2009 12:52:19 +0900
Message-ID: <1245210739-25699-8-git-send-email-tj@kernel.org>
References: <1245210739-25699-1-git-send-email-tj@kernel.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49533 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764370AbZFQDxD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 16 Jun 2009 23:53:03 -0400
In-Reply-To: <1245210739-25699-1-git-send-email-tj@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, JBeulich@novell.com, andi@firstfloor.org, hpa@zytor.com, tglx@linutronix.de
Cc: Tejun Heo <tj@kernel.org>

On extreme configuration (e.g. 32bit 32-way NUMA machine), lpage
percpu first chunk allocator can consume too much of vmalloc space.
Make it fall back to 4k allocator if the consumption goes over 20%.

[ Impact: add sanity check for lpage percpu first chunk allocator ]

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Jan Beulich <JBeulich@novell.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Ingo Molnar <mingo@elte.hu>
---
 arch/x86/kernel/setup_percpu.c |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index 165ebd5..29a3eef 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -163,9 +163,21 @@ static ssize_t __init setup_pcpu_lpage(size_t static_size, bool chosen)
 	int i, j;
 	ssize_t ret;
 
-	/* on non-NUMA, embedding is better */
-	if (!chosen && !pcpu_need_numa())
-		return -EINVAL;
+	if (!chosen) {
+		size_t vm_size = VMALLOC_END - VMALLOC_START;
+		size_t tot_size = num_possible_cpus() * PMD_SIZE;
+
+		/* on non-NUMA, embedding is better */
+		if (!pcpu_need_numa())
+			return -EINVAL;
+
+		/* don't consume more than 20% of vmalloc area */
+		if (tot_size > vm_size / 5) {
+			pr_info("PERCPU: too large chunk size %zuMB for "
+				"large page remap\n", tot_size >> 20);
+			return -EINVAL;
+		}
+	}
 
 	/* need PSE */
 	if (!cpu_has_pse) {
-- 
1.6.0.2

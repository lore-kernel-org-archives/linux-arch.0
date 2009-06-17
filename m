From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/7] x86: fix duplicate free in setup_pcpu_remap() failure path
Date: Wed, 17 Jun 2009 12:52:13 +0900
Message-ID: <1245210739-25699-2-git-send-email-tj@kernel.org>
References: <1245210739-25699-1-git-send-email-tj@kernel.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49476 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757173AbZFQDwl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 16 Jun 2009 23:52:41 -0400
In-Reply-To: <1245210739-25699-1-git-send-email-tj@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, JBeulich@novell.com, andi@firstfloor.org, hpa@zytor.com, tglx@linutronix.de
Cc: Tejun Heo <tj@kernel.org>

In the failure path, setup_pcpu_remap() tries to free the area which
has already been freed to make holes in the large page.  Fix it.

[ Impact: fix duplicate free in failure path ]

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
---
 arch/x86/kernel/setup_percpu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index 9c3f082..dfbc7e6 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -228,7 +228,7 @@ static ssize_t __init setup_pcpu_remap(size_t static_size)
 enomem:
 	for_each_possible_cpu(cpu)
 		if (pcpur_ptrs[cpu])
-			free_bootmem(__pa(pcpur_ptrs[cpu]), PMD_SIZE);
+			free_bootmem(__pa(pcpur_ptrs[cpu]), pcpur_size);
 	ret = -ENOMEM;
 out_free_ar:
 	free_bootmem(__pa(pcpur_ptrs), ptrs_size);
-- 
1.6.0.2

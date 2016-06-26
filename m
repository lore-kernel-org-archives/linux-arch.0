Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60380 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751886AbcFZV42 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 26 Jun 2016 17:56:28 -0400
From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v4 21/29] x86/smp: Remove unnecessary initialization of thread_info::cpu
Date: Sun, 26 Jun 2016 14:55:43 -0700
Message-ID: <b5b1cd08dbb840e3d7b04295649a6c5d48832c4a.1466974736.git.luto@kernel.org>
In-Reply-To: <cover.1466974736.git.luto@kernel.org>
References: <cover.1466974736.git.luto@kernel.org>
In-Reply-To: <cover.1466974736.git.luto@kernel.org>
References: <cover.1466974736.git.luto@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andy Lutomirski <luto@kernel.org>
Message-ID: <20160626215543.YQypNTzyDYE0z-lnz5pcWF8Kzk_gAWXf4h6urXCITI0@z>

It's statically initialized to zero -- no need to dynamically
initialize it to zero as well.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/kernel/smpboot.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index fafe8b923cac..0e91dbeca2fd 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1285,7 +1285,6 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	cpumask_copy(cpu_callin_mask, cpumask_of(0));
 	mb();
 
-	current_thread_info()->cpu = 0;  /* needed? */
 	for_each_possible_cpu(i) {
 		zalloc_cpumask_var(&per_cpu(cpu_sibling_map, i), GFP_KERNEL);
 		zalloc_cpumask_var(&per_cpu(cpu_core_map, i), GFP_KERNEL);
-- 
2.7.4


From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v5 20/32] x86/smp: Remove unnecessary initialization of thread_info::cpu
Date: Mon, 11 Jul 2016 13:53:53 -0700
Message-ID: <94a4be63923478be9972ccf534f6f2cbb19ddbb7.1468270393.git.luto@kernel.org>
References: <cover.1468270393.git.luto@kernel.org>
Reply-To: kernel-hardening@lists.openwall.com
Return-path: <kernel-hardening-return-3909-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
In-Reply-To: <cover.1468270393.git.luto@kernel.org>
In-Reply-To: <cover.1468270393.git.luto@kernel.org>
References: <cover.1468270393.git.luto@kernel.org>
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-arch.vger.kernel.org

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

From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 02/24] ia64: Remove Linux/x86 exec domain support
Date: Sat, 11 Apr 2015 22:47:41 +0200
Message-ID: <1428785283-20501-3-git-send-email-richard@nod.at>
References: <1428785283-20501-1-git-send-email-richard@nod.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428785283-20501-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com, linux@arm.linux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com, msalter@redhat.com, a-jacquiot@ti.com, starvik@axis.com, jesper.nilsson@axis.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, monstr@monstr.eu, ralf@linux-mips.org, yasutake.koichi@jp.panasonic.com, lftan@altera.com, jonas@southpole.se, jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, liqin.linux@gmail.com, lennox.wu@gmail.com, davem@davemloft.net, cmetcalf@ezchip.com, jdike@addtoit.com, akpm@linux-foundation.org, oleg@redhat.com, hch@inf
List-Id: linux-arch.vger.kernel.org

As this series removes exec domain support we can
get rid of this hack.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/ia64/mm/init.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index 6b33457..a9b65cf 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -692,31 +692,6 @@ int arch_remove_memory(u64 start, u64 size)
 #endif
 #endif
 
-/*
- * Even when CONFIG_IA32_SUPPORT is not enabled it is
- * useful to have the Linux/x86 domain registered to
- * avoid an attempted module load when emulators call
- * personality(PER_LINUX32). This saves several milliseconds
- * on each such call.
- */
-static struct exec_domain ia32_exec_domain;
-
-static int __init
-per_linux32_init(void)
-{
-	ia32_exec_domain.name = "Linux/x86";
-	ia32_exec_domain.handler = NULL;
-	ia32_exec_domain.pers_low = PER_LINUX32;
-	ia32_exec_domain.pers_high = PER_LINUX32;
-	ia32_exec_domain.signal_map = default_exec_domain.signal_map;
-	ia32_exec_domain.signal_invmap = default_exec_domain.signal_invmap;
-	register_exec_domain(&ia32_exec_domain);
-
-	return 0;
-}
-
-__initcall(per_linux32_init);
-
 /**
  * show_mem - give short summary of memory stats
  *
-- 
1.8.4.5

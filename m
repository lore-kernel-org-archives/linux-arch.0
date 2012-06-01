From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 08/27] m32r: Fix horrible logic in smp_prepare_cpus()
Date: Fri, 01 Jun 2012 14:42:11 +0530
Message-ID: <20120601091201.31979.37258.stgit@srivatsabhat.in.ibm.com>
References: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, paulmck@linux.vnet.ibm.com
Cc: rusty@rustcorp.com.au, mingo@kernel.org, yong.zhang0@gmail.com, akpm@linux-foundation.org, vatsa@linux.vnet.ibm.com, rjw@sisk.pl, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, Hirokazu Takata <takata@linux-m32r.org>, Thomas Gleixner <tglx@linutronix.de>, linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org
List-Id: linux-arch.vger.kernel.org

In smp_prepare_cpus(), after max_cpus are booted, instead of breaking
from the loop, the 'continue' statement is used which results in unnecessarily
wasting time by looping NR_CPUS times!

Many things around this could be pulled into generic code in the future, but
for now, fix this particular piece of code locally (because I am unable to
convince myself to ignore it even temporarily, given that it is such a gem!).

And also rewrite the 'if' statement in a more natural way.

Cc: Hirokazu Takata <takata@linux-m32r.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-m32r@ml.linux-m32r.org
Cc: linux-m32r-ja@ml.linux-m32r.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/m32r/kernel/smpboot.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m32r/kernel/smpboot.c b/arch/m32r/kernel/smpboot.c
index a2cfc0a..6ddc51a 100644
--- a/arch/m32r/kernel/smpboot.c
+++ b/arch/m32r/kernel/smpboot.c
@@ -209,8 +209,8 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 		if (!physid_isset(phys_id, phys_cpu_present_map))
 			continue;
 
-		if (max_cpus <= cpucount + 1)
-			continue;
+		if (cpucount + 1 >= max_cpus)
+			break;
 
 		do_boot_cpu(phys_id);
 

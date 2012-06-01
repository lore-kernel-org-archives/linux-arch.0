Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8]:43738 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448Ab2FAJNI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jun 2012 05:13:08 -0400
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Fri, 1 Jun 2012 14:43:06 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 08/27] m32r: Fix horrible logic in smp_prepare_cpus()
Date: Fri, 01 Jun 2012 14:42:11 +0530
Message-ID: <20120601091201.31979.37258.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com>
References: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com
Cc: rusty@rustcorp.com.au, mingo@kernel.org, yong.zhang0@gmail.com, akpm@linux-foundation.org, vatsa@linux.vnet.ibm.com, rjw@sisk.pl, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, Hirokazu Takata <takata@linux-m32r.org>, linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org
Message-ID: <20120601091211.xvQk8fjsG3vLHW6PMmXKkKD4BboRaYvex7cw2-PChkg@z>

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
 


Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:42628 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932418Ab2FAJ5N (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jun 2012 05:57:13 -0400
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Fri, 1 Jun 2012 10:03:27 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 16/27] mn10300: Fix horrible logic in smp_prepare_cpus()
Date: Fri, 01 Jun 2012 14:43:54 +0530
Message-ID: <20120601091348.31979.97139.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com>
References: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com
Cc: rusty@rustcorp.com.au, mingo@kernel.org, yong.zhang0@gmail.com, akpm@linux-foundation.org, vatsa@linux.vnet.ibm.com, rjw@sisk.pl, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, David Howells <dhowells@redhat.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>Yong Zhang <yong.zhang0@gmail.com>, linux-am33-list@redhat.com
Message-ID: <20120601091354.3svIBBL91hxcHMyWWh9ofw4J85n8fyVZLHh0c_V_Qiw@z>

In smp_prepare_cpus(), after max_cpus are booted, instead of breaking
from the loop, the 'continue' statement is used which results in
unnecessarily wasting time by looping NR_CPUS times!

Many things around this could be pulled into generic code in the future, but
for now, fix this particular piece of code locally (because I am unable to
convince myself to ignore it even temporarily, given that it is such a gem!).

And also rewrite the 'if' statement in a more natural way.

Cc: David Howells <dhowells@redhat.com>
Cc: Koichi Yasutake <yasutake.koichi@jp.panasonic.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yong Zhang <yong.zhang0@gmail.com>
Cc: linux-am33-list@redhat.com
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/mn10300/kernel/smp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mn10300/kernel/smp.c b/arch/mn10300/kernel/smp.c
index e62c223..b19e75d2 100644
--- a/arch/mn10300/kernel/smp.c
+++ b/arch/mn10300/kernel/smp.c
@@ -695,9 +695,9 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 
 	/* Boot secondary CPUs (for which phy_id > 0) */
 	for (phy_id = 0; phy_id < NR_CPUS; phy_id++) {
+		if (cpucount + 1 >= max_cpus)
+			break;
 		/* Don't boot primary CPU */
-		if (max_cpus <= cpucount + 1)
-			continue;
 		if (phy_id != 0)
 			do_boot_cpu(phy_id);
 		set_cpu_possible(phy_id, true);


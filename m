From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH v2] arch: s390: kernel: scan all present cpu forcely.
Date: Thu, 27 Jun 2013 10:43:02 +0800
Message-ID: <51CBA6B6.1010809@asianux.com>
References: <51C8F685.6000209@asianux.com> <20130625064832.GA4999@osiris> <51C94599.1020707@asianux.com> <20130625090928.GA8981@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:60999 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab3F0Cnz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 26 Jun 2013 22:43:55 -0400
In-Reply-To: <20130625090928.GA8981@osiris>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, cornelia.huck@de.ibm.com, mtosatti@redhat.com, Thomas Gleixner <tglx@linutronix.de>, linux-s390@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

The architectures which may support 'hotpluggable', can scan all cpus
during subsys_initcall().  the upper caller will skip the return value.

It also can initialize hotpluggable flag of all cpus in time, no matter
whether any cpus fail or not.

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/s390/kernel/smp.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index d386c4e..75a118f 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -1064,8 +1064,9 @@ static int __init s390_smp_init(void)
 #endif
 	for_each_present_cpu(cpu) {
 		rc = smp_add_present_cpu(cpu);
-		if (rc)
-			return rc;
+		if (unlikely(rc))
+			printk(KERN_WARNING "%s: add cpu %d failed (%d)\n",
+			       __func__, cpu, rc);
 	}
 	return 0;
 }
-- 
1.7.7.6

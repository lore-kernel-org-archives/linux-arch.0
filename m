From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v6 22/46] crypto: pcrypt - Protect access to cpu_online_mask
 with get/put_online_cpus()
Date: Mon, 18 Feb 2013 18:11:15 +0530
Message-ID: <20130218124115.26245.88223.stgit@srivatsabhat.in.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:43448 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755792Ab3BRMn1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 18 Feb 2013 07:43:27 -0500
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Mon, 18 Feb 2013 22:37:22 +1000
In-Reply-To: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org
Cc: rostedt@goodmis.org, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, rjw@sisk.pl, sbw@mit.edu, fweisbec@gmail.com, linux@arm.linux.org.uk, nikunj@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, walken@google.com, vincent.guittot@linaro.org

The pcrypt_aead_init_tfm() function access the cpu_online_mask without
disabling CPU hotplug. And it looks like it can afford to sleep, so use
the get/put_online_cpus() APIs to protect against CPU hotplug.

Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 crypto/pcrypt.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/crypto/pcrypt.c b/crypto/pcrypt.c
index b2c99dc..10f64e2 100644
--- a/crypto/pcrypt.c
+++ b/crypto/pcrypt.c
@@ -280,12 +280,16 @@ static int pcrypt_aead_init_tfm(struct crypto_tfm *tfm)
 
 	ictx->tfm_count++;
 
+	get_online_cpus();
+
 	cpu_index = ictx->tfm_count % cpumask_weight(cpu_online_mask);
 
 	ctx->cb_cpu = cpumask_first(cpu_online_mask);
 	for (cpu = 0; cpu < cpu_index; cpu++)
 		ctx->cb_cpu = cpumask_next(ctx->cb_cpu, cpu_online_mask);
 
+	put_online_cpus();
+
 	cipher = crypto_spawn_aead(crypto_instance_ctx(inst));
 
 	if (IS_ERR(cipher))

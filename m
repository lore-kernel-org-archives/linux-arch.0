Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:18908 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932169AbWBCJg2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2006 04:36:28 -0500
Date: Fri, 3 Feb 2006 01:35:21 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: Re: percpu data changes
Message-Id: <20060203013521.3696aa64.akpm@osdl.org>
In-Reply-To: <20060203011835.556f5199.akpm@osdl.org>
References: <20060203011748.6fe3fee3.akpm@osdl.org>
	<20060203011835.556f5199.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: starvik@axis.com, dhowells@redhat.com, kyle@parisc-linux.org, anton@samba.org, benh@kernel.crashing.org, paulus@samba.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, lethal@linux-sh.org, davem@davemloft.net, wli@holomorphy.com, ak@muc.de, chris@zankel.net, phil.el@wanadoo.fr, nathans@sgi.com, axboe@suse.de, linux-arch@vger.kernel.org, dada1@cosmosbay.com
List-ID: <linux-arch.vger.kernel.org>

Andrew Morton <akpm@osdl.org> wrote:
>
> Andrew Morton <akpm@osdl.org> wrote:
>  >
>  > I have a patch queued up (for 2.6.16) which fixes most users of percpu
>  >  data.  Make them use for_each_cpu().  I'll send that in a moment.

A couple more.


 net/core/dev.c   |    2 +-
 net/core/utils.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -puN net/core/dev.c~reduce-size-of-percpudata-and-make-sure-per_cpuobject-update net/core/dev.c
--- devel/net/core/dev.c~reduce-size-of-percpudata-and-make-sure-per_cpuobject-update	2006-02-03 01:33:56.000000000 -0800
+++ devel-akpm/net/core/dev.c	2006-02-03 01:34:16.000000000 -0800
@@ -3237,7 +3237,7 @@ static int __init net_dev_init(void)
 	 *	Initialise the packet receive queues.
 	 */
 
-	for (i = 0; i < NR_CPUS; i++) {
+	for_each_cpu(i) {
 		struct softnet_data *queue;
 
 		queue = &per_cpu(softnet_data, i);
diff -puN net/core/utils.c~reduce-size-of-percpudata-and-make-sure-per_cpuobject-update net/core/utils.c
--- devel/net/core/utils.c~reduce-size-of-percpudata-and-make-sure-per_cpuobject-update	2006-02-03 01:33:56.000000000 -0800
+++ devel-akpm/net/core/utils.c	2006-02-03 01:34:31.000000000 -0800
@@ -133,7 +133,7 @@ static int net_random_reseed(void)
 	unsigned long seed[NR_CPUS];
 
 	get_random_bytes(seed, sizeof(seed));
-	for (i = 0; i < NR_CPUS; i++) {
+	for_each_cpu(i) {
 		struct nrnd_state *state = &per_cpu(net_rand_state,i);
 		__net_srandom(state, seed[i]);
 	}
_


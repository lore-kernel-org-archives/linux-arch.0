From: Ingo Molnar <mingo@elte.hu>
Subject: [numbers] Re: [patch] more skb ops inlining
Date: Mon, 17 Aug 2009 23:26:29 +0200
Message-ID: <20090817212629.GA22368@elte.hu>
References: <alpine.LFD.2.01.0908140840540.3162@localhost.localdomain> <20090814171308.GA4906@osiris.boeblingen.de.ibm.com> <alpine.LFD.2.01.0908141105230.3162@localhost.localdomain> <20090814.131900.229343660.davem@davemloft.net> <alpine.LFD.2.01.0908141345000.3162@localhost.localdomain> <alpine.LFD.2.01.0908141350420.3162@localhost.localdomain> <20090816182733.GB5808@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:49720 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011AbZHQV04 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 17 Aug 2009 17:26:56 -0400
Content-Disposition: inline
In-Reply-To: <20090816182733.GB5808@osiris.boeblingen.de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, akpm@linux-foundation.org, a.p.zijlstra@chello.nl, linux-arch@vger.kernel.org, schwidefsky@de.ibm.com, arnd@arndb.de, horsth@linux.vnet.ibm.com, ehrhardt@linux.vnet.ibm.com


* Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> An allyesconfig (CONFIG_FTRACE disabled) on x86_64 with gcc 4.3.2 
> results in the following vmlinux sizes:
> 
> 574152755 2009-08-16 20:05 vmlinux-orig
> 574862000 2009-08-16 20:13 vmlinux-skb-inline
> 
> The skb-inline variant was created by using your patch and on top 
> of it the patch below. Size increased by 692KB (0.12%).
> 
> Dunno.. is that acceptable?

i ported your patch to latest mainline (see it attached below) i've 
done x86(-64) defconfig (with disabled CONFIG_OPTIMIZE_INLINING) 
measurements vmlinux:

   text	   data	    bss	     dec	    hex	filename
8455329	1192304	 989908	10637541	 a250e5	vmlinux.before
8471036	1192304	 989908	10653248	 a28e40	vmlinux.after

that's a +0.18% text size increase - quite significant.

I also did performance measurements, trying to figure out whether 
this increase in size can be measured via any runtime performance 
metrics such as cycles, instructions or cache-misses.

To do that i picked a micro-benchmarks lat_tcp.

( Note that microbenchmarks are biased in favor of inlining patches
  like yours, because they disproportionately favor the speed
  benefit of it while not adequately showing the cache footprint
  disadvantage of increased kernel text size. )

Without your patch i got:

titan:~/l> perf stat --repeat 10 -e task-clock -e cycles -e instructions -e L1-icache-refs -e L1-icache-misses ./lat_tcp localhost
TCP latency using localhost: 17.5198 microseconds
TCP latency using localhost: 17.5060 microseconds
TCP latency using localhost: 17.4684 microseconds
TCP latency using localhost: 17.5416 microseconds
TCP latency using localhost: 17.4881 microseconds
TCP latency using localhost: 17.4832 microseconds
TCP latency using localhost: 17.4830 microseconds
TCP latency using localhost: 17.4723 microseconds
TCP latency using localhost: 17.4733 microseconds
TCP latency using localhost: 17.5255 microseconds

 Performance counter stats for './lat_tcp localhost' (10 runs):

    1494.625043  task-clock-msecs         #      0.564 CPUs    ( +-   0.077% )
     3665868023  cycles                   #   2452.701 M/sec   ( +-   0.070% )
     2163212606  instructions             #      0.590 IPC     ( +-   0.090% )
     2449056216  L1-icache-loads          #   1638.576 M/sec   ( +-   0.056% )
       61081182  L1-icache-load-misses    #     40.867 M/sec   ( +-   0.192% )

    2.649159316  seconds time elapsed   ( +-   0.090% )

With your patch i got:

titan:~/l> perf stat --repeat 10 -e task-clock -e cycles -e instructions -e L1-icache-refs -e L1-icache-misses ./lat_tcp localhost
TCP latency using localhost: 17.6913 microseconds
TCP latency using localhost: 17.7218 microseconds
TCP latency using localhost: 17.6882 microseconds
TCP latency using localhost: 17.7196 microseconds
TCP latency using localhost: 17.6411 microseconds
TCP latency using localhost: 17.7136 microseconds
TCP latency using localhost: 17.6488 microseconds
TCP latency using localhost: 17.6663 microseconds
TCP latency using localhost: 17.7445 microseconds
TCP latency using localhost: 17.6851 microseconds

 Performance counter stats for './lat_tcp localhost' (10 runs):

    1497.479984  task-clock-msecs         #      0.564 CPUs    ( +-   0.106% )
     3690097505  cycles                   #   2464.205 M/sec   ( +-   0.109% )
     2162432402  instructions             #      0.586 IPC     ( +-   0.127% )
     2437974192  L1-icache-loads          #   1628.051 M/sec   ( +-   0.105% )
       63064588  L1-icache-load-misses    #     42.114 M/sec   ( +-   0.278% )

    2.656952976  seconds time elapsed   ( +-   0.110% )

Summarized (for lat_tcp):

|  Before:
|
|    1494.625043  task-clock-msecs         #      0.564 CPUs    ( +-   0.077% )
|     3665868023  cycles                   #   2452.701 M/sec   ( +-   0.070% )
|     2163212606  instructions             #      0.590 IPC     ( +-   0.090% )
|
|  After:
|
|    1497.479984  task-clock-msecs         #      0.564 CPUs    ( +-   0.106% )
|     3690097505  cycles                   #   2464.205 M/sec   ( +-   0.109% )
|     2162432402  instructions             #      0.586 IPC     ( +-   0.127% )

So we've got a 0.2% slowdown, which is provably outside the noise 
level of 0.1%. The instruction count remained almost the same.

The reason for the slowdown can be seen in the L1 icache-fetch 
stats:

     2449056216  L1-icache-loads          #   1638.576 M/sec   ( +-   0.056% )
       61081182  L1-icache-load-misses    #     40.867 M/sec   ( +-   0.192% )

     2437974192  L1-icache-loads          #   1628.051 M/sec   ( +-   0.105% )
       63064588  L1-icache-load-misses    #     42.114 M/sec   ( +-   0.278% )

The icache-misses went up from 40.867 M/sec to 42.114 M/sec, a 
3.05% worsening - well beyond the statistical significance of 
0.28%.

So unless i botched the measurements or some accidental code layout 
differences punish the patch artificially, this patch is a small 
but measureable performance regression on x86.

The slowdown itself is barely provable with a test repeat count of 
10 iterations (not a surprise really - such patches were not really 
provable before via /usr/bin/time kinds of measurements), on an 
otherwise totally idle system.

The icache-miss stats do support the notion that what is causing 
the slowdown is the critical path fallout out of the icache.

( By all means please repeat these measurements - they are very
  easy to do via 'perf stat --repeat 10' - see the examples
  above. )

To build the kernel i used gcc 4.3.2. The CPU i used is friendly to 
inlining patches as well: it's an Extreme Edition Core2 Duo (booted 
to a single core, to stabilize the numbers):

  Intel(R) Core(TM)2 CPU E6800  @ 2.93GHz

With 4MB of L2 cache. I suspect smaller CPUs would feel the 
negative effects of inlining in a more pronounced way.

Thanks,

	Ingo

---
 include/linux/skbuff.h |   37 +++++++++++++++++++++++++++++++++++--
 net/core/skbuff.c      |   40 ----------------------------------------
 2 files changed, 35 insertions(+), 42 deletions(-)

Index: linux/include/linux/skbuff.h
===================================================================
--- linux.orig/include/linux/skbuff.h
+++ linux/include/linux/skbuff.h
@@ -1120,7 +1120,6 @@ static inline void skb_set_tail_pointer(
 /*
  *	Add data to an sk_buff
  */
-extern unsigned char *skb_put(struct sk_buff *skb, unsigned int len);
 static inline unsigned char *__skb_put(struct sk_buff *skb, unsigned int len)
 {
 	unsigned char *tmp = skb_tail_pointer(skb);
@@ -1130,7 +1129,24 @@ static inline unsigned char *__skb_put(s
 	return tmp;
 }
 
-extern unsigned char *skb_push(struct sk_buff *skb, unsigned int len);
+/**
+ *	skb_put - add data to a buffer
+ *	@skb: buffer to use
+ *	@len: amount of data to add
+ *
+ *	This function extends the used data area of the buffer. If this would
+ *	exceed the total buffer size the kernel will panic. A pointer to the
+ *	first byte of the extra data is returned.
+ */
+static inline unsigned char *skb_put(struct sk_buff *skb, unsigned int len)
+{
+	unsigned char *tmp = __skb_put(skb, len);
+
+	if (unlikely(skb->tail > skb->end))
+		skb_over_panic(skb, len, __builtin_return_address(0));
+	return tmp;
+}
+
 static inline unsigned char *__skb_push(struct sk_buff *skb, unsigned int len)
 {
 	skb->data -= len;
@@ -1138,6 +1154,23 @@ static inline unsigned char *__skb_push(
 	return skb->data;
 }
 
+/**
+ *	skb_push - add data to the start of a buffer
+ *	@skb: buffer to use
+ *	@len: amount of data to add
+ *
+ *	This function extends the used data area of the buffer at the buffer
+ *	start. If this would exceed the total buffer headroom the kernel will
+ *	panic. A pointer to the first byte of the extra data is returned.
+ */
+static inline unsigned char *skb_push(struct sk_buff *skb, unsigned int len)
+{
+	__skb_push(skb, len);
+	if (unlikely(skb->data<skb->head))
+		skb_under_panic(skb, len, __builtin_return_address(0));
+	return skb->data;
+}
+
 extern unsigned char *skb_pull(struct sk_buff *skb, unsigned int len);
 static inline unsigned char *__skb_pull(struct sk_buff *skb, unsigned int len)
 {
Index: linux/net/core/skbuff.c
===================================================================
--- linux.orig/net/core/skbuff.c
+++ linux/net/core/skbuff.c
@@ -1000,46 +1000,6 @@ free_skb:
 EXPORT_SYMBOL(skb_pad);
 
 /**
- *	skb_put - add data to a buffer
- *	@skb: buffer to use
- *	@len: amount of data to add
- *
- *	This function extends the used data area of the buffer. If this would
- *	exceed the total buffer size the kernel will panic. A pointer to the
- *	first byte of the extra data is returned.
- */
-unsigned char *skb_put(struct sk_buff *skb, unsigned int len)
-{
-	unsigned char *tmp = skb_tail_pointer(skb);
-	SKB_LINEAR_ASSERT(skb);
-	skb->tail += len;
-	skb->len  += len;
-	if (unlikely(skb->tail > skb->end))
-		skb_over_panic(skb, len, __builtin_return_address(0));
-	return tmp;
-}
-EXPORT_SYMBOL(skb_put);
-
-/**
- *	skb_push - add data to the start of a buffer
- *	@skb: buffer to use
- *	@len: amount of data to add
- *
- *	This function extends the used data area of the buffer at the buffer
- *	start. If this would exceed the total buffer headroom the kernel will
- *	panic. A pointer to the first byte of the extra data is returned.
- */
-unsigned char *skb_push(struct sk_buff *skb, unsigned int len)
-{
-	skb->data -= len;
-	skb->len  += len;
-	if (unlikely(skb->data<skb->head))
-		skb_under_panic(skb, len, __builtin_return_address(0));
-	return skb->data;
-}
-EXPORT_SYMBOL(skb_push);
-
-/**
  *	skb_pull - remove data from the start of a buffer
  *	@skb: buffer to use
  *	@len: amount of data to remove

From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [numbers] Re: [patch] more skb ops inlining
Date: Tue, 18 Aug 2009 13:34:19 +0200
Message-ID: <20090818113419.GA4950@osiris.boeblingen.de.ibm.com>
References: <alpine.LFD.2.01.0908140840540.3162@localhost.localdomain>
 <20090814171308.GA4906@osiris.boeblingen.de.ibm.com>
 <alpine.LFD.2.01.0908141105230.3162@localhost.localdomain>
 <20090814.131900.229343660.davem@davemloft.net>
 <alpine.LFD.2.01.0908141345000.3162@localhost.localdomain>
 <alpine.LFD.2.01.0908141350420.3162@localhost.localdomain>
 <20090816182733.GB5808@osiris.boeblingen.de.ibm.com>
 <20090817212629.GA22368@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate1.de.ibm.com ([195.212.17.161]:45237 "EHLO
	mtagate1.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758076AbZHRLeT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 18 Aug 2009 07:34:19 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.1/8.13.1) with ESMTP id n7IBYKn5014547
	for <linux-arch@vger.kernel.org>; Tue, 18 Aug 2009 11:34:20 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n7IBYKXZ2719792
	for <linux-arch@vger.kernel.org>; Tue, 18 Aug 2009 13:34:20 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n7IBYJ4R031904
	for <linux-arch@vger.kernel.org>; Tue, 18 Aug 2009 13:34:20 +0200
Content-Disposition: inline
In-Reply-To: <20090817212629.GA22368@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, akpm@linux-foundation.org, a.p.zijlstra@chello.nl, linux-arch@vger.kernel.org, schwidefsky@de.ibm.com, arnd@arndb.de, horsth@linux.vnet.ibm.com, ehrhardt@linux.vnet.ibm.com

On Mon, Aug 17, 2009 at 11:26:29PM +0200, Ingo Molnar wrote:
> * Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> 
> > An allyesconfig (CONFIG_FTRACE disabled) on x86_64 with gcc 4.3.2 
> > results in the following vmlinux sizes:
> > 
> > 574152755 2009-08-16 20:05 vmlinux-orig
> > 574862000 2009-08-16 20:13 vmlinux-skb-inline
> > 
> > The skb-inline variant was created by using your patch and on top 
> > of it the patch below. Size increased by 692KB (0.12%).
> > 
> > Dunno.. is that acceptable?
> 
> i ported your patch to latest mainline (see it attached below) i've 
> done x86(-64) defconfig (with disabled CONFIG_OPTIMIZE_INLINING) 
> measurements vmlinux:

> +static inline unsigned char *skb_put(struct sk_buff *skb, unsigned int len)
> +{
> +	unsigned char *tmp = __skb_put(skb, len);
> +
> +	if (unlikely(skb->tail > skb->end))
> +		skb_over_panic(skb, len, __builtin_return_address(0));
> +	return tmp;
> +}

No, the proposed patch replaces skb_over_panic() with BUG_ON() (see below).
With that I get slightly different results. However that's on my Thinkpad
booted with maxcpus=1 and a 32 bit kernel. Kernel is latest git as of today.

Now, this is a completely different machine than yours. With a different
config, so the machine actually boots. But the numbers are strange.

Part of /proc/cpuinfo :

model name      : Intel(R) Core(TM)2 CPU         T7600  @ 2.33GHz
stepping        : 6
cache size      : 4096 KB

Without the patch the result is:

TCP latency using localhost: 0.2576 microseconds
TCP latency using localhost: 0.2571 microseconds
TCP latency using localhost: 0.2579 microseconds
TCP latency using localhost: 0.2573 microseconds
TCP latency using localhost: 0.2574 microseconds
TCP latency using localhost: 0.2583 microseconds
TCP latency using localhost: 0.2572 microseconds
TCP latency using localhost: 0.2582 microseconds
TCP latency using localhost: 0.2583 microseconds
TCP latency using localhost: 0.2584 microseconds

 Performance counter stats for './lat_tcp localhost' (10 runs):

   24578.750193  task-clock-msecs         #      0.994 CPUs    ( +-   0.295% )
    57166815217  cycles                   #   2325.863 M/sec   ( +-   0.296% )
    24994309721  instructions             #      0.437 IPC     ( +-   0.288% )
    53691289530  L1-icache-loads          #   2184.460 M/sec   ( +-   0.304% )
         424027  L1-icache-load-misses    #      0.017 M/sec   ( +-   0.824% )

   24.714691813  seconds time elapsed   ( +-   0.285% )


With the patch I get this:

TCP latency using localhost: 0.2588 microseconds
TCP latency using localhost: 0.2589 microseconds
TCP latency using localhost: 0.2581 microseconds
TCP latency using localhost: 0.2586 microseconds
TCP latency using localhost: 0.2584 microseconds
TCP latency using localhost: 0.2588 microseconds
TCP latency using localhost: 0.2586 microseconds
TCP latency using localhost: 0.2589 microseconds
TCP latency using localhost: 0.2582 microseconds
TCP latency using localhost: 0.2586 microseconds

 Performance counter stats for './lat_tcp localhost' (10 runs):

   24464.554706  task-clock-msecs         #      0.995 CPUs    ( +-   0.063% )
    56903708182  cycles                   #   2325.965 M/sec   ( +-   0.063% )
    24831456567  instructions             #      0.436 IPC     ( +-   0.048% )
    53068943303  L1-icache-loads          #   2169.218 M/sec   ( +-   0.081% )
         418802  L1-icache-load-misses    #      0.017 M/sec   ( +-   0.637% )

   24.596311828  seconds time elapsed   ( +-   0.097% )

So latency increases while all other numbers decrease..

---
 include/linux/skbuff.h |   39 +++++++++++++++++++---
 net/core/skbuff.c      |   85 -------------------------------------------------
 2 files changed, 33 insertions(+), 91 deletions(-)

Index: linux-2.6/include/linux/skbuff.h
===================================================================
--- linux-2.6.orig/include/linux/skbuff.h
+++ linux-2.6/include/linux/skbuff.h
@@ -483,10 +483,6 @@ extern int	       skb_cow_data(struct sk
 extern int	       skb_pad(struct sk_buff *skb, int pad);
 #define dev_kfree_skb(a)	consume_skb(a)
 #define dev_consume_skb(a)	kfree_skb_clean(a)
-extern void	      skb_over_panic(struct sk_buff *skb, int len,
-				     void *here);
-extern void	      skb_under_panic(struct sk_buff *skb, int len,
-				      void *here);
 
 extern int skb_append_datato_frags(struct sock *sk, struct sk_buff *skb,
 			int getfrag(void *from, char *to, int offset,
@@ -1120,7 +1116,6 @@ static inline void skb_set_tail_pointer(
 /*
  *	Add data to an sk_buff
  */
-extern unsigned char *skb_put(struct sk_buff *skb, unsigned int len);
 static inline unsigned char *__skb_put(struct sk_buff *skb, unsigned int len)
 {
 	unsigned char *tmp = skb_tail_pointer(skb);
@@ -1130,7 +1125,23 @@ static inline unsigned char *__skb_put(s
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
+	BUG_ON(skb->tail > skb->end);
+	return tmp;
+}
+
 static inline unsigned char *__skb_push(struct sk_buff *skb, unsigned int len)
 {
 	skb->data -= len;
@@ -1138,6 +1149,22 @@ static inline unsigned char *__skb_push(
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
+	BUG_ON(skb->data < skb->head);
+	return skb->data;
+}
+
 extern unsigned char *skb_pull(struct sk_buff *skb, unsigned int len);
 static inline unsigned char *__skb_pull(struct sk_buff *skb, unsigned int len)
 {
Index: linux-2.6/net/core/skbuff.c
===================================================================
--- linux-2.6.orig/net/core/skbuff.c
+++ linux-2.6/net/core/skbuff.c
@@ -103,51 +103,6 @@ static struct pipe_buf_operations sock_p
 	.get = sock_pipe_buf_get,
 };
 
-/*
- *	Keep out-of-line to prevent kernel bloat.
- *	__builtin_return_address is not used because it is not always
- *	reliable.
- */
-
-/**
- *	skb_over_panic	- 	private function
- *	@skb: buffer
- *	@sz: size
- *	@here: address
- *
- *	Out of line support code for skb_put(). Not user callable.
- */
-void skb_over_panic(struct sk_buff *skb, int sz, void *here)
-{
-	printk(KERN_EMERG "skb_over_panic: text:%p len:%d put:%d head:%p "
-			  "data:%p tail:%#lx end:%#lx dev:%s\n",
-	       here, skb->len, sz, skb->head, skb->data,
-	       (unsigned long)skb->tail, (unsigned long)skb->end,
-	       skb->dev ? skb->dev->name : "<NULL>");
-	BUG();
-}
-EXPORT_SYMBOL(skb_over_panic);
-
-/**
- *	skb_under_panic	- 	private function
- *	@skb: buffer
- *	@sz: size
- *	@here: address
- *
- *	Out of line support code for skb_push(). Not user callable.
- */
-
-void skb_under_panic(struct sk_buff *skb, int sz, void *here)
-{
-	printk(KERN_EMERG "skb_under_panic: text:%p len:%d put:%d head:%p "
-			  "data:%p tail:%#lx end:%#lx dev:%s\n",
-	       here, skb->len, sz, skb->head, skb->data,
-	       (unsigned long)skb->tail, (unsigned long)skb->end,
-	       skb->dev ? skb->dev->name : "<NULL>");
-	BUG();
-}
-EXPORT_SYMBOL(skb_under_panic);
-
 /* 	Allocate a new skbuff. We do this ourselves so we can fill in a few
  *	'private' fields and also do memory statistics to find all the
  *	[BEEP] leaks.
@@ -1000,46 +955,6 @@ free_skb:
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

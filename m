From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [patch 0/3] Allow inlined spinlocks again V3
Date: Sun, 16 Aug 2009 20:27:33 +0200
Message-ID: <20090816182733.GB5808@osiris.boeblingen.de.ibm.com>
References: <alpine.LFD.2.01.0908140840540.3162@localhost.localdomain>
 <20090814171308.GA4906@osiris.boeblingen.de.ibm.com>
 <alpine.LFD.2.01.0908141105230.3162@localhost.localdomain>
 <20090814.131900.229343660.davem@davemloft.net>
 <alpine.LFD.2.01.0908141345000.3162@localhost.localdomain>
 <alpine.LFD.2.01.0908141350420.3162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:45983 "EHLO
	mtagate4.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753642AbZHPS1o (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 16 Aug 2009 14:27:44 -0400
Received: from d06nrmr1407.portsmouth.uk.ibm.com (d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate4.uk.ibm.com (8.14.3/8.13.8) with ESMTP id n7GIRYfr159160
	for <linux-arch@vger.kernel.org>; Sun, 16 Aug 2009 18:27:34 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com [9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n7GIRYBd1818848
	for <linux-arch@vger.kernel.org>; Sun, 16 Aug 2009 19:27:34 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n7GIRX7q031635
	for <linux-arch@vger.kernel.org>; Sun, 16 Aug 2009 19:27:34 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0908141350420.3162@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, akpm@linux-foundation.org, a.p.zijlstra@chello.nl, mingo@elte.hu, linux-arch@vger.kernel.org, schwidefsky@de.ibm.com, arnd@arndb.de, horsth@linux.vnet.ibm.com, ehrhardt@linux.vnet.ibm.com

On Fri, Aug 14, 2009 at 02:10:45PM -0700, Linus Torvalds wrote:
> On Fri, 14 Aug 2009, Linus Torvalds wrote:
> > 
> > But not inline in the code, though. So yeah, it has a memory footprint, 
> > but shouldn't have a cache footprint.
> 
> An example of this: stack usage. This is the code with BUG_ON():
> 
> 	skb_push:
> 		push   %rbp
> 		mov    %esi,%eax
> 		add    %esi,0x68(%rdi)
> 		neg    %rax
> 		mov    %rsp,%rbp
> 		add    0xd8(%rdi),%rax
> 		mov    %rax,0xd8(%rdi)
> 		cmp    0xd0(%rdi),%rax
> 		jae    2f
> 		ud2a   
> 	1:	jmp    1b
> 	2:	leaveq 
> 		retq   

An allyesconfig (CONFIG_FTRACE disabled) on x86_64 with gcc 4.3.2 results in
the following vmlinux sizes:

574152755 2009-08-16 20:05 vmlinux-orig
574862000 2009-08-16 20:13 vmlinux-skb-inline

The skb-inline variant was created by using your patch and on top of it the
patch below. Size increased by 692KB (0.12%).

Dunno.. is that acceptable?

---
 include/linux/skbuff.h |   35 +++++++++++++++++++++++++++++++++--
 net/core/skbuff.c      |   38 --------------------------------------
 2 files changed, 33 insertions(+), 40 deletions(-)

Index: linux-2.6/include/linux/skbuff.h
===================================================================
--- linux-2.6.orig/include/linux/skbuff.h
+++ linux-2.6/include/linux/skbuff.h
@@ -1116,7 +1116,6 @@ static inline void skb_set_tail_pointer(
 /*
  *	Add data to an sk_buff
  */
-extern unsigned char *skb_put(struct sk_buff *skb, unsigned int len);
 static inline unsigned char *__skb_put(struct sk_buff *skb, unsigned int len)
 {
 	unsigned char *tmp = skb_tail_pointer(skb);
@@ -1126,7 +1125,23 @@ static inline unsigned char *__skb_put(s
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
@@ -1134,6 +1149,22 @@ static inline unsigned char *__skb_push(
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
@@ -955,44 +955,6 @@ free_skb:
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
-	BUG_ON(skb->tail > skb->end);
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
-	BUG_ON(skb->data < skb->head);
-	return skb->data;
-}
-EXPORT_SYMBOL(skb_push);
-
-/**
  *	skb_pull - remove data from the start of a buffer
  *	@skb: buffer to use
  *	@len: amount of data to remove

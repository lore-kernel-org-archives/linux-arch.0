From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 0/3] Allow inlined spinlocks again V3
Date: Fri, 14 Aug 2009 14:10:45 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908141350420.3162@localhost.localdomain>
References: <alpine.LFD.2.01.0908140840540.3162@localhost.localdomain> <20090814171308.GA4906@osiris.boeblingen.de.ibm.com> <alpine.LFD.2.01.0908141105230.3162@localhost.localdomain> <20090814.131900.229343660.davem@davemloft.net>
 <alpine.LFD.2.01.0908141345000.3162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34249 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755238AbZHNVLo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 14 Aug 2009 17:11:44 -0400
In-Reply-To: <alpine.LFD.2.01.0908141345000.3162@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: heiko.carstens@de.ibm.com, akpm@linux-foundation.org, a.p.zijlstra@chello.nl, mingo@elte.hu, linux-arch@vger.kernel.org, schwidefsky@de.ibm.com, arnd@arndb.de, horsth@linux.vnet.ibm.com, ehrhardt@linux.vnet.ibm.com



On Fri, 14 Aug 2009, Linus Torvalds wrote:
> 
> But not inline in the code, though. So yeah, it has a memory footprint, 
> but shouldn't have a cache footprint.

An example of this: stack usage. This is the code with BUG_ON():

	skb_push:
		push   %rbp
		mov    %esi,%eax
		add    %esi,0x68(%rdi)
		neg    %rax
		mov    %rsp,%rbp
		add    0xd8(%rdi),%rax
		mov    %rax,0xd8(%rdi)
		cmp    0xd0(%rdi),%rax
		jae    2f
		ud2a   
	1:	jmp    1b
	2:	leaveq 
		retq   

and note how in the code, we're just jumping over something like four
bytes ("ud2" plus that silly endless loop-jump just to make gcc happy
are both 2 bytes on x86[-64]). 

Here's the same code with that horrid skb_under_panic():

	skb_push:
		push   %rbp
		mov    %esi,%eax
		mov    %rsp,%rbp
		neg    %rax
		push   %rbx
		mov    %rdi,%rbx
		sub    $0x8,%rsp
		add    0xd8(%rdi),%rax
		add    %esi,0x68(%rdi)
		mov    %rax,0xd8(%rdi)
		cmp    0xd0(%rdi),%rax
		jae    1f
		mov    0x8(%rbp),%rdx
		callq  skb_under_panic
	1:	mov    0xd8(%rbx),%rax
		pop    %r11
		pop    %rbx
		leaveq 
		retq   

and notice how it creates a stack frame due to the call (even when the
call is never done!) and the dead space is now 11 bytes. 

(Total size of functions: 41 bytes vs 64 bytes)

So things like that do make a difference.  It's surprisingly expensive
to add a function call t what otherwise could be a leaf function.  And
BUG_ON() avoids that. 

Of course, even at just 41 bytes, it's not _entirely_ obvious that 
inlining is the right thing.  Of those 41 bytes, four are just function 
overhead, and the "call" is five bytes in the caller and a few bytes of 
spills and argument setups, but inlining is still probably going to change 
each call-site from ~10 bytes to ~35 bytes. 

		Linus

---
 include/linux/skbuff.h |    4 ---
 net/core/skbuff.c      |   51 +----------------------------------------------
 2 files changed, 2 insertions(+), 53 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index f2c69a2..2af92b4 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -483,10 +483,6 @@ extern int	       skb_cow_data(struct sk_buff *skb, int tailbits,
 extern int	       skb_pad(struct sk_buff *skb, int pad);
 #define dev_kfree_skb(a)	consume_skb(a)
 #define dev_consume_skb(a)	kfree_skb_clean(a)
-extern void	      skb_over_panic(struct sk_buff *skb, int len,
-				     void *here);
-extern void	      skb_under_panic(struct sk_buff *skb, int len,
-				      void *here);
 
 extern int skb_append_datato_frags(struct sock *sk, struct sk_buff *skb,
 			int getfrag(void *from, char *to, int offset,
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 9e0597d..ae63473 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -103,51 +103,6 @@ static struct pipe_buf_operations sock_pipe_buf_ops = {
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
@@ -1014,8 +969,7 @@ unsigned char *skb_put(struct sk_buff *skb, unsigned int len)
 	SKB_LINEAR_ASSERT(skb);
 	skb->tail += len;
 	skb->len  += len;
-	if (unlikely(skb->tail > skb->end))
-		skb_over_panic(skb, len, __builtin_return_address(0));
+	BUG_ON(skb->tail > skb->end);
 	return tmp;
 }
 EXPORT_SYMBOL(skb_put);
@@ -1033,8 +987,7 @@ unsigned char *skb_push(struct sk_buff *skb, unsigned int len)
 {
 	skb->data -= len;
 	skb->len  += len;
-	if (unlikely(skb->data<skb->head))
-		skb_under_panic(skb, len, __builtin_return_address(0));
+	BUG_ON(skb->data < skb->head);
 	return skb->data;
 }
 EXPORT_SYMBOL(skb_push);

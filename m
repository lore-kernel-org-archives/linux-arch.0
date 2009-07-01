From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCHSET] percpu: generalize first chunk allocators and improve
 lpage NUMA support
Date: Wed, 01 Jul 2009 19:21:57 +0900
Message-ID: <4A4B38C5.1070504@kernel.org>
References: <1245850216-31653-1-git-send-email-tj@kernel.org> <20090624165508.30b88343.akpm@linux-foundation.org> <alpine.DEB.1.10.0906291920100.32637@gentwo.org> <20090629163937.94c8cedd.akpm@linux-foundation.org> <20090630191517.GB20567@elte.hu> <alpine.DEB.1.10.0906301533400.29795@gentwo.org> <20090630213146.GA17492@elte.hu> <alpine.DEB.1.10.0906301809330.11362@gentwo.org> <4A4A9DC6.6020003@kernel.org> <20090701064250.GM6760@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44682 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752681AbZGAKU1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 1 Jul 2009 06:20:27 -0400
In-Reply-To: <20090701064250.GM6760@one.firstfloor.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Christoph Lameter <cl@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de

Hello, Andi.

Andi Kleen wrote:
>> I don't think it will be too complex.  The necessary bits are already
>> there and they are necessary for other stuff too, so...
> 
> Are we looking at a different source base? Here's a random example
> using possible per cpu data I picked in current git: icmp.c

I was talking about percpu allocator proper.  Yeap, the major work
would be in auditing and converting for_each_possible_cpu() users.

> static int __net_init icmp_sk_init(struct net *net)
> {
>         int i, err;
> 
>         net->ipv4.icmp_sk =
>                 kzalloc(nr_cpu_ids * sizeof(struct sock *), GFP_KERNEL);
>         if (net->ipv4.icmp_sk == NULL)
>                 return -ENOMEM;
> 
>         for_each_possible_cpu(i) {
> 		... allocate per cpu socket and some other setup ...
> 	}
> } 
> 
> static void __net_exit icmp_sk_exit(struct net *net)
> {
>         int i;
> 
>         for_each_possible_cpu(i)
>                 inet_ctl_sock_destroy(net->ipv4.icmp_sk[i]);
>         kfree(net->ipv4.icmp_sk);
>         net->ipv4.icmp_sk = NULL;
> }
> 
> You would need to convert that to use a CPU notifier and callbacks
> setting up the sockets. Then make sure there are no races in all of
> this. And get it somehow tested (where is the user base who
> tests cpu hotplug?) 

Maybe it would be better to allocate percpu sockets as proper percpu
variables.  Initialization would still need callback mechanism tho.  I
was thinking about adding @init callback to percpu_alloc(), which
would be much simpler than doing full cpu hotplug callback.

> And there is lots of similar code all over the tree

For static percpu variables, it'll be mostly about converting
for_each_possible_cpu() to for_each_used_cpu() as both allocation and
initialization can be handled by percpu proper.  For dynamic areas,
allocation can be handled by percpu proper but cpus coming online
would need more work to convert.  It'll take some effort but there
aren't too many alloc_percpu() users yet and I don't think it will be
too difficult.  I wouldn't know for sure before I actually try tho.

Thanks.

-- 
tejun

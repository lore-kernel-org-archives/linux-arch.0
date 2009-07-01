From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCHSET] percpu: generalize first chunk allocators and improve lpage NUMA support
Date: Wed, 1 Jul 2009 08:42:50 +0200
Message-ID: <20090701064250.GM6760@one.firstfloor.org>
References: <1245850216-31653-1-git-send-email-tj@kernel.org> <20090624165508.30b88343.akpm@linux-foundation.org> <alpine.DEB.1.10.0906291920100.32637@gentwo.org> <20090629163937.94c8cedd.akpm@linux-foundation.org> <20090630191517.GB20567@elte.hu> <alpine.DEB.1.10.0906301533400.29795@gentwo.org> <20090630213146.GA17492@elte.hu> <alpine.DEB.1.10.0906301809330.11362@gentwo.org> <4A4A9DC6.6020003@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:53370 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbZGAGmr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jul 2009 02:42:47 -0400
Content-Disposition: inline
In-Reply-To: <4A4A9DC6.6020003@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, andi@firstfloor.org, hpa@zytor.com, tglx@linutronix.de

> I don't think it will be too complex.  The necessary bits are already
> there and they are necessary for other stuff too, so...

Are we looking at a different source base? Here's a random example
using possible per cpu data I picked in current git: icmp.c

static int __net_init icmp_sk_init(struct net *net)
{
        int i, err;

        net->ipv4.icmp_sk =
                kzalloc(nr_cpu_ids * sizeof(struct sock *), GFP_KERNEL);
        if (net->ipv4.icmp_sk == NULL)
                return -ENOMEM;

        for_each_possible_cpu(i) {
		... allocate per cpu socket and some other setup ...
	}
} 

static void __net_exit icmp_sk_exit(struct net *net)
{
        int i;

        for_each_possible_cpu(i)
                inet_ctl_sock_destroy(net->ipv4.icmp_sk[i]);
        kfree(net->ipv4.icmp_sk);
        net->ipv4.icmp_sk = NULL;
}

You would need to convert that to use a CPU notifier and callbacks
setting up the sockets. Then make sure there are no races in all of
this. And get it somehow tested (where is the user base who
tests cpu hotplug?) 

And there is lots of similar code all over the tree

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only.

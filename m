From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: + kthread-numa-aware-kthread_create_on_cpu.patch added to -mm
 tree
Date: Wed, 19 Jan 2011 12:59:38 -0800
Message-ID: <20110119125938.f6c9537a.akpm@linux-foundation.org>
References: <201012100044.oBA0ivp3016990@imap1.linux-foundation.org>
	<1293131522.2170.798.camel@laptop>
	<20110119120756.cd554fb1.akpm@linux-foundation.org>
	<1295468119.2653.2.camel@edumazet-laptop>
	<20110119201716.GH22288@tassilo.jf.intel.com>
	<1295468515.2653.4.camel@edumazet-laptop>
	<20110119124411.864d9d97.akpm@linux-foundation.org>
	<1295470247.2653.9.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53680 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752345Ab1ASVAU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 19 Jan 2011 16:00:20 -0500
In-Reply-To: <1295470247.2653.9.camel@edumazet-laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, davem@davemloft.net, dhowells@redhat.com, fenghua.yu@intel.com, linux-arch@vger.kernel.org, rusty@rustcorp.com.au, tj@kernel.org, tony.luck@intel.com

On Wed, 19 Jan 2011 21:50:47 +0100
Eric Dumazet <eric.dumazet@gmail.com> wrote:

> Le mercredi 19 janvier 2011 __ 12:44 -0800, Andrew Morton a __crit :
> > On Wed, 19 Jan 2011 21:21:55 +0100
> > Eric Dumazet <eric.dumazet@gmail.com> wrote:
> > 
> > > Le mercredi 19 janvier 2011 __ 12:17 -0800, Andi Kleen a __crit :
> > > > > 
> > > > > I wont discuss about a function _name_ Andrew.
> > > > > 
> > > > > If nobody can chose one better than the one I chosed, what can I do ?
> > > > 
> > > > kthread_create_node() would seem logical (with a node parameter)
> > > > 
> > > > -Andi
> > > 
> > > I already explained why I dont like this suggestion.
> > > 
> > > 1) My plan was to later add cpu affinity.
> > 
> > That would be called kthread_create_on_cpu() except whoops, this patch
> > already took that.
> > 
> 
> I surrender :)

Does that mean we have a name ;)

> I'll send a patch, or do you prefer I respin the 4 patches ?

I can trivially edit the patches locally if it's just a rename. 
kthread_create_for_cpu() would do the trick, I suggest.

If we decide on kthread_create_node(node_t) then that's a significant
rework.

I'm all worn out too and would be OK with either approach.

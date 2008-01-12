Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58635 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753358AbYALRdU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 12 Jan 2008 12:33:20 -0500
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH/RFC] synchronize_rcu(): high latency on idle system
Date: Sat, 12 Jan 2008 18:33:09 +0100
References: <20080112012626.GI28570@kvack.org> <1200129791.7999.5.camel@lappy>
In-Reply-To: <1200129791.7999.5.camel@lappy>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200801121833.09508.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Benjamin LaHaise <bcrl@kvack.org>, dipankar@in.ibm.com, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>

On Saturday 12 January 2008 10:23:11 Peter Zijlstra wrote:
> 
> On Fri, 2008-01-11 at 20:26 -0500, Benjamin LaHaise wrote:
> > Hello folks,
> > 
> > I'd like to put the patch below out for comments to see if folks think the 
> > approach is a valid fix to reduce the latency of synchronize_rcu().  The 
> > motivation is that an otherwise idle system takes about 3 ticks per network 
> > interface in unregister_netdev() due to multiple calls to synchronize_rcu(), 
> > which adds up to quite a few seconds for tearing down thousands of 
> > interfaces.  By flushing pending rcu callbacks in the idle loop, the system 
> > makes progress hundreds of times faster.  If this is indeed a sane thing to, 
> > it probably needs to be done for other architectures than x86.  And yes, the 
> > network stack shouldn't call synchronize_rcu() quite so much, but fixing that 
> > is a little more involved.
> 
> So, instead of only relying on the tick to drive the RCU state machine,
> you add the idle loop to it. This seems to make sense, esp because nohz
> is held off until rcu is idle too.

For NOHZ I agree it would be probably better to just force a quiescent
cycle than to schedule a one jiffie tick like it is currently done.

For non NOHZ I'm not so sure.

-Andi

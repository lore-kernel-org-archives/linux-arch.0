From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 17/19] locking/barriers: Kill lockless_dereference
Date: Tue, 24 Oct 2017 11:23:37 +0100
Message-ID: <20171024102336.GF17909@arm.com>
References: <20171023210408.GA2930@linux.vnet.ibm.com>
 <1508792849-3115-17-git-send-email-paulmck@linux.vnet.ibm.com>
 <20171024093104.rukpl26fukj7bxvg@gmail.com>
 <20171024094435.GC17909@arm.com>
 <20171024095428.tbx4g5gwjmmtcq6o@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53064 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932541AbdJXKXh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Oct 2017 06:23:37 -0400
Content-Disposition: inline
In-Reply-To: <20171024095428.tbx4g5gwjmmtcq6o@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mark.rutland@arm.com, snitzer@redhat.com, thor.thayer@linux.intel.com, viro@zeniv.linux.org.uk, davem@davemloft.net, shuah@kernel.org, mpe@ellerman.id.au, tj@kernel.org, torvalds@linux-foundation.org

On Tue, Oct 24, 2017 at 11:54:28AM +0200, Ingo Molnar wrote:
> * Will Deacon <will.deacon@arm.com> wrote:
> > On Tue, Oct 24, 2017 at 11:31:04AM +0200, Ingo Molnar wrote:
> > > Also, could we please split this into three patches:
> > > 
> > >  #1: Add smp_read_barrier_depends() to READ_ONCE()
> > >  #2: Convert all lockless_dereference() users to READ_ONCE()
> > >  #3: Remove the now unused lockless_dereference() API
> > > 
> > > to make it easier to analyze if bisected to, should any problems arise?
> > 
> > Sure, I'll do that now.
> 
> Thanks!

https://lkml.org/lkml/2017/10/24/323

Will

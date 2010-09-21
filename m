From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: memory barrier question
Date: Tue, 21 Sep 2010 07:59:10 -0700
Message-ID: <20100921145910.GA3358@linux.vnet.ibm.com>
References: <1284864421.30449.113.camel@pasglop>
 <20100919152638.GF3060@linux.vnet.ibm.com>
 <E1OxQIg-0005Nw-WE@pomaz-ex.szeredi.hu>
 <20100919215909.GG3060@linux.vnet.ibm.com>
 <1284944316.2957.795.camel@mulgrave.site>
 <20100920012915.GI3060@linux.vnet.ibm.com>
 <E1OxioY-0006nd-M9@pomaz-ex.szeredi.hu>
 <20100920182504.GD2408@linux.vnet.ibm.com>
 <4C97C366.80206@orcon.net.nz>
 <20100920204055.GJ2408@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:52493 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755906Ab0IUO7P (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 21 Sep 2010 10:59:15 -0400
Content-Disposition: inline
In-Reply-To: <20100920204055.GJ2408@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Cree <mcree@orcon.net.nz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, James.Bottomley@HansenPartnership.com, benh@kernel.crashing.org, dhowells@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Mon, Sep 20, 2010 at 01:40:55PM -0700, Paul E. McKenney wrote:
> On Tue, Sep 21, 2010 at 08:26:14AM +1200, Michael Cree wrote:
> > On 21/09/10 06:25, Paul E. McKenney wrote:
> > >But do we really care about Alpha anymore?  (I can see it now... The
> > >Alpha portion of the kernel tree moves to staging...)
> > 
> > I do.
> > 
> > Sent from my Compaq Alpha XP1000 :-)
> 
> In that case, an smp_read_barrier_depends() or rcu_dereference() is
> also required...

Wait a minute...  I finally got a chance to look up the system.  This
system has only a single Alpha CPU, right?

If so, just build a UP kernel and be happy.  No need to worry about
any of these SMP issues.

So, an alternative proposal -- support only UP kernels on Alpha.  ;-)

							Thanx, Paul

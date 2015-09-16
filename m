From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] barriers: introduce smp_mb__release_acquire and update
 documentation
Date: Wed, 16 Sep 2015 17:38:14 +0100
Message-ID: <20150916163813.GP28771@arm.com>
References: <1442333610-16228-1-git-send-email-will.deacon@arm.com>
 <20150916114918.GA12664@fixme-laptop.cn.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37507 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751965AbbIPQiL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 16 Sep 2015 12:38:11 -0400
Content-Disposition: inline
In-Reply-To: <20150916114918.GA12664@fixme-laptop.cn.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>

On Wed, Sep 16, 2015 at 12:49:18PM +0100, Boqun Feng wrote:
> Hi Will,

Hello,

> On Tue, Sep 15, 2015 at 05:13:30PM +0100, Will Deacon wrote:
> > +If necessary, ordering can be enforced by use of an
> > +smp_mb__release_acquire() barrier:
> > +
> > +	*A = a;
> > +	RELEASE M
> > +	smp_mb__release_acquire();
> 
> Should this barrier be placed after the ACQUIRE? Because we do actually
> want(?) and allow RELEASE and ACQUIRE operations to reorder in this
> case, like your following example, right?

I think it's a lot simpler to keep it where it is, in all honesty. The
relaxation for the RELEASE/ACQUIRE access ordering is mainly there to
allow architectures building those operations out of explicit barriers
to get away without a definition of smp_mb__release_acquire.

Will

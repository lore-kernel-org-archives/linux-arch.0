From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] locking/qspinlock: Use atomic_sub_return_release in
 queued_spin_unlock
Date: Tue, 14 Jun 2016 14:04:46 +0200
Message-ID: <20160614120446.GG30154@twins.programming.kicks-ass.net>
References: <1464943094-3129-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160613194523.GA2094@linux-80c1.suse>
 <20160614055253.GA20090@insomnia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:37877 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbcFNME5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jun 2016 08:04:57 -0400
Content-Disposition: inline
In-Reply-To: <20160614055253.GA20090@insomnia>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, waiman.long@hp.com

On Tue, Jun 14, 2016 at 01:52:53PM +0800, Boqun Feng wrote:
> On Mon, Jun 13, 2016 at 12:45:23PM -0700, Davidlohr Bueso wrote:
> > On Fri, 03 Jun 2016, Pan Xinhui wrote:
> > 
> > > The existing version uses a heavy barrier while only release semantics
> > > is required. So use atomic_sub_return_release instead.
> > > 
> > > Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> > 
> > I just noticed this change in -tip and, while I know that saving a barrier
> > in core spinlock paths is perhaps a worthy exception, I cannot help but
> > wonder if this is the begging of the end for smp__{before,after}_atomic().
> 
> This is surely a good direction I think, that is using _acquire and
> _release primitives to replace those barriers. However, I think we
> should do this carefully, because the _acquire and _release primitives
> are RCpc because they are on PPC, IOW, a ACQUIRE and RELEASE pair is not
> a full barrier nor provides global transivity. I'm worried about there
> are some users depending on the full-barrier semantics, which means we
> must audit each use carefully before we make the change.

Very good point indeed. And yes, the whole RCpc thing, but also the
tricky wandering store on PPC/ARM64 ACQUIRE makes for lots of 'fun' we
can do without.

> Besides, if we want to do the conversion, we'd better have _acquire and
> _release variants for non-value-returning atomic operations.

Indeed, I've been tempted to introduce those before.

> I remember you were working on those variants. How is that going?

Ah, if Davidlohr is working on that, brilliant, less work for me ;-)

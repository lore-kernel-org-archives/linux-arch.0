From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [RFC v2 3/4] Documentation/locking/atomic: Add a litmus test for
 atomic_set()
Date: Thu, 20 Feb 2020 08:27:17 +0800
Message-ID: <20200220002717.GG69864@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200219062627.104736-4-boqun.feng@gmail.com>
 <Pine.LNX.4.44L0.2002191004420.1514-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44640 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgBTA1X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 19:27:23 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2002191004420.1514-100000@iolanthe.rowland.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org

On Wed, Feb 19, 2020 at 10:07:09AM -0500, Alan Stern wrote:
> On Wed, 19 Feb 2020, Boqun Feng wrote:
> 
> > We already use a litmus test in atomic_t.txt to describe the behavior of
> > an atomic_set() with the an atomic RMW, so add it into atomic-tests
> > directory to make it easily accessible for anyone who cares about the
> > semantics of our atomic APIs.
> > 
> > Additionally, change the sentences describing the test in atomic_t.txt
> > with better wording.
> 
> One very minor point about the new working in atomic_t.txt:
> 
> > diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
> > index ceb85ada378e..d30cb3d87375 100644
> > --- a/Documentation/atomic_t.txt
> > +++ b/Documentation/atomic_t.txt
> > @@ -85,10 +85,10 @@ smp_store_release() respectively. Therefore, if you find yourself only using
> >  the Non-RMW operations of atomic_t, you do not in fact need atomic_t at all
> >  and are doing it wrong.
> >  
> > -A subtle detail of atomic_set{}() is that it should be observable to the RMW
> > -ops. That is:
> > +A note for the implementation of atomic_set{}() is that it cannot break the
> > +atomicity of the RMW ops. That is:
> 
> This would be slightly better if you changed it to: "it must not break".
> 

Got it. Indeed it's the better wording, thanks!

Regards,
Boqun

> The comments in the litmus test and README file are okay as they stand.
> 
> Alan
> 

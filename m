Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:32223
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1031181AbWI1CYl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 27 Sep 2006 22:24:41 -0400
Date: Wed, 27 Sep 2006 19:24:39 -0700 (PDT)
Message-Id: <20060927.192439.26965408.davem@davemloft.net>
Subject: Re: [PATCH] Fix zeroing on exception in copy_*_user
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060927091830.a4c75810.akpm@osdl.org>
References: <20060926171150.bab8a5c1.akpm@osdl.org>
	<1159349492.24891.16.camel@localhost>
	<20060927091830.a4c75810.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: akpm@osdl.org
Cc: schwidefsky@de.ibm.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Andrew Morton <akpm@osdl.org>
Date: Wed, 27 Sep 2006 09:18:30 -0700

> On Wed, 27 Sep 2006 11:31:32 +0200
> Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> 
> > On Tue, 2006-09-26 at 17:11 -0700, Andrew Morton wrote:
> > > I guess other architectures will need to do this.  See
> > > 01408c4939479ec46c15aa7ef6e2406be50eeeca and
> > > 7c12d81134b130ccd4c286b434ca48c4cda71a2f for the rationale.
> > 
> > Urgh, s390 does not have the problem that is does pad the leftover bytes
> > in __copy_from_user_inatomic but that is does NOT pad the leftover bytes
> > in __copy_from_user ..
> > 
> 
> That permits users to read uninitialised kernel memory by appending to a file
> from a bad address then reading the result back....

Right.

But wrt. *_inatomic() issue, you only need to add the new logic to
avoid zeroing at the end on a fault _iff_ kmap_atomic() is relevent on
your platform.  In particular, it's necessary if kmap_atomic() disables
preemption or anything like that.

So only a more limited set of platforms need to worry about this.
As far as I can tell, this means:

i386
FRV
MIPS
PPC
SPARC32

I'll try to take care of sparc32.


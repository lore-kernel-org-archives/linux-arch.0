Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40138 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728265AbfAGTCW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Jan 2019 14:02:22 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x07IhvfI129327
        for <linux-arch@vger.kernel.org>; Mon, 7 Jan 2019 14:02:22 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pvb4tw3y1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 07 Jan 2019 14:02:21 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 7 Jan 2019 19:02:20 -0000
Date: Mon, 7 Jan 2019 11:02:36 -0800
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH RFC 3/4] barriers: convert a control to a data dependency
Reply-To: paulmck@linux.ibm.com
References: <20190102205715.14054-1-mst@redhat.com>
 <20190102205715.14054-4-mst@redhat.com>
 <86023cbe-d1ae-a0d6-7b75-26556f1a0c1f@redhat.com>
 <20190106231756-mutt-send-email-mst@kernel.org>
 <20190107094610.GA2861@worktop.programming.kicks-ass.net>
 <20190107082223-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190107082223-mutt-send-email-mst@kernel.org>
Message-ID: <20190107190236.GF1215@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <andrea.parri@amarulasolutions.com>, Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, linux-arch@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Jonathan Corbet <corbet@lwn.net>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, linux-sparse@vger.kernel.org
Message-ID: <20190107190236.unSiHXFbcwEKYmqLvyaW2cE_98ESk9NHSSfuSS43mpA@z>

On Mon, Jan 07, 2019 at 08:36:36AM -0500, Michael S. Tsirkin wrote:
> On Mon, Jan 07, 2019 at 10:46:10AM +0100, Peter Zijlstra wrote:
> > On Sun, Jan 06, 2019 at 11:23:07PM -0500, Michael S. Tsirkin wrote:
> > > On Mon, Jan 07, 2019 at 11:58:23AM +0800, Jason Wang wrote:
> > > > On 2019/1/3 上午4:57, Michael S. Tsirkin wrote:
> > 
> > > > > +#if defined(COMPILER_HAS_OPTIMIZER_HIDE_VAR) && \
> > > > > +	!defined(ARCH_NEEDS_READ_BARRIER_DEPENDS)
> > > > > +
> > > > > +#define dependent_ptr_mb(ptr, val) ({					\
> > > > > +	long dependent_ptr_mb_val = (long)(val);			\
> > > > > +	long dependent_ptr_mb_ptr = (long)(ptr) - dependent_ptr_mb_val;	\
> > > > > +									\
> > > > > +	BUILD_BUG_ON(sizeof(val) > sizeof(long));			\
> > > > > +	OPTIMIZER_HIDE_VAR(dependent_ptr_mb_val);			\
> > > > > +	(typeof(ptr))(dependent_ptr_mb_ptr + dependent_ptr_mb_val);	\
> > > > > +})
> > > > > +
> > > > > +#else
> > > > > +
> > > > > +#define dependent_ptr_mb(ptr, val) ({ mb(); (ptr); })
> > > > 
> > > > 
> > > > So for the example of patch 4, we'd better fall back to rmb() or need a
> > > > dependent_ptr_rmb()?
> > > > 
> > > > Thanks
> > > 
> > > You mean for strongly ordered architectures like Intel?
> > > Yes, maybe it makes sense to have dependent_ptr_smp_rmb,
> > > dependent_ptr_dma_rmb and dependent_ptr_virt_rmb.
> > > 
> > > mb variant is unused right now so I'll remove it.
> > 
> > How about naming the thing: dependent_ptr() ? That is without any (r)mb
> > implications at all. The address dependency is strictly weaker than an
> > rmb in that it will only order the two loads in qestion and not, like
> > rmb, any prior to any later load.
> 
> So I'm fine with this as it's enough for virtio, but I would like to point out two things:
> 
> 1. E.g. on x86 both SMP and DMA variants can be NOPs but
> the madatory one can't, so assuming we do not want
> it to be stronger than rmp then either we want
> smp_dependent_ptr(), dma_dependent_ptr(), dependent_ptr()
> or we just will specify that dependent_ptr() works for
> both DMA and SMP.
> 
> 2. Down the road, someone might want to order a store after a load.
> Address dependency does that for us too. Assuming we make
> dependent_ptr a NOP on x86, we will want an mb variant
> which isn't a NOP on x86. Will we want to rename
> dependent_ptr to dependent_ptr_rmb at that point?

But x86 preserves store-after-load orderings anyway, and even Alpha
respects ordering from loads to dependent stores.  So what am I missing
here?

							Thanx, Paul

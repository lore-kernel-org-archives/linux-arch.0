From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 1/7] atomics: add acquire/release/relaxed variants of
 some atomic operations
Date: Fri, 17 Jul 2015 18:30:50 +0100
Message-ID: <20150717173050.GH8055@arm.com>
References: <1437060758-10381-1-git-send-email-will.deacon@arm.com>
 <1437060758-10381-2-git-send-email-will.deacon@arm.com>
 <55A84740.7080705@hp.com>
 <20150717094014.GD18994@arm.com>
 <55A9393A.403@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50132 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755849AbbGQRax (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 17 Jul 2015 13:30:53 -0400
Content-Disposition: inline
In-Reply-To: <55A9393A.403@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <waiman.long@hp.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>

On Fri, Jul 17, 2015 at 06:19:54PM +0100, Waiman Long wrote:
> On 07/17/2015 05:40 AM, Will Deacon wrote:
> > On Fri, Jul 17, 2015 at 01:07:28AM +0100, Waiman Long wrote:
> >> I have a minor nit. The atomic_add_return block is repeated with
> >> "s/atomic_add_return/.../". Perhaps some more comments to delineate the
> >> blocks more visibly will make this patch easier to read.
> > Yeah, I agree that it's pretty hard going, but I don't have any great
> > suggestions to solve that. I could add an extra blank line + comment
> > before the start of each section, if you like? Example snippet below.
> >
> > Will
> >
> > --->8
> >
> > [...]
> > #endif /* atomic_sub_return_relaxed */
> >
> >
> > /* atomic_xchg_relaxed */
> > #ifndef atomic_xchg_relaxed
> > #define  atomic_xchg_relaxed		atomic_xchg
> > #define  atomic_xchg_acquire		atomic_xchg
> > #define  atomic_xchg_release		atomic_xchg
> >
> > #else /* atomic_xchg_relaxed */
> >
> > #ifndef atomic_xchg_acquire
> > #define  atomic_xchg_acquire(...)					\
> > 	__atomic_op_acquire(int, atomic_xchg, __VA_ARGS__)
> > #endif
> >
> > #ifndef atomic_xchg_release
> > #define  atomic_xchg_release(...)					\
> > 	__atomic_op_release(int, atomic_xchg, __VA_ARGS__)
> > #endif
> >
> > #ifndef atomic_xchg
> > #define  atomic_xchg(...)						\
> > 	__atomic_op_fence(int, atomic_xchg, __VA_ARGS__)
> > #endif
> > #endif /* atomic_xchg_relaxed */
> >
> >
> > /* atomic_cmpxchg_relaxed */
> > [...]
> Something like
> 
> /* BEGIN atomc_xchg_relax */
> ...
> /* END atomic_xchg_relax */
> 
> may help.
> 
> Alternatively, I sometimes add a line separator like
> 
> /*===================[ atomic_xchg_relax ]====================*/

Hmm, I think we're straying into cosmetic preferences here and I can
imagine some people taking objection to the above, especially as they
don't appear to be in common use in mainline.

Will

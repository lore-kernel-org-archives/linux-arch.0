From: Hugh Dickins <hughd@google.com>
Subject: Re: [RFC] page-table walkers vs memory order
Date: Fri, 27 Jul 2012 12:22:46 -0700 (PDT)
Message-ID: <alpine.LSU.2.00.1207271155440.1328@eggly.anvils>
References: <1343064870.26034.23.camel@twins> <alpine.LSU.2.00.1207241356350.2094@eggly.anvils> <1343335169.32120.18.camel@twins>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55350 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404Ab2G0TXh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 27 Jul 2012 15:23:37 -0400
Received: by yenl2 with SMTP id l2so3566700yen.19
        for <linux-arch@vger.kernel.org>; Fri, 27 Jul 2012 12:23:37 -0700 (PDT)
In-Reply-To: <1343335169.32120.18.camel@twins>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@kernel.dk>, Andrea Arcangeli <aarcange@redhat.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org

On Thu, 26 Jul 2012, Peter Zijlstra wrote:
> On Tue, 2012-07-24 at 14:51 -0700, Hugh Dickins wrote:
> > I do love the status quo, but an audit would be welcome.  When
> > it comes to patches, personally I tend to prefer ACCESS_ONCE() and
> > smp_read_barrier_depends() and accompanying comments to be hidden away
> > in the underlying macros or inlines where reasonable, rather than
> > repeated all over; but I may have my priorities wrong on that.

I notice from that old radix_tree thread you pointed to in the previous
mail (for which many thanks: lots of meat to digest in there) that this
is also Linus's preference.

> > 
> > 
> Yeah, I was being lazy, and I totally forgot to actually look at the
> alpha code.
> 
> How about we do a generic (cribbed from rcu_dereference):
> 
> #define page_table_deref(p)					\
> ({								\
> 	typeof(*p) *______p = (typeof(*p) __force *)ACCESS_ONCE(p);\
> 	smp_read_barrier_depends();				\
> 	((typeof(*p) __force __kernel *)(______p));		\
> })
> 
> and use that all over to dereference page-tables. That way all this
> lives in one place. Granted, I'll have to go edit all arch code, but I
> seem to be doing that on a frequent basis anyway :/

If you're convinced that we now have (or are in danger of growing)
a number of places which need this safety, yes, I suppose so.

Personally, I'd have gone for just adding the relatively-understandable
ACCESS_ONCEs in all the arch/*/include/asm macros (which you're going to
visit to make the above change), and leave the smp_read_barrier_depends()
entirely in Alpha - one level of indirection less for the reader.
But that's just me, you're the one proposing to do the work, and
you may have very good reason for the above.

I'm unfamiliar with what value the __force __kernel annotations add.
But I am interested to notice that you are only 6/9ths as insane as
Paul: any chance of helping global underscore availability by not
hoarding quite so many in there? 

Hugh

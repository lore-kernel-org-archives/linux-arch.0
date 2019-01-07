Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43266 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbfAGSRD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Jan 2019 13:17:03 -0500
Date: Mon, 7 Jan 2019 13:16:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 2/4] include/linux/compiler.h: allow memory operands
Message-ID: <20190107131350-mutt-send-email-mst@kernel.org>
References: <20190102205715.14054-1-mst@redhat.com>
 <20190102205715.14054-3-mst@redhat.com>
 <20190107175427.GB22911@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107175427.GB22911@fuggles.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <andrea.parri@amarulasolutions.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, linux-arch@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org
Message-ID: <20190107181650.MUSqsOk9zJJnQ7qIL8_hv1Aem5jWHGgX3LkhK052wpU@z>

On Mon, Jan 07, 2019 at 05:54:27PM +0000, Will Deacon wrote:
> On Wed, Jan 02, 2019 at 03:57:54PM -0500, Michael S. Tsirkin wrote:
> > We don't really care whether the variable is in-register
> > or in-memory. Relax the constraint accordingly.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  include/linux/compiler.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > index 1ad367b4cd8d..6601d39e8c48 100644
> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -154,7 +154,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> >  #ifndef OPTIMIZER_HIDE_VAR
> >  /* Make the optimizer believe the variable can be manipulated arbitrarily. */
> >  #define OPTIMIZER_HIDE_VAR(var)						\
> > -	__asm__ ("" : "=r" (var) : "0" (var))
> > +	__asm__ ("" : "=rm" (var) : "0" (var))
> >  #endif
> 
> I think this can break for architectures with write-back addressing modes
> such as arm, where the "m" constraint is assumed to be evaluated precisely
> once in the asm block.
> 
> Will

Thanks, I'll drop this patch.

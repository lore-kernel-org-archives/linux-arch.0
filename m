From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 1/3] refcount: Create unchecked atomic_t implementation
Date: Wed, 31 May 2017 13:09:18 +0200
Message-ID: <20170531110918.tgbppvxgkkhoaclk@hirez.programming.kicks-ass.net>
References: <1496180392-98718-1-git-send-email-keescook@chromium.org>
 <1496180392-98718-2-git-send-email-keescook@chromium.org>
 <2236FBA76BA1254E88B949DDB74E612B6B215E2E@IRSMSX102.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:37698 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbdEaLJs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2017 07:09:48 -0400
Content-Disposition: inline
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612B6B215E2E@IRSMSX102.ger.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: Kees Cook <keescook@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, PaX Team <pageexec@freemail.hu>, Jann Horn <jannh@google.com>, Eric Biggers <ebiggers3@gmail.com>, Hans Liljestrand <ishkamiel@gmail.com>, David Windsor <dwindsor@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>, "arozansk@redhat.com" <arozansk@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>, Manfred Spraul <manfred@colorfullife.com>, "axboe@kernel.dk" <axboe@kernel.dk>, James

On Wed, May 31, 2017 at 10:45:09AM +0000, Reshetova, Elena wrote:

> > +static inline __must_check bool refcount_add_not_zero(unsigned int i,
> > +
> > 	      refcount_t *r)
> > +{
> > +	return atomic_add_return(i, &r->refs) != 0;
> > +}
> 
> Maybe atomic_add_unless(&r->refs, i, 0) in order to be consistent with the below inc_not_zero implementation?

Yes, atomic_add_return() is strictly incorrect here since the add is
unconditional.

> > +static inline __must_check bool refcount_sub_and_test(unsigned int i,
> > +
> > 	      refcount_t *r)
> > +{
> > +	return atomic_sub_return(i, &r->refs) == 0;
> > +}
> 
> Any reason for not using atomic_sub_and_test() here?

> > +static inline __must_check bool refcount_dec_and_test(refcount_t *r)
> > +{
> > +	return atomic_dec_return(&r->refs) == 0;
> > +}
> 
> Same here: atomic_dec_and_test()?

Both those are better because they return condition codes generated from
the operand itself.

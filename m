From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [tip:locking/core] locking/refcount: Create unchecked atomic_t
 implementation
Date: Mon, 4 Sep 2017 21:36:43 +0200
Message-ID: <20170904193643.GC17526@worktop.programming.kicks-ass.net>
References: <20170621200026.GA115679@beast>
 <tip-fd25d19f6b8da315332bb75936605fb45d3ea981@git.kernel.org>
 <20170904123724.5trepllnd25r4uyt@hirez.programming.kicks-ass.net>
 <20170904173444.GA7233@avx2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:47982 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753957AbdIDTgs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Sep 2017 15:36:48 -0400
Content-Disposition: inline
In-Reply-To: <20170904173444.GA7233@avx2>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: davem@davemloft.net, arnd@arndb.de, manfred@colorfullife.com, riel@redhat.com, hpa@zytor.com, ebiggers3@gmail.com, elena.reshetova@intel.com, keescook@chromium.org, dwindsor@gmail.com, mingo@kernel.org, jannh@google.com, serge@hallyn.com, gregkh@linuxfoundation.org, ebiederm@xmission.com, ishkamiel@gmail.com, tglx@linutronix.de, hch@infradead.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, dave@stgolabs.net, linux-arch@vger.kernel.org, James.Bottomley@hansenpartnership.com, linux-tip-commits@vger.kernel.org

On Mon, Sep 04, 2017 at 08:34:44PM +0300, Alexey Dobriyan wrote:
> On Mon, Sep 04, 2017 at 02:37:24PM +0200, Peter Zijlstra wrote:
> > -	 once.o refcount.o usercopy.o errseq.o
> > -obj-y += string_helpers.o
> > +	 once.o usercopy.o errseq.o string_helpers.o hexdump.o kstrtox.o
> > +
> > +obj-$(CONFIG_REFCOUNT_FULL) += refcount.o
> >  obj-$(CONFIG_TEST_STRING_HELPERS) += test-string_helpers.o
> > -obj-y += hexdump.o
> >  obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
> > -obj-y += kstrtox.o
> 
> File per line so everything is not lumped together even if it is obj-y.

If that is policy mass convert everything and be done with it. Otherwise
I'll continue to use the predominant pattern, which in this case is a
giant obj-y +=. But mixed stuff is terribly annoying.

From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [tip:locking/core] locking/refcount: Create unchecked atomic_t
 implementation
Date: Tue, 5 Sep 2017 21:15:36 +0300
Message-ID: <20170905181536.GA7482@avx2>
References: <20170621200026.GA115679@beast>
 <tip-fd25d19f6b8da315332bb75936605fb45d3ea981@git.kernel.org>
 <20170904123724.5trepllnd25r4uyt@hirez.programming.kicks-ass.net>
 <20170904173444.GA7233@avx2>
 <20170904193643.GC17526@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35051 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbdIESPm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Sep 2017 14:15:42 -0400
Content-Disposition: inline
In-Reply-To: <20170904193643.GC17526@worktop.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: davem@davemloft.net, arnd@arndb.de, manfred@colorfullife.com, riel@redhat.com, hpa@zytor.com, ebiggers3@gmail.com, elena.reshetova@intel.com, keescook@chromium.org, dwindsor@gmail.com, mingo@kernel.org, jannh@google.com, serge@hallyn.com, gregkh@linuxfoundation.org, ebiederm@xmission.com, ishkamiel@gmail.com, tglx@linutronix.de, hch@infradead.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, dave@stgolabs.net, linux-arch@vger.kernel.org, James.Bottomley@hansenpartnership.com, linux-tip-commits@vger.kernel.org

On Mon, Sep 04, 2017 at 09:36:43PM +0200, Peter Zijlstra wrote:
> On Mon, Sep 04, 2017 at 08:34:44PM +0300, Alexey Dobriyan wrote:
> > On Mon, Sep 04, 2017 at 02:37:24PM +0200, Peter Zijlstra wrote:
> > > -	 once.o refcount.o usercopy.o errseq.o
> > > -obj-y += string_helpers.o
> > > +	 once.o usercopy.o errseq.o string_helpers.o hexdump.o kstrtox.o
> > > +
> > > +obj-$(CONFIG_REFCOUNT_FULL) += refcount.o
> > >  obj-$(CONFIG_TEST_STRING_HELPERS) += test-string_helpers.o
> > > -obj-y += hexdump.o
> > >  obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
> > > -obj-y += kstrtox.o
> > 
> > File per line so everything is not lumped together even if it is obj-y.
> 
> If that is policy mass convert everything and be done with it. Otherwise
> I'll continue to use the predominant pattern, which in this case is a
> giant obj-y +=. But mixed stuff is terribly annoying.

It is not a policy, just a "grassroot" movement to give people good
example and wait until someone is annoyed enough to mass convert
everything. -)

Worked for fs/proc/Makefile .

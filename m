Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43494 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727286AbfBUIij (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 Feb 2019 03:38:39 -0500
Date: Thu, 21 Feb 2019 09:38:35 +0100
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 1/7] dump_stack: Support adding to the dump stack arch
 description
Message-ID: <20190221083835.pwwwcqtwfucxkday@pathway.suse.cz>
References: <20190207124635.3885-1-mpe@ellerman.id.au>
 <20190211125035.GA1562@andrea>
 <20190211143859.dd2lkccxod3f2fwn@pathway.suse.cz>
 <20190219233925.GA5648@andrea>
 <87va1e7pw2.fsf@concordia.ellerman.id.au>
 <20190220134433.GA4932@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220134433.GA4932@andrea>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, tj@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, dyoung@redhat.com, sergey.senozhatsky@gmail.com, Steven Rostedt <rostedt@goodmis.org>
Message-ID: <20190221083835.VEZ27_GOkbpZgGyB8PAuW84YDbKtAYhVn7RK1LQTofs@z>

On Wed 2019-02-20 14:44:33, Andrea Parri wrote:
> > >> > > +		 * Order the stores above in vsnprintf() vs the store of the
> > >> > > +		 * space below which joins the two strings. Note this doesn't
> > >> > > +		 * make the code truly race free because there is no barrier on
> > >> > > +		 * the read side. ie. Another CPU might load the uninitialised
> > >> > > +		 * tail of the buffer first and then the space below (rather
> > >> > > +		 * than the NULL that was there previously), and so print the
> > >> > > +		 * uninitialised tail. But the whole string lives in BSS so in
> > >> > > +		 * practice it should just see NULLs.
> > >> > 
> > It is not my intention to support concurrent updates of the string. The
> > idea is you setup the string early in boot.
> 
> Understood, thanks for the clarification.
> > 
> > The concern with a concurrent reader is simply that the string is dumped
> > in the panic path, and you never really know when you're going to panic.
> > Even if you only write to the string before doing SMP bringup you might
> > still have another CPU go rogue and panic before then.
> > 
> > But I probably should have just not added the barrier, it's over
> > paranoid and will almost certainly never matter in practice.
> 
> Oh, well, I can only echo you: if you don't care about the stores being
> _observed_ out of order, you could simply remove the barrier; if you do
> care, then you need "more paranoid" on the readers side.  ;-)

Hmm, the barrier might be fine and actually useful. The
purpose is to make sure that the later '\0' is written before
the existing one is replaced by ' '.

The reader does not need the barrier as long as it reads the string
sequentially. I would expect that it is always the case. But who
knows with all the speculation-related CPU bugs around.

In each case, any race could never crash the kernel.
The dump_stack_arch_desc_str is zeroed out of box and
the very last '\0' is never rewritten.

Best Regards,
Petr

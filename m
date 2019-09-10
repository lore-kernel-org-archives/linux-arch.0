Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34529 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfIJJQY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Sep 2019 05:16:24 -0400
Date: Tue, 10 Sep 2019 18:16:19 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v2 7/7] bug: Move WARN_ON() "cut here" into exception
 handler
Message-ID: <20190910091619.GA207290@jagdpanzerIV>
References: <201908200943.601DD59DCE@keescook>
 <20190909160539.GA989@tigerII.localdomain>
 <201909100157.CEE99802C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201909100157.CEE99802C@keescook>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Christophe Leroy <christophe.leroy@c-s.fr>, Peter Zijlstra <peterz@infradead.org>, Drew Davenport <ddavenport@chromium.org>, Arnd Bergmann <arnd@arndb.de>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Feng Tang <feng.tang@intel.com>, Petr Mladek <pmladek@suse.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Borislav Petkov <bp@suse.de>, YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190910091619.nEx7H8i1rGTcoeCl5eqZubLYxw3cYJE9p00pRLW4Flg@z>

On (09/10/19 01:59), Kees Cook wrote:
> On Tue, Sep 10, 2019 at 01:05:39AM +0900, Sergey Senozhatsky wrote:
> > On (08/20/19 09:47), Kees Cook wrote:
> > [..]
> > > +	/*
> > > +	 * BUG() and WARN_ON() families don't print a custom debug message
> > > +	 * before triggering the exception handler, so we must add the
> > > +	 * "cut here" line now. WARN() issues its own "cut here" before the
> > > +	 * extra debugging message it writes before triggering the handler.
> > > +	 */
> > > +	if ((bug->flags & BUGFLAG_NO_CUT_HERE) == 0)
> > > +		printk(KERN_DEFAULT CUT_HERE);
> > 
> > Shouldn't this be pr_warn() or pr_crit()?
> 
> The pr_* helpers here would (potentially) add unwanted prefixes, so
> those aren't used. KERN_DEFAULT is used here because that's how it's
> always been printed. I didn't want to change that for this refactoring
> work. I'm not opposed to it, generally speaking, though. :)

I just glanced through CUT_HERE users

warn_slowpath_fmt()    pr_warn(CUT_HERE)
__warn_printk()        pr_warn(CUT_HERE)
rdma_restrack_clean()  pr_err("restrack: %s", CUT_HERE)
rdma_restrack_clean()  pr_err("restrack: %s", CUT_HERE)

+ oops/panic end markers are of pr_warn() or pr_crit() log levels.
So I thought that maybe we can make it more or less similar.

But if it has always been this way (KERN_DEFAULT) then OK.

	-ss

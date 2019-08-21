Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbfHUBOg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Aug 2019 21:14:36 -0400
Date: Tue, 20 Aug 2019 21:14:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 7/7] bug: Move WARN_ON() "cut here" into exception
 handler
Message-ID: <20190820211429.7030b6f6@oasis.local.home>
In-Reply-To: <06ba33fd-27cc-3816-1cdf-70616b1782dd@c-s.fr>
References: <20190819234111.9019-1-keescook@chromium.org>
        <20190819234111.9019-8-keescook@chromium.org>
        <20190820100638.GK2332@hirez.programming.kicks-ass.net>
        <06ba33fd-27cc-3816-1cdf-70616b1782dd@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Peter Zijlstra <peterz@infradead.org>, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, Drew Davenport <ddavenport@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Feng Tang <feng.tang@intel.com>, Petr Mladek <pmladek@suse.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Borislav Petkov <bp@suse.de>, YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190821011429.3Yj4jfGE5dXwLQn3KZmm5jYQBCBqZ04QzP3aafwUtNQ@z>

On Tue, 20 Aug 2019 12:58:49 +0200
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> >> index 1077366f496b..6c22e8a6f9de 100644
> >> --- a/lib/bug.c
> >> +++ b/lib/bug.c
> >> @@ -181,6 +181,15 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
> >>   		}
> >>   	}
> >>   
> >> +	/*
> >> +	 * BUG() and WARN_ON() families don't print a custom debug message
> >> +	 * before triggering the exception handler, so we must add the
> >> +	 * "cut here" line now. WARN() issues its own "cut here" before the
> >> +	 * extra debugging message it writes before triggering the handler.
> >> +	 */
> >> +	if ((bug->flags & BUGFLAG_PRINTK) == 0)
> >> +		printk(KERN_DEFAULT CUT_HERE);  
> > 
> > I'm not loving that BUGFLAG_PRINTK name, BUGFLAG_CUT_HERE makes more
> > sense to me.
> >   
> 
> Actually it would be BUGFLAG_NO_CUT_HERE then, otherwise all arches not 
> using the generic macros will have to add the flag to get the "cut here" 
> line.
>

Perhaps they all should be audited to see if they don't have the same
problem?

-- Steve

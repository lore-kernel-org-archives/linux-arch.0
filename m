From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 7/7] bug: Move WARN_ON() "cut here" into exception
 handler
Date: Tue, 20 Aug 2019 21:14:29 -0400
Message-ID: <20190820211429.7030b6f6@oasis.local.home>
References: <20190819234111.9019-1-keescook@chromium.org>
        <20190819234111.9019-8-keescook@chromium.org>
        <20190820100638.GK2332@hirez.programming.kicks-ass.net>
        <06ba33fd-27cc-3816-1cdf-70616b1782dd@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <06ba33fd-27cc-3816-1cdf-70616b1782dd@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Peter Zijlstra <peterz@infradead.org>, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, Drew Davenport <ddavenport@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Feng Tang <feng.tang@intel.com>, Petr Mladek <pmladek@suse.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Borislav Petkov <bp@suse.de>, YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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

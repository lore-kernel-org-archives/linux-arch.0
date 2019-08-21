From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 7/7] bug: Move WARN_ON() "cut here" into exception
 handler
Date: Tue, 20 Aug 2019 20:50:20 -0400
Message-ID: <20190820205020.1fc22706@oasis.local.home>
References: <20190819234111.9019-1-keescook@chromium.org>
        <20190819234111.9019-8-keescook@chromium.org>
        <20190820100638.GK2332@hirez.programming.kicks-ass.net>
        <06ba33fd-27cc-3816-1cdf-70616b1782dd@c-s.fr>
        <201908200908.6437DF5@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201908200908.6437DF5@keescook>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Drew Davenport <ddavenport@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Feng Tang <feng.tang@intel.com>, Petr Mladek <pmladek@suse.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Borislav Petkov <bp@suse.de>, YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, 20 Aug 2019 09:33:24 -0700
Kees Cook <keescook@chromium.org> wrote:
> > > > diff --git a/lib/bug.c b/lib/bug.c
> > > > index 1077366f496b..6c22e8a6f9de 100644
> > > > --- a/lib/bug.c
> > > > +++ b/lib/bug.c
> > > > @@ -181,6 +181,15 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
> > > >   		}
> > > >   	}
> > > > +	/*
> > > > +	 * BUG() and WARN_ON() families don't print a custom debug message
> > > > +	 * before triggering the exception handler, so we must add the
> > > > +	 * "cut here" line now. WARN() issues its own "cut here" before the
> > > > +	 * extra debugging message it writes before triggering the handler.
> > > > +	 */
> > > > +	if ((bug->flags & BUGFLAG_PRINTK) == 0)
> > > > +		printk(KERN_DEFAULT CUT_HERE);  
> > > 
> > > I'm not loving that BUGFLAG_PRINTK name, BUGFLAG_CUT_HERE makes more
> > > sense to me.  
> 
> That's fine -- easy rename. :)
> 
> > Actually it would be BUGFLAG_NO_CUT_HERE then, otherwise all arches not
> > using the generic macros will have to add the flag to get the "cut here"
> > line.  
> 
> I am testing for the lack of the flag (so that only the
> CONFIG_GENERIC_BUG with __WARN_FLAGS case needs to set it). I was
> thinking of the flag to mean "this reporting flow has already issued
> cut-here". It sounds like it would be more logical to have it named
> BUGFLAG_NO_CUT_HERE to mean "do not issue a cut-here; it has already
> happened"? I will update the patch.
> 

 BUGFLAG_HAS_CUT_HERE ?

As it shows it was already done?

-- Steve

Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37524 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfH1Rge (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Aug 2019 13:36:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id d1so109135pgp.4
        for <linux-arch@vger.kernel.org>; Wed, 28 Aug 2019 10:36:34 -0700 (PDT)
Date: Sat, 24 Aug 2019 10:17:39 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 7/7] bug: Move WARN_ON() "cut here" into exception handler
Message-ID: <201908241016.9DCD43AF1@keescook>
References: <20190819234111.9019-1-keescook@chromium.org>
 <20190819234111.9019-8-keescook@chromium.org>
 <20190820100638.GK2332@hirez.programming.kicks-ass.net>
 <06ba33fd-27cc-3816-1cdf-70616b1782dd@c-s.fr>
 <20190820211429.7030b6f6@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820211429.7030b6f6@oasis.local.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Drew Davenport <ddavenport@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Feng Tang <feng.tang@intel.com>, Petr Mladek <pmladek@suse.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Borislav Petkov <bp@suse.de>, YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190824171739.Ha3V1XVZ-nExrtiEB5ajUh5CHmqIOGmX1stYjKridBA@z>

On Tue, Aug 20, 2019 at 09:14:29PM -0400, Steven Rostedt wrote:
> On Tue, 20 Aug 2019 12:58:49 +0200
> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> 
> > >> index 1077366f496b..6c22e8a6f9de 100644
> > >> --- a/lib/bug.c
> > >> +++ b/lib/bug.c
> > >> @@ -181,6 +181,15 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
> > >>   		}
> > >>   	}
> > >>   
> > >> +	/*
> > >> +	 * BUG() and WARN_ON() families don't print a custom debug message
> > >> +	 * before triggering the exception handler, so we must add the
> > >> +	 * "cut here" line now. WARN() issues its own "cut here" before the
> > >> +	 * extra debugging message it writes before triggering the handler.
> > >> +	 */
> > >> +	if ((bug->flags & BUGFLAG_PRINTK) == 0)
> > >> +		printk(KERN_DEFAULT CUT_HERE);  
> > > 
> > > I'm not loving that BUGFLAG_PRINTK name, BUGFLAG_CUT_HERE makes more
> > > sense to me.
> > >   
> > 
> > Actually it would be BUGFLAG_NO_CUT_HERE then, otherwise all arches not 
> > using the generic macros will have to add the flag to get the "cut here" 
> > line.
> >
> 
> Perhaps they all should be audited to see if they don't have the same
> problem?

As far as I could tell, all the other combinations end up either using
the slow path bug helpers or the common exception handler.
warn-with-a-fmt-string is the only case that does the "early cut here".

-- 
Kees Cook

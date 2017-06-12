From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v5 1/6] asm-generic/bug.h: declare struct pt_regs;
 before function prototype
Date: Mon, 12 Jun 2017 10:15:54 -0400
Message-ID: <20170612101554.62828f32@gandalf.local.home>
References: <20170525120316.24473-1-abbotti@mev.co.uk>
        <20170525120316.24473-2-abbotti@mev.co.uk>
        <20170608100731.43ee0323@gandalf.local.home>
        <20489607-25ef-1cbc-3679-6d4c7253514b@mev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20489607-25ef-1cbc-3679-6d4c7253514b@mev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Abbott <abbotti@mev.co.uk>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alexander Potapenko <glider@google.com>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Jakub Kicinski <jakub.kicinski@netronome.com>, Johannes Berg <johannes.berg@intel.com>, Kees Cook <keescook@chromium.org>, Michal Nazarewicz <mina86@mina86.com>, Peter Zijlstra <peterz@infradead.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
List-Id: linux-arch.vger.kernel.org

On Mon, 12 Jun 2017 15:13:54 +0100
Ian Abbott <abbotti@mev.co.uk> wrote:

> >> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
> >> index d6f4aed479a1..87191357d303 100644
> >> --- a/include/asm-generic/bug.h
> >> +++ b/include/asm-generic/bug.h
> >> @@ -97,6 +97,7 @@ extern void warn_slowpath_null(const char *file, const int line);
> >>
> >>  /* used internally by panic.c */
> >>  struct warn_args;
> >> +struct pt_regs;  
> >
> > Probably be better to move pt_regs above the comment. For one, it is
> > used before warn_args in the function below. Two, it's not defined
> > internally by panic.c like warn_args is.  
> 
> Alternatively, the comment could be placed on the same line as `struct 
> warn_args;`.  I don't think it's a big enough of a deal to patch it for 
> the sake of it, tbh.

trivial clean up patches are fine to add for merge windows.

Could just write a patch and send it to the trivial maintainer.

-- Steve

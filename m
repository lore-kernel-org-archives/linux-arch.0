From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH 1/2] Add thread_info_cache_init() to all archs
Date: Thu, 17 Apr 2008 21:19:05 -0700
Message-ID: <20080417211905.8ff769fa.akpm@linux-foundation.org>
References: <20080410032354.90CB1DDF0F@ozlabs.org>
	<20080413171953.bde5e9ac.akpm@linux-foundation.org>
	<1208133506.6958.82.camel@pasglop>
	<20080413191338.9776ebd0.akpm@linux-foundation.org>
	<1208491086.6958.381.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1208491086.6958.381.camel@pasglop>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, takata-TMSiXQfHlQjsTix1lMzHGQ@public.gmane.org, linux-m32r-rQhvJZKUsGBRYuoOT4C5/9i2O/JbrIOy@public.gmane.org, Linux-Arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Fri, 18 Apr 2008 13:58:06 +1000 Benjamin Herrenschmidt <benh-mnsaURCQ41sdnm+yROfE0A@public.gmane.org> wrote:

> 
> > > > otoh, if only one .c file will ever call this function then I think that
> > > > all problems are solved by
> > > > 
> > > > a) moving the above ifdeffery into the .c file
> > > > b) adding a comment explaining which arch file must provide the override
> > > > c) directly including that file from within the .c file.
> > > 
> > > I can definitely do that. I have no problem either way. I can add to all
> > > archs too, it's just that whatever way I choose, some people won't be
> > > happy with it :-)
> > > 
> > > Anyway, I'll move the ifdeferry to init/main.c then.
> > 
> > Thanks ;)
> > 
> > I'm still wounded by my recent encounter with set_softirq_pending()
> > and or_softirq_pending().
> 
> Well, looking there, I saw we already used weak symbols for that

Yes, `weak' is a nice solution.  It does add a few bytes of text which we
could avoid with compile-time trickery, but only a very few.

Plus this is __init anyway, although I don't know how well the combination
of `weak' and __init works.


> so what
> about the patch below ?

I like it, but the compiler won't ;)

> If you're ok, I'll re-send with appropriate sob
> & adapted powerpc part.

Sure.

> +void __init __attribute__((weak) thread_info_cache_init(void)

s/weak)/weak))/

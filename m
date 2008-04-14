From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH 1/2] Add thread_info_cache_init() to all archs
Date: Sun, 13 Apr 2008 19:13:38 -0700
Message-ID: <20080413191338.9776ebd0.akpm@linux-foundation.org>
References: <20080410032354.90CB1DDF0F@ozlabs.org>
	<20080413171953.bde5e9ac.akpm@linux-foundation.org>
	<1208133506.6958.82.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1208133506.6958.82.camel@pasglop>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, takata-TMSiXQfHlQjsTix1lMzHGQ@public.gmane.org, linux-m32r-rQhvJZKUsGBRYuoOT4C5/9i2O/JbrIOy@public.gmane.org, Linux-Arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mon, 14 Apr 2008 10:38:26 +1000 Benjamin Herrenschmidt <benh-mnsaURCQ41sdnm+yROfE0A@public.gmane.org> wrote:

> > > +#ifndef thread_info_cache_init
> > > +#define thread_info_cache_init	do { } while(0)
> > > +#endif
> > 
> > This trick does cause a bit of a problem: it is undefined which arch header
> > file is to provide the alternative definition of thread_info_cache_init.
> 
> I this case it's well defined: thread_info.h. Maybe I should add a
> comment ?
> 
> > So we can (and have) ended up in the situation where the override appears
> > in different files on different architectures and various screwups ensue.
> 
> Yup.
> 
> > So I'd suggest that we have a bigfatcomment telling implementors which file
> > the override should be implemented in.  And make sure that this arch file is
> > directly included from within sched.h.
> 
> Will do.
> 
> > I have a suspicion that we can still get in a mess if .c files include the
> > per-arch file and don't include sched.h, but I forget where this happened
> > and why it broke stuff.
> 
> In this case, there's only one call site and will only every be one, so
> that shouldn't be a problem. I don't see init/main.c not including
> sched.h

As long as init.c directly includes sched.h, and as long as sched.h
directly includes thread_info.h and as long as all architectures which
provide the override put it in their thread_info.h, and as long as the same
applies to all future .c users, we're good.  That's a lot of "as long as"'s ;)

> > Sigh.  A nice, coded-in-C implementation within each and every architecture
> > remains the best implementation, and all the little tricks-to-save-typing
> > have failure modes.
> 
> Well, I started doing it in all arch, and people around here told me
> that was not a good idea , that it would be trouble if the prototype
> ever had to change (adding an arg, etc... though very unlikely to happen
> in that case, granted).

Bah.  Use of grep and basic typing skills: not so hard.

> > otoh, if only one .c file will ever call this function then I think that
> > all problems are solved by
> > 
> > a) moving the above ifdeffery into the .c file
> > b) adding a comment explaining which arch file must provide the override
> > c) directly including that file from within the .c file.
> 
> I can definitely do that. I have no problem either way. I can add to all
> archs too, it's just that whatever way I choose, some people won't be
> happy with it :-)
> 
> Anyway, I'll move the ifdeferry to init/main.c then.

Thanks ;)

I'm still wounded by my recent encounter with set_softirq_pending()
and or_softirq_pending().

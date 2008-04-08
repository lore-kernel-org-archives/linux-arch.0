From: Oleg Nesterov <oleg-6lXkIZvqkOAvJsYlp49lxw@public.gmane.org>
Subject: Re: [PATCH 2/4] set_restore_sigmask TIF_SIGPENDING
Date: Tue, 8 Apr 2008 15:35:19 +0400
Message-ID: <20080408113519.GA227@tv-sign.ru>
References: <20080329001230.D013726FA1D@magilla.localdomain> <20080329001341.7F93826FA1D@magilla.localdomain> <alpine.LFD.1.00.0803281746480.14670@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0803281746480.14670-5CScLwifNT1QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Roland McGrath <roland-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Roland, Linus, I'm sorry for being offtopic, but there is something
I can't understand from the very beginning, when TIF_RESTORE_SIGMASK
was introduced.

On 03/28, Linus Torvalds wrote:
> 
> On Fri, 28 Mar 2008, Roland McGrath wrote:
> >
> > Set TIF_SIGPENDING in set_restore_sigmask.  This lets arch code take
> > TIF_RESTORE_SIGMASK out of the set of bits that will be noticed on
> > return to user mode.  On some machines those bits are scarce, and we
> > can free this unneeded one up for other uses.
> 
> Hmm. That probably means that TIF_RESTORE_SIGMASK shouldn't be a "TIF" 
> flag at all,

Yes!

> but a "TS" ("thread status") flag.

Why do we need any flag? It looks a bit ugly. Isn't it better to introduce
the new magic ERESTART_XXX which means ERESTARTNOHAND + restore-sigmask ?

We only need this flag as an implicit parameter to the arch dependent do_signal()
which we can't call directly, and thus it must imply TIF_SIGPENDING, and it
is not valid after do_signal() (should be cleared). This all looks like
ERESTART_ magic, why should we add something else ?

See also http://marc.info/?l=linux-kernel&m=113734458516136

Of course, probably it is too late to change the implementation even if
I am right, the question is: what I am missed?

Oleg.

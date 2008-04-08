From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH 2/4] set_restore_sigmask TIF_SIGPENDING
Date: Tue, 8 Apr 2008 07:53:15 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0804080748320.2886@woody.linux-foundation.org>
References: <20080329001230.D013726FA1D@magilla.localdomain> <20080329001341.7F93826FA1D@magilla.localdomain> <alpine.LFD.1.00.0803281746480.14670@woody.linux-foundation.org> <20080408113519.GA227@tv-sign.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080408113519.GA227-6lXkIZvqkOAvJsYlp49lxw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg-6lXkIZvqkOAvJsYlp49lxw@public.gmane.org>
Cc: Roland McGrath <roland-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org



On Tue, 8 Apr 2008, Oleg Nesterov wrote:
> 
> We only need this flag as an implicit parameter to the arch dependent do_signal()
> which we can't call directly, and thus it must imply TIF_SIGPENDING, and it
> is not valid after do_signal() (should be cleared). This all looks like
> ERESTART_ magic, why should we add something else ?

I think you're right. I didn't look at the actual code-paths, but my gut 
feel says "yes, TIF_RESTORE_SIGMASK should actually have been 
-ERESTARTSIGRESTORE". That sounds like the right thing to do.

		Linus

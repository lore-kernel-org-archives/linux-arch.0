From: Roland McGrath <roland-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/4] set_restore_sigmask TIF_SIGPENDING
Date: Tue,  8 Apr 2008 12:51:43 -0700 (PDT)
Message-ID: <20080408195143.57F3326F992@magilla.localdomain>
References: <20080329001230.D013726FA1D@magilla.localdomain>
	<20080329001341.7F93826FA1D@magilla.localdomain>
	<alpine.LFD.1.00.0803281746480.14670@woody.linux-foundation.org>
	<20080408113519.GA227@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: Oleg Nesterov's message of  Tuesday, 8 April 2008 15:35:19 +0400 <20080408113519.GA227-6lXkIZvqkOAvJsYlp49lxw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg-6lXkIZvqkOAvJsYlp49lxw@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Off hand, I concur with you and Linus.  I wasn't involved in the
introduction of TIF_RESTORE_SIGMASK and never thought too much about
it before.  In my recent changes I only considered the issue of
getting it out of _TIF_WORK_MASK et al to free up the low bit, and
didn't contemplate the structure of the implementation beyond that.

I don't think it's "too late" to change anything.  (It's never too
late!  It just might take a while to make a change in a safe and
orderly fashion for all the arch's.)  After my patch series, the
details are fully in the arch's corner.  It should be straightforward
to convert one at a time to use regs->return_register = -ERESTARTRESTOREMASK
to implement set_restore_sigmask() if you want to tackle it.


Thanks,
Roland

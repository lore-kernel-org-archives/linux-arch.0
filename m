From: Oleg Nesterov <oleg-6lXkIZvqkOAvJsYlp49lxw@public.gmane.org>
Subject: Re: [PATCH 2/4] set_restore_sigmask TIF_SIGPENDING
Date: Wed, 9 Apr 2008 15:39:39 +0400
Message-ID: <20080409113939.GA99@tv-sign.ru>
References: <20080329001230.D013726FA1D@magilla.localdomain> <20080329001341.7F93826FA1D@magilla.localdomain> <alpine.LFD.1.00.0803281746480.14670@woody.linux-foundation.org> <20080408113519.GA227@tv-sign.ru> <1207739787.27048.57.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1207739787.27048.57.camel-Fexsq3y4057IgHVZqg5X0TlWvGAXklZc@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Roland McGrath <roland-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 04/09, David Woodhouse wrote:
>
> On Tue, 2008-04-08 at 15:35 +0400, Oleg Nesterov wrote:
> > Why do we need any flag? It looks a bit ugly. Isn't it better to introduce
> > the new magic ERESTART_XXX which means ERESTARTNOHAND + restore-sigmask ?
> > 
> > We only need this flag as an implicit parameter to the arch dependent do_signal()
> > which we can't call directly, and thus it must imply TIF_SIGPENDING, and it
> > is not valid after do_signal() (should be cleared). This all looks like
> > ERESTART_ magic, why should we add something else ?
> > 
> > See also http://marc.info/?l=linux-kernel&m=113734458516136
> > 
> > Of course, probably it is too late to change the implementation even if
> > I am right, the question is: what I am missed?
> 
> Q: When ppoll() is interrupted by a signal, what signal mask should be
> active when the signal handler is active?
> 
> I believe that the signal handler should run with the temporary sigmask
> which was set by ppoll(), and the original sigmask should be restored
> only when the handler completes -- and that's what we achieve with
> TIF_RESTORE_SIGMASK.

Yes sure.

> So a signal which was originally enabled but is temporarily disabled by
> the mask passed to ppoll() will not be able to interrupt the handler for
> the signal which interrupted ppoll().
> 
> Your version will restore the original signal mask _before_ invoking the
> signal handler which interrupted ppoll()

Why do you think so?

Please look at the "patch" below,

	--- arch/x86/kernel/signal_32.c	2008-02-15 16:58:38.000000000 +0300
	+++ -	2008-04-09 15:16:05.393510662 +0400
	@@ -526,10 +526,14 @@ handle_signal(unsigned long sig, siginfo
	 {
		int ret;
	 
	+	oldset = &current->blocked;
	+
		/* Are we from a system call? */
		if (regs->orig_ax >= 0) {
			/* If so, check system call restarting.. */
			switch (regs->ax) {
	+			case -ERESTART_XXX:
	+				oldset = &current->saved_sigmask;
				case -ERESTART_RESTARTBLOCK:
				case -ERESTARTNOHAND:
					regs->ax = -EINTR;

We also need a similar change in do_signal(). Now,

	--- fs/select.c	2008-02-15 16:59:15.000000000 +0300
	+++ -	2008-04-09 15:19:29.015991911 +0400
	@@ -805,9 +805,8 @@ asmlinkage long sys_ppoll(struct pollfd 
			if (sigmask) {
				memcpy(&current->saved_sigmask, &sigsaved,
						sizeof(sigsaved));
	-			set_thread_flag(TIF_RESTORE_SIGMASK);
			}
	-		ret = -ERESTARTNOHAND;
	+		ret = -ERESTART_XXX;
		} else if (sigmask)
			sigprocmask(SIG_SETMASK, &sigsaved, NULL);

Perhaps I missed something else, though. Not that I really think it worth
changing, but I'll try to make a proof of concept patch on Weekend, on top
of Roland's cleanups.

As I see it, the main disadvantage of ERESTART_ approach is that we need 2
new ERESTART_ codes, one for ERESTARTNOHAND, another for ERESTART_RESTARTBLOCK.
And yes, while I personally think this is "more clean", it is very subjective.

Oleg.

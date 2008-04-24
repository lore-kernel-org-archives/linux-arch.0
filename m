From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: microblaze syscall list
Date: Thu, 24 Apr 2008 23:37:52 +0200
Message-ID: <200804242337.53681.arnd@arndb.de>
References: <4988.7968-24314-1195487808-1209070282@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4988.7968-24314-1195487808-1209070282-9Vj9tDbzfuSlVyrhU4qvOw@public.gmane.org>
Content-Disposition: inline
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Simek <Monstr-9Vj9tDbzfuSlVyrhU4qvOw@public.gmane.org>
Cc: Will Newton <will.newton-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, git-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org

On Thursday 24 April 2008, Michal Simek wrote:
> Hi Arnd,
> here is current syscall table - I only rewrite your changes. I remove sys_ni_syscall except from #ifdefs. 
> I would like to match syscalls to logical block. Can I do it? (I'll fix unistd.h later)

yes, that makes a lot of sense to me. If we introduce a new
asm-generic/unistd.h, it's good to have it sorted in some
meaningful way, even if it is going to get messier over time.

> Can you look at it if I remove old syscalls? 
> I will continue tomorrow I am tired.

ok, I'll look at it tomorrow.

> 
> #ifdef __ARCH_WANT_SYS_SIGNAL
> 	.long sys_signal
> #else
> 	.long sys_ni_syscall
> #endif
> #ifdef __ARCH_WANT_SYS_TIME
> 	.long sys_time
> 	.long sys_stime
> #else
> 	.long sys_ni_syscall
> 	.long sys_ni_syscall
> #endif

I guess I wasn't entirely clear with what I mean referring to
__ARCH_WANT_SYS_*. Instead of adding the #ifdef here, I meant
you should just remove the call entirely. With a few exceptions
that I already mentioned, the fact that there is an __ARCH_WANT
check in the syscall definition means that new architectures
should not reference the call, nor #define the __ARCH_WANT macro.

	Arnd <><

From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: microblaze syscall list
Date: Thu, 24 Apr 2008 23:21:06 +0200
Message-ID: <200804242321.07968.arnd@arndb.de>
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com> <200804241311.09881.arnd@arndb.de> <4810D4A4.7050900@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4810D4A4.7050900-9Vj9tDbzfuSlVyrhU4qvOw@public.gmane.org>
Content-Disposition: inline
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr-9Vj9tDbzfuSlVyrhU4qvOw@public.gmane.org
Cc: Will Newton <will.newton-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, git-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org

On Thursday 24 April 2008, Michal Simek wrote:

> >> 	.long sys_exit
> >> 	.long sys_ni_syscall		/* was fork */
> > 
> > it might be useful to renumber your calls once all the irrelevant ones
> > have been removed, so you can get rid of all the sys_ni_syscalls here.
> 
> I'll delete all sys_ni_syscall from syscall_table.S and I'll remove it from
> unistd.h too. I hope I'll keep the same call numbers.

there is not much point in keeping the syscall numbers, as you'll have
to do incompatible changes to your libc in order to do all the changes
I'm asking for.
 
> >> 	.long sys_read
> >> 	.long sys_write
> >> 	.long sys_open			/* 5 */
> > 
> > Since we have all the new sys_*at calls like openat, we don't really
> > need the old versions any more. The kernel implementation of sys_open
> > basically calls openat. You could do the same in libc instead.
> > Don't know if that's worth it though, opinions?
> 
> I looked at it and there are the different arguments for open and openat
> syscalls. Implementation is almost the same. I keep it now.

There is no "for now". If you keep them for submission, you'll have to
keep them forever. You'll have to wrap them in your libc to adapt the
arguments.

> >> 	.long sys_close
> >> 	.long sys_waitpid
> > 
> > waitpid and wait4 can be replaced with waitid
> 
> Can I keep number of syscall(unistd.h) and only add reference to waitid in
> syscall_table? or just remove?

if you keep the syscall number in unistd.h, you may confuse user space
that relies on it when the actual call is not there. It's most important
to keep the two in sync.

It may turn out to be better to leave them in, but then you still need
both the number and the sys_call_table entry.

The wait/waitpid/wait4/waitid case is much less interesting than
the uid16/uid32 and off_t/loff_t cases, where you don't ever want
anyone to call the old functions.

the openat/*at family of calls probably falls into the same category
as waitid: there are user space programs that call either one, and
it doesn't matter much which one (kernel or libc) does the conversion.

> >> 	.long sys_creat
> >> 	.long sys_link
> >> 	.long sys_unlink		/* 10 */
> >> 	.long sys_execve_wrapper
> > 
> > having an execve_wrapper instead of execve looks like a strange convention,
> > though I guess you had a good reason for it, could you explain?
> >
> > This one looks architecture specific, so you may want to rename it
> > microblaze_execve_wrapper instead of sys_execve_wrapper.
> 
> I looked at it and the same of style is used in arm
> (arch/arm/kernel/entry-common.S) and some others arch. This wrapper only set one
> parameter to correct pointer to stack.

right, but other architectures don't seem to need it.

> I'll comment the rest later. I need time to look at it.

I guess you should also wait for other comments on my list.

	Arnd <><

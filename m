From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [RFC] Introduce __ARCH_WANT_SYS_SYSFS
Date: Wed, 23 Apr 2008 16:59:24 +0200
Message-ID: <200804231659.24463.arnd@arndb.de>
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com> <20080422153849.GH19802@phobos.i.cabal.ca> <87a5b0800804230736k340e7fe9mffbd72b5b8164015@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87a5b0800804230736k340e7fe9mffbd72b5b8164015-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Newton <will.newton-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kyle McMartin <kyle-pfcGkIkfWfAsA/PxXw9srA@public.gmane.org>, Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wednesday 23 April 2008, Will Newton wrote:
> I implemented the approach you suggested - Kconfig symbol and
> cond_syscall definition. I think I actually like the previous approach
> better:
> 
> 1. The arch Kconfig files are quite non-uniform compared to unistd.h
> so the definitions wind up at different places in the file which is a
> bit messy.
> 2. Changes to Kconfig may cause churn in defconfigs perhaps?
> 3. There is more churn in arch Kconfig than unistd.h so getting a
> cross arch patch applied is likely to be more difficult.
> 4. The patch is about 4 times as many lines.
> 
> What do you think?

I still feel that the original patch was more helpful and consistent
with how we do it for the existing obsolete syscalls.

Note that there is a much simpler solution if you just use an
"#ifdef __NR_sys_sysfs" around the definition of the syscall, but
that has another disadvantage in that it is harder to spot when
new architectures get it wrong.

	Arnd <><

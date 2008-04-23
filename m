From: "Mike Frysinger" <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] Introduce __ARCH_WANT_SYS_SYSFS
Date: Wed, 23 Apr 2008 17:38:53 -0400
Message-ID: <8bd0f97a0804231438u68118bc0t4abe8e85733b23f2@mail.gmail.com>
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com>
	 <200804221515.28075.arnd@arndb.de> <480FA729.3000406@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <480FA729.3000406-9Vj9tDbzfuSlVyrhU4qvOw@public.gmane.org>
Content-Disposition: inline
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr-9Vj9tDbzfuSlVyrhU4qvOw@public.gmane.org
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Will Newton <will.newton-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, git-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org

On Wed, Apr 23, 2008 at 5:16 PM, Michal Simek <monstr-9Vj9tDbzfuSlVyrhU4qvOw@public.gmane.org> wrote:
>  I would like to fix syscalls in Microblaze repo. Can you give me a hint how to
>  do it?
>
>  I look at Blackfin arch and I compared files with microblaze. There are some
>  differences but not so much.
>  Can you tell me how to test it which syscall is necessary for platform.
>  I have never found any documentation about.
>
>  In my syscall_table.S (on some arch in entry.S) is one big jump table with
>  reference to syscalls. In unistd.h is definition.
>
>  Is there any convention which syscalls are use for all archs and which are
>  architecture specific?

i dont believe there is any documentation for syscalls.  you just have
to know which syscalls are outdated and which replace others ;).  i
think someone already pointed out a few to you in an earlier post ?
otherwise, feel free to ask about sets.

i dont recall if microblaze is no-mmu-only, mmu-only, or both ... you
should take care with comparing against Blackfin if microblaze
supports an mmu.  if it is no-mmu-only, then the Blackfin list should
be quite good for you start with as we turn off numa/mmu-only
functions as well as old stuff (like the poll/select/mmap/etc...
friends).
-mike

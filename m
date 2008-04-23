From: Michal Simek <monstr-9Vj9tDbzfuSlVyrhU4qvOw@public.gmane.org>
Subject: Re: [RFC] Introduce __ARCH_WANT_SYS_SYSFS
Date: Wed, 23 Apr 2008 23:16:25 +0200
Message-ID: <480FA729.3000406@seznam.cz>
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com> <200804221515.28075.arnd@arndb.de>
Reply-To: monstr-9Vj9tDbzfuSlVyrhU4qvOw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200804221515.28075.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Will Newton <will.newton-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, git-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org

Hi Arnd and others,

I would like to fix syscalls in Microblaze repo. Can you give me a hint how to
do it?

I look at Blackfin arch and I compared files with microblaze. There are some
differences but not so much.
Can you tell me how to test it which syscall is necessary for platform.
I have never found any documentation about.

In my syscall_table.S (on some arch in entry.S) is one big jump table with
reference to syscalls. In unistd.h is definition.

Is there any convention which syscalls are use for all archs and which are
architecture specific?

Thanks for info,
Michal Simek

>> This patch introduces a __ARCH_WANT_SYS_SYSFS #define for
>> architectures that support the sysfs(2) system call. At the moment
>> that's everybody but blackfin, but future architectures may want to
>> save the (admittedly small) code size that it adds to the kernel as
>> well.
> 
> Yes, good thing to have. Since we'll be getting a new architecture
> (microblaze) soon, I think we should extend this mechanism (even though
> it's ugly) to all syscalls that we don't want to have in new architectures
> and make sure that microblaze doesn't have to set any of them.
> 
> 	Arnd <><
> 

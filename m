From: John Williams <jwilliams-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org>
Subject: Re: [microblaze-uclinux] Re: microblaze syscall list
Date: Fri, 25 Apr 2008 19:36:35 +1000
Message-ID: <4811A623.80104@itee.uq.edu.au>
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com> <200804221515.28075.arnd@arndb.de> <480FA729.3000406@seznam.cz> <200804241311.09881.arnd@arndb.de> <4810D4A4.7050900@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4810D4A4.7050900-9Vj9tDbzfuSlVyrhU4qvOw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Will Newton <will.newton-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, git-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org

Hi Michal, Arnd,

Michal Simek wrote:


>>> 	.long sys_read
>>> 	.long sys_write
>>> 	.long sys_open			/* 5 */
>> Since we have all the new sys_*at calls like openat, we don't really
>> need the old versions any more. The kernel implementation of sys_open
>> basically calls openat. You could do the same in libc instead.
>> Don't know if that's worth it though, opinions?
> 
> I looked at it and there are the different arguments for open and openat
> syscalls. Implementation is almost the same. I keep it now.

Please remember that MicroBlaze has been around as an arch for > 4 
years, just not in the kernel.org tree.  These older style syscall 
interfaces are all part of the uClibc and glibc ports for MicroBlaze.

While I understand that there are shiny new ways of doing all this 
stuff, please don't break our C libraries, toolchains and all else.  A 
MicroBlaze arch in kernel.org that isn't actually supported by a C 
library or toolchain is not much use either!

Can we compromise and say that the new syscall interfaces will be added 
if they are currently missing, but older interfaces retained until the 
libs and toolchains catch up?

John

From: John Williams <jwilliams-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org>
Subject: Re: microblaze syscall list
Date: Mon, 28 Apr 2008 10:15:34 +1000
Message-ID: <48151726.9000204@itee.uq.edu.au>
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com> <4813DF3E.6080800@itee.uq.edu.au> <4814A153.3040600@seznam.cz> <200804272215.32862.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200804272215.32862.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: monstr-9Vj9tDbzfuSlVyrhU4qvOw@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>, Will Newton <will.newton-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, git-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, John Williams <john.williams-g5w7nrANp4BDPfheJLI6IQ@public.gmane.org>, Stephen Neuendorffer <stephen.neuendorffer-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, John Linn <John.Linn-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>


Arnd Bergmann wrote:
> On Sunday 27 April 2008, Michal Simek wrote:

>> I thing you understand that we can't change all application per night. This is
>> not possible. But we have to start with change this.
> 
> Note that the only thing you should need to change is the libc implementation
> (any version of it: glibc, uclibc, klibc, ...), but not any application source
> code, as the applications just call the functions that are defined in the libc.
> If you have binaries that are statically linked with their libc, you'd have
> to recompile or at least relink them. If you redefine data structures or
> types that are used in application code, like struct stat or off_t, you
> also need to recompile all user code.

Until very recently with the MMU support added to the CPU (and upcoming 
MMU support patches for MicroBlaze), all apps were statically linked 
anyway. So, this is not too much of an issue I don't think.

Because the CPU is so configurable re: instruction set and features, it 
is common to rebuild your entire userland and libs + kernel in one go. 
If you add support for HW integer mul or div, barrel shift etc, you need 
to rebuild not just the kernel but apps and libs as well.  Or rather, 
rebuild apps, and relink against a different multilib'd libc.

So, the issue seems not so much that there's a bunch of legacy binaries 
out there that will break, but rather that there will be a dead-zone 
period in which the kernel is exporting an ABI that is simply not 
available in the C libs and existing toolchains.  We should be doing all 
we can to encourage individual developers and distro maintainers (like 
PetaLogix) to base from the kernel.org tree.

> I think you have three options here:
> 
> 1. Keep the old syscall interface and just add new syscalls for the stuff
> that you are currently missing. Don't change userspace at all, but live
> with somewhat bloated kernels and libc forever and maintain a larger
> code base in the kernel.
> 
> 2. Change the syscall interface in the kernel in the way we have discussed,
> and adapt the libc code along with it. Break all backwards compatibility
> and start out with a new leaner ABI. Old applications can still use
> your old out-of-tree kernels, or forks of that.
> 
> 3. Merge only the ABI as in 2. into the mainline kernel, but use new
> syscall numbers for that. Maintain an out-of-tree patch that adds the
> old ABI for backwards compatibility so you can run old and new code
> on one kernel if you build with that patch, but eventually phase
> out the old ABI.

Maybe I misunderstand, but is there an option 1(a) where we keep the 
old, add the new, and suffer the bloat for a short period until the 
toolchains and C libs catch up and we remove out the old interfaces?

Are the old and new syscalls necessarily overloaded onto the same 
numbers?  We'd obviously like to be as "standard" as reasonably possible 
regarding syscall numbers

> I won't try to force you to go either route, it's your own decision,
> but you should understand the tradeoffs. I don't think there is any
> value in trying to deprecate just part of the ABI and break some
> binaries but not others, this will only cause hard to find bugs. Make
> sure that if you decide to break backwards compatibility, you break it
> in an obvious way and get the most benefit out of it.

No argument there.

John

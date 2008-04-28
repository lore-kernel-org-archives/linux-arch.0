From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: microblaze syscall list
Date: Mon, 28 Apr 2008 14:31:25 +0200
Message-ID: <200804281431.26570.arnd@arndb.de>
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com> <200804272215.32862.arnd@arndb.de> <48151726.9000204@itee.uq.edu.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934012AbYD1Mbx@vger.kernel.org>
In-Reply-To: <48151726.9000204@itee.uq.edu.au>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: John Williams <jwilliams@itee.uq.edu.au>
Cc: monstr@seznam.cz, microblaze-uclinux@itee.uq.edu.au, Matthew Wilcox <matthew@wil.cx>, Will Newton <will.newton@gmail.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, git@xilinx.com, John Williams <john.williams@petalogix.com>, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>, John Linn <John.Linn@xilinx.com>
List-Id: linux-arch.vger.kernel.org

On Monday 28 April 2008, John Williams wrote:
> 
> Until very recently with the MMU support added to the CPU (and upcoming 
> MMU support patches for MicroBlaze), all apps were statically linked 
> anyway. So, this is not too much of an issue I don't think.
> 
> Because the CPU is so configurable re: instruction set and features, it 
> is common to rebuild your entire userland and libs + kernel in one go. 
> If you add support for HW integer mul or div, barrel shift etc, you need 
> to rebuild not just the kernel but apps and libs as well.  Or rather, 
> rebuild apps, and relink against a different multilib'd libc.

If this is the common case, that is a good argument for breaking the ABI
completely now. You will just require a new libc build with a new kernel.

> So, the issue seems not so much that there's a bunch of legacy binaries 
> out there that will break, but rather that there will be a dead-zone 
> period in which the kernel is exporting an ABI that is simply not 
> available in the C libs and existing toolchains.  We should be doing all 
> we can to encourage individual developers and distro maintainers (like 
> PetaLogix) to base from the kernel.org tree.

As far as I can tell, these distrbutions typically come with both
kernel and libc source code together. It would be logical to just
require updating both here as well.

> Maybe I misunderstand, but is there an option 1(a) where we keep the 
> old, add the new, and suffer the bloat for a short period until the 
> toolchains and C libs catch up and we remove out the old interfaces?
>
> Are the old and new syscalls necessarily overloaded onto the same 
> numbers?  We'd obviously like to be as "standard" as reasonably possible 
> regarding syscall numbers

It's more than just the syscall numbers that should ideally change.
The other changes I would recommend include moving to large file
types (64 bit off_t), 32 bit UIDs, cleaned up sysV-IPC types, and a
few others. All these break the user code in the same way that changing
the instruction set does, which is the reason that we can't change
any of the existing architectures that started out in the old days.

The syscall numbers are entirely arbitrary, that's why I suggested
in my approach 3. that you introduce a new set of syscall numbers for
the new ABI, and keep compatibility with the old calls in their existing
numbers as an out-of-tree patch.

If you assume that the user recompiles the libc and the kernel together,
you can obviously change syscall numbers and data types in any way you
please, but still I'd suggest you don't change them after the kernel
gets merged upstream.

How about this strategy then:
* Change all the data types and syscall numbers in the -for-2.6.27
branch to only include the minimal set, and a modern ABI
* Add the old interfaces as an out-of-tree patch that adds source
level compatibility with the old libc, but does not modify any
of the new interfaces, so that a patched kernel can run all binaries
built for the upstream version.
* phase out the old source interface gradually, as all users update
their libc source code.

This way, early adopters suffer the pain of incompatibility twice, but
get the clean kernel port quickly.

	Arnd <><

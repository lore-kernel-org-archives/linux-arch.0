From: "Richard W.M. Jones" <rjones@redhat.com>
Subject: Re: [RFC PATCH 00/28] Linux Kernel Library
Date: Tue, 3 Nov 2015 22:45:45 +0000
Message-ID: <20151103224545.GI29330@redhat.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
 <CAFLxGvzZozV0rDpY_VcQaFH+dx_+tHGyEy+22kgL=wdS5pSqCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42027 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754871AbbKCWpr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 3 Nov 2015 17:45:47 -0500
Content-Disposition: inline
In-Reply-To: <CAFLxGvzZozV0rDpY_VcQaFH+dx_+tHGyEy+22kgL=wdS5pSqCw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Octavian Purdila <octavian.purdila@intel.com>, Linux-Arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, thehajime@gmail.com

On Tue, Nov 03, 2015 at 10:40:29PM +0100, Richard Weinberger wrote:
> On Tue, Nov 3, 2015 at 9:20 PM, Octavian Purdila
> <octavian.purdila@intel.com> wrote:
> > LKL (Linux Kernel Library) is aiming to allow reusing the Linux kernel code
> > as extensively as possible with minimal effort and reduced maintenance
> > overhead.
> >
> > Examples of how LKL can be used are: creating userspace applications
> > (running on Linux and other operating systems) that can read or write Linux
> > filesystems or can use the Linux networking stack, creating kernel drivers
> > for other operating systems that can read Linux filesystems, bootloaders
> > support for reading/writing Linux filesystems, etc.
> >
> > With LKL, the kernel code is compiled into an object file that can be
> > directly linked by applications. The API offered by LKL is based on the
> > Linux system call interface.
> >
> > LKL is implemented as an architecture port in arch/lkl. It relies on host
> > operations defined by the application or a host library (tools/lkl/lib).
> >
> > The latest LKL version can be found at git@github.com:lkl/linux.git
> 
> Or more copy&paste friendly: https://github.com/lkl/linux.git
> 
> > FAQ
> > ===
> >
> > Q: How is LKL different from UML?
> > A: UML provides a full OS environment (e.g. user/kernel separation, user
> > processes) and also has requirements (a filesystem, processes, etc.) that
> > makes it hard to use it for standalone applications. UML also relies
> > heavily on Linux hosts. On the other hand LKL is designed to be linked
> > directly with the application and hence does not have user/kernel
> > separation which makes it easier to use it in standalone applications.
> 
> So, this is a "liblinux" where applications are directly linked
> against the kernel.
> IOW system calls are plain function calls into the kernel?
> 
> This eliminates UML's most problematic areas, system call handling via ptrace()
> and virtual memory management via SIGSEGV. :-)
> 
> > Q: How is LKL different from LibOS?
> > A: LibOS re-implements high-level kernel APIs for timers, softirqs,
> > scheduling, sysctl, SLAB/SLUB, etc. LKL behaves like any arch port,
> > implementing the arch level operations requested by the Linux kernel. LKL
> > also offers a host interface so that support for multiple hosts can be
> > easily implemented.
> 
> Yeah, these re-implementations are what I find most worrisome about LibOS.
> 
> >
> > Building LKL the host library and LKL applications
> > ==================================================
> >
> > % cd tools/lkl
> > % make
> >
> > will build LKL as a object file, it will install it in tools/lkl/lib together
> > with the headers files in tools/lkl/include then will build the host library,
> > tests and a few of application examples:
> >
> > * tests/boot - a simple applications that uses LKL and exercises the basic
> > LKL APIs
> >
> > * fs2tar - a tool that converts a filesystem image to a tar archive
> >
> > * cptofs/cpfromfs - a tool that copies files to/from a filesystem image
> 
> Seeing forward to have a libguestfs port. :-)

Thanks - I was keeping an eye on libos (and on the NetBSD rump kernel
stuff before), ready to integrate them into libguestfs as soon as they
offered filesystem access.

It's easy to write a libguestfs-compatible backend, which brings all
the virt-* tools from libguestfs to the new code.  The UML one looks
like this:

https://github.com/libguestfs/libguestfs/blob/master/src/launch-uml.c

I'm dubious that a lib-based approach could support LVM, partioning,
ntfs-3g, qcow2, vmdk and all the other libguestfs stuff that relies on
userspace tools + qemu as well as just the kernel drivers.
Nevertheless a fast subset of libguestfs supporting just kernel
filesystem drivers could be useful.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top

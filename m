From: Octavian Purdila <octavian.purdila@intel.com>
Subject: Re: [RFC PATCH 00/28] Linux Kernel Library
Date: Wed, 4 Nov 2015 01:06:31 +0200
Message-ID: <CAE1zot+hBnAds-T37JLv_6Sp2fRqwCbCv46_gA=E7D49gGd6cA@mail.gmail.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
	<CAFLxGvzZozV0rDpY_VcQaFH+dx_+tHGyEy+22kgL=wdS5pSqCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35542 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964980AbbKCXGd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Nov 2015 18:06:33 -0500
Received: by wicll6 with SMTP id ll6so79392178wic.0
        for <linux-arch@vger.kernel.org>; Tue, 03 Nov 2015 15:06:32 -0800 (PST)
In-Reply-To: <CAFLxGvzZozV0rDpY_VcQaFH+dx_+tHGyEy+22kgL=wdS5pSqCw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, thehajime@gmail.com, "Richard W.M. Jones" <rjones@redhat.com>

On Tue, Nov 3, 2015 at 11:40 PM, Richard Weinberger
<richard.weinberger@gmail.com> wrote:

Hi Richard,

> On Tue, Nov 3, 2015 at 9:20 PM, Octavian Purdila
> <octavian.purdila@intel.com> wrote:
>> LKL (Linux Kernel Library) is aiming to allow reusing the Linux kernel code
>> as extensively as possible with minimal effort and reduced maintenance
>> overhead.
>>
>> Examples of how LKL can be used are: creating userspace applications
>> (running on Linux and other operating systems) that can read or write Linux
>> filesystems or can use the Linux networking stack, creating kernel drivers
>> for other operating systems that can read Linux filesystems, bootloaders
>> support for reading/writing Linux filesystems, etc.
>>
>> With LKL, the kernel code is compiled into an object file that can be
>> directly linked by applications. The API offered by LKL is based on the
>> Linux system call interface.
>>
>> LKL is implemented as an architecture port in arch/lkl. It relies on host
>> operations defined by the application or a host library (tools/lkl/lib).
>>
>> The latest LKL version can be found at git@github.com:lkl/linux.git
>
> Or more copy&paste friendly: https://github.com/lkl/linux.git
>
>> FAQ
>> ===
>>
>> Q: How is LKL different from UML?
>> A: UML provides a full OS environment (e.g. user/kernel separation, user
>> processes) and also has requirements (a filesystem, processes, etc.) that
>> makes it hard to use it for standalone applications. UML also relies
>> heavily on Linux hosts. On the other hand LKL is designed to be linked
>> directly with the application and hence does not have user/kernel
>> separation which makes it easier to use it in standalone applications.
>
> So, this is a "liblinux" where applications are directly linked
> against the kernel.
> IOW system calls are plain function calls into the kernel?
>

More like "thread" calls. All system calls are executed in a dedicate
(kernel) thread to avoid race conditions with the "interrupt" path.

> This eliminates UML's most problematic areas, system call handling via ptrace()
> and virtual memory management via SIGSEGV. :-)
>

:)

>> Q: How is LKL different from LibOS?
>> A: LibOS re-implements high-level kernel APIs for timers, softirqs,
>> scheduling, sysctl, SLAB/SLUB, etc. LKL behaves like any arch port,
>> implementing the arch level operations requested by the Linux kernel. LKL
>> also offers a host interface so that support for multiple hosts can be
>> easily implemented.
>
> Yeah, these re-implementations are what I find most worrisome about LibOS.
>
>>
>> Building LKL the host library and LKL applications
>> ==================================================
>>
>> % cd tools/lkl
>> % make
>>
>> will build LKL as a object file, it will install it in tools/lkl/lib together
>> with the headers files in tools/lkl/include then will build the host library,
>> tests and a few of application examples:
>>
>> * tests/boot - a simple applications that uses LKL and exercises the basic
>> LKL APIs
>>
>> * fs2tar - a tool that converts a filesystem image to a tar archive
>>
>> * cptofs/cpfromfs - a tool that copies files to/from a filesystem image
>
> Seeing forward to have a libguestfs port. :-)
>
> Is LKL strictly single threaded?
>

At this point yes. SMP support is on my todo list though :)

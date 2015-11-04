From: Octavian Purdila <octavian.purdila@intel.com>
Subject: Re: [RFC PATCH 00/28] Linux Kernel Library
Date: Wed, 4 Nov 2015 16:15:46 +0200
Message-ID: <CAE1zotLMxGH1BWXg6JRSs9HD=Wfhee9OSsaufUjmxQXsTRqs=Q@mail.gmail.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
	<CAFLxGvzZozV0rDpY_VcQaFH+dx_+tHGyEy+22kgL=wdS5pSqCw@mail.gmail.com>
	<20151103224545.GI29330@redhat.com>
	<CAE1zotKa5B4xW5dzbrkGFcf7=ZTyVRLjvxnHtXV2nUzZ8HW_0g@mail.gmail.com>
	<20151104135015.GN29330@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35647 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbbKDOPr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 4 Nov 2015 09:15:47 -0500
Received: by wmll128 with SMTP id l128so115288769wml.0
        for <linux-arch@vger.kernel.org>; Wed, 04 Nov 2015 06:15:46 -0800 (PST)
In-Reply-To: <20151104135015.GN29330@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, Linux-Arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Hajime Tazaki <thehajime@gmail.com>

On Wed, Nov 4, 2015 at 3:50 PM, Richard W.M. Jones <rjones@redhat.com> wrote:
> On Wed, Nov 04, 2015 at 01:24:03AM +0200, Octavian Purdila wrote:
>> Thanks for the pointers Richard, I am going to take a look at it.
>
> Now I've had a chance to look at some of the example LKL tools, here's
> what this actually involves.  It's not actually a great deal of work,
> it could probably be done in a day or two, but see my question about
> `lkl_sys_*' below.
>
> libguestfs (the library part) needs to talk over an RPC connection to
> its daemon.  See diagram here:
>
> http://libguestfs.org/guestfs-internals.1.html
>
> The code in src/launch-{direct,libvirt,uml,...}.c sets up that
> connection and runs the daemon -- normally inside a qemu wrapper, but
> it could be inside UML.  For LKL I think it should just fork the
> daemon directly.
>
> The daemon would then be linked to LKL.
>
> So really what's needed is a src/launch-lkl.c probably modelled after
> one of these current backends:
>
> https://github.com/libguestfs/libguestfs/blob/master/src/launch-uml.c
> https://github.com/libguestfs/libguestfs/blob/master/src/launch-unix.c
>
> and then recompile the daemon to link to LKL:
>
> https://github.com/libguestfs/libguestfs/tree/master/daemon
>
> and pass the list of disk images to the daemon, probably best to do
> that on the guestfsd command line.
>
> My only problem here: you can't just link to daemon to LKL, do you
> have to change all of the system calls from `foo' to `lkl_sys_foo'?
> That's an awful lot of #ifdefs ...
>

We could redefine the syscalls/libc symbols to call lkl_sys_ functions
in launch-lkl, e.g.:

int opendir(const char *path)
{
   return lkl_opendir(new_path)
}

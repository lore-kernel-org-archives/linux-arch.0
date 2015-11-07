From: "Richard W.M. Jones" <rjones@redhat.com>
Subject: Re: [RFC PATCH 00/28] Linux Kernel Library
Date: Sat, 7 Nov 2015 07:19:46 +0000
Message-ID: <20151107071946.GU29330@redhat.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
 <CAFLxGvzZozV0rDpY_VcQaFH+dx_+tHGyEy+22kgL=wdS5pSqCw@mail.gmail.com>
 <20151103224545.GI29330@redhat.com>
 <CAE1zotKa5B4xW5dzbrkGFcf7=ZTyVRLjvxnHtXV2nUzZ8HW_0g@mail.gmail.com>
 <20151104135015.GN29330@redhat.com>
 <CAE1zotLMxGH1BWXg6JRSs9HD=Wfhee9OSsaufUjmxQXsTRqs=Q@mail.gmail.com>
 <563D4758.9080507@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43148 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751291AbbKGHTs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 7 Nov 2015 02:19:48 -0500
Content-Disposition: inline
In-Reply-To: <563D4758.9080507@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: Octavian Purdila <octavian.purdila@intel.com>, Linux-Arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Hajime Tazaki <thehajime@gmail.com>

On Sat, Nov 07, 2015 at 01:35:36AM +0100, Richard Weinberger wrote:
> Am 04.11.2015 um 15:15 schrieb Octavian Purdila:
> > We could redefine the syscalls/libc symbols to call lkl_sys_ functions
> > in launch-lkl, e.g.:
> > 
> > int opendir(const char *path)
> > {
> >    return lkl_opendir(new_path)
> > }
> 
> To get a better feeling how LKL behaves I've started with a tool
> to mount any Linux filesystem by FUSE.
> I.e. such that we can finally automount without root and bugs in filesystem
> code won't hurt that much.

guestmount already does this:

http://libguestfs.org/guestmount.1.html

By porting a small amount of code from the daemon/ directory, it could
do it using lkl too.  See:

http://www.gossamer-threads.com/lists/linux/kernel/2296116#2296116

Rich.

> lkl_sys_fstatat64() uses the type struct lkl_stat64. Where is it defined?
> git grep is unable to locate it.
> At least it seems to be incompatible with my local struct stat.
> 
> And why is there no lkl_sys_openat() syscall?
> 
> Thanks,
> //richard

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW

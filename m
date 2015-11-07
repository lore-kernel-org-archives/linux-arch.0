From: Richard Weinberger <richard@nod.at>
Subject: Re: [RFC PATCH 00/28] Linux Kernel Library
Date: Sat, 7 Nov 2015 01:35:36 +0100
Message-ID: <563D4758.9080507@nod.at>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
 <CAFLxGvzZozV0rDpY_VcQaFH+dx_+tHGyEy+22kgL=wdS5pSqCw@mail.gmail.com>
 <20151103224545.GI29330@redhat.com>
 <CAE1zotKa5B4xW5dzbrkGFcf7=ZTyVRLjvxnHtXV2nUzZ8HW_0g@mail.gmail.com>
 <20151104135015.GN29330@redhat.com>
 <CAE1zotLMxGH1BWXg6JRSs9HD=Wfhee9OSsaufUjmxQXsTRqs=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from a.ns.miles-group.at ([95.130.255.143]:11950 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757958AbbKGAfl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 6 Nov 2015 19:35:41 -0500
In-Reply-To: <CAE1zotLMxGH1BWXg6JRSs9HD=Wfhee9OSsaufUjmxQXsTRqs=Q@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Octavian Purdila <octavian.purdila@intel.com>, "Richard W.M. Jones" <rjones@redhat.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Hajime Tazaki <thehajime@gmail.com>

Am 04.11.2015 um 15:15 schrieb Octavian Purdila:
> We could redefine the syscalls/libc symbols to call lkl_sys_ functions
> in launch-lkl, e.g.:
> 
> int opendir(const char *path)
> {
>    return lkl_opendir(new_path)
> }

To get a better feeling how LKL behaves I've started with a tool
to mount any Linux filesystem by FUSE.
I.e. such that we can finally automount without root and bugs in filesystem
code won't hurt that much.

lkl_sys_fstatat64() uses the type struct lkl_stat64. Where is it defined?
git grep is unable to locate it.
At least it seems to be incompatible with my local struct stat.

And why is there no lkl_sys_openat() syscall?

Thanks,
//richard

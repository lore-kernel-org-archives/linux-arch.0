From: Octavian Purdila <octavian.purdila@intel.com>
Subject: Re: [RFC PATCH 00/28] Linux Kernel Library
Date: Sun, 8 Nov 2015 06:16:39 +0200
Message-ID: <CAE1zotLjngqdKnM+VZxBKag1Doqnp8VJy0U+2Kt6DC-ueA2HRQ@mail.gmail.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
	<CAFLxGvzZozV0rDpY_VcQaFH+dx_+tHGyEy+22kgL=wdS5pSqCw@mail.gmail.com>
	<20151103224545.GI29330@redhat.com>
	<CAE1zotKa5B4xW5dzbrkGFcf7=ZTyVRLjvxnHtXV2nUzZ8HW_0g@mail.gmail.com>
	<20151104135015.GN29330@redhat.com>
	<CAE1zotLMxGH1BWXg6JRSs9HD=Wfhee9OSsaufUjmxQXsTRqs=Q@mail.gmail.com>
	<563D4758.9080507@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:35528 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228AbbKHEQk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 7 Nov 2015 23:16:40 -0500
Received: by wicll6 with SMTP id ll6so51470060wic.0
        for <linux-arch@vger.kernel.org>; Sat, 07 Nov 2015 20:16:39 -0800 (PST)
In-Reply-To: <563D4758.9080507@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, Linux-Arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Hajime Tazaki <thehajime@gmail.com>

On Sat, Nov 7, 2015 at 2:35 AM, Richard Weinberger <richard@nod.at> wrote:
> Am 04.11.2015 um 15:15 schrieb Octavian Purdila:
>> We could redefine the syscalls/libc symbols to call lkl_sys_ functions
>> in launch-lkl, e.g.:
>>
>> int opendir(const char *path)
>> {
>>    return lkl_opendir(new_path)
>> }
>
> To get a better feeling how LKL behaves I've started with a tool
> to mount any Linux filesystem by FUSE.
> I.e. such that we can finally automount without root and bugs in filesystem
> code won't hurt that much.
>
> lkl_sys_fstatat64() uses the type struct lkl_stat64. Where is it defined?
> git grep is unable to locate it.
> At least it seems to be incompatible with my local struct stat.
>
> And why is there no lkl_sys_openat() syscall?
>
> Thanks,
> //richard

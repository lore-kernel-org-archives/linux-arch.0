From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH 16/28] nios2: System calls handling
Date: Tue, 22 Apr 2014 16:24:33 +0800
Message-ID: <CAFiDJ5-jLsQ_Xej3K6DABwmRnu0YTqig=P+ByfFzNmWQhy3NYw@mail.gmail.com>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
	<1397824031-4892-13-git-send-email-lftan@altera.com>
	<20140419160947.GA27776@amd.pavel.ucw.cz>
	<CAFiDJ5-e=vRLxyKuzSQO0vg4HBHessv3xE9SdCQ9zFOqYOreZg@mail.gmail.com>
	<CAFLxGvxXfJNKK=n5tSkjt=zjBT-Auo2mCMf7PQr5skOVxYeW+w@mail.gmail.com>
	<20140421204835.GB22181@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:49967 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384AbaDVIYe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Apr 2014 04:24:34 -0400
In-Reply-To: <20140421204835.GB22181@amd.pavel.ucw.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pavel Machek <pavel@denx.de>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, Linux-Arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, cltang@codesourcery.com, Michael Kerrisk-manpages <mtk.manpages@gmail.com>

On Tue, Apr 22, 2014 at 4:48 AM, Pavel Machek <pavel@denx.de> wrote:
>> >>> +/* sys_cacheflush -- flush the processor cache. */
>> >>> +asmlinkage int sys_cacheflush(unsigned long addr, unsigned long len,
>> >>> +                             unsigned int op)
>> >>> +{
>> >>> +     struct vm_area_struct *vma;
>> >>> +
>> >>> +     if (len == 0)
>> >>> +             return 0;
>> >>
>> >> op is being ignored? You should remove it... or if (op) return -EINVAL
>> >> if you want future extensions.
>> > Yes, op argument is being ignored. Okay, will add the return -EINVAL
>> > if op is non-zero.
>>
>> Be careful. If existing applications already use this and maybe pass a
>> dummy value
>> to it you break them.
>
> Well.. of course, but passing ignored integer to syscall, that can be
> never used is beyond ugly. NAK-level ugly.
>
> If it is so, you can never ever use the argument, and might as well
> remove it (depending on your calling convention, it should not break
> anything.)
>
I'm prefer to keep the calling convention here for future use and add
the op checking here.
This prevent us to update toolchain if we plan to add in op option later.

Regards
Ley Foon

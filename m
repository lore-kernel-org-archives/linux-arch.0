From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2] all arches, signal: Move restart_block to struct task_struct
Date: Mon, 10 Nov 2014 14:03:23 -0800
Message-ID: <CALCETrWtBCFXzwCAh8fpeFv-EvPxYW20oRmFk1iCYwUvpft=Rw@mail.gmail.com>
References: <43c88012a4959cd427ab634906e697fbc524e847.1414604015.git.luto@amacapital.net>
 <alpine.DEB.2.11.1410291908290.5308@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:58699 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbaKJWDp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 10 Nov 2014 17:03:45 -0500
Received: by mail-lb0-f176.google.com with SMTP id 10so6507871lbg.7
        for <linux-arch@vger.kernel.org>; Mon, 10 Nov 2014 14:03:44 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1410291908290.5308@nanos>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Richard Weinberger <richard.weinberger@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Kees Cook <keescook@chromium.org>

On Wed, Oct 29, 2014 at 11:12 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 29 Oct 2014, Andy Lutomirski wrote:
>
>> If an attacker can cause a controlled kernel stack overflow,
>> overwriting the restart block is a very juicy exploit target.
>> Moving the restart block to struct task_struct prevents this
>> exploit.
>>
>> Note that there are other fields in thread_info that are also easy
>> targets, at least on some architectures.
>>
>> It's also a decent simplification, since the restart code is more or
>> less identical on all architectures.
>
> I think that's the most important change. Moving common stuff into
> common code. The side effect of slightly reducing the attack surface
> is nice, but as Al pointed out not really the big win here.

Having gotten exactly zero feedback from any arch maintainer outside
of x86, am I supposed to pester people further?

--Andy

>
> Thanks,
>
>         tglx



-- 
Andy Lutomirski
AMA Capital Management, LLC

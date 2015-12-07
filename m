From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PSEUDOPATCH] rename is_compat_task
Date: Mon, 7 Dec 2015 15:20:05 -0800
Message-ID: <CALCETrWt0HVLdBfSW1Li2fuzRE0sBO07o0FqXpABQ1uvfcq=TA@mail.gmail.com>
References: <CALCETrWkrtiwCVpqiWuD1Hf2BekCo+5F_orQdN2-K3osqze4Uw@mail.gmail.com>
 <11525805.FykVOSlruZ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:34472 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932555AbbLGXUZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Dec 2015 18:20:25 -0500
Received: by obciw8 with SMTP id iw8so1892270obc.1
        for <linux-arch@vger.kernel.org>; Mon, 07 Dec 2015 15:20:25 -0800 (PST)
In-Reply-To: <11525805.FykVOSlruZ@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Mon, Dec 7, 2015 at 3:16 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 07 December 2015 15:12:59 Andy Lutomirski wrote:
>> Hi all-
>>
>> Every time I look at is_compat_task, I cringe.  That function
>> determines whether we're in a compat syscall, not whether we're in a
>> compat task.  There are probably architectures (arm64?) under which
>> these are the same conditions, but they are definitely *not* the same
>> thing on x86.
>>
>> Can we just fix it?  I propose the following patch:
>>
>> $ find -type f |xargs sed -i -e 's/is_compat_task/in_compat_syscall/g'
>>
>> If there's general agreement, can we do that at the end of the next
>> merge window?
>>
>> I could also send a patch series to add in_compat_syscall, change all
>> the users, then delete the old stuff, but that seems overcomplicated
>> for something that's literally just renaming a token.
>
> As far as I know, x86 is the special case here, on all other architectures,
> this actually checks the task, and it's impossible to call a system call
> of the other kind.
>

Nonetheless, it's still nasty.  I'm very slowly trying to get the
kernel to stop checking "is this task a compat task" at all on x86
except in the *very* small number of cases where it's correct.  I've
already found and fixed one security bug that resulted from confusing
the conditions.

I don't think that the other (more sensible) architectures lose
anything from making my proposed change.  After all, most of the users
are in generic code, and they'll still be correct on all architectures
assuming that they were correct in the first place.

--Andy

From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Date: Thu, 4 Jan 2018 13:43:13 -0800
Message-ID: <CAPcyv4g0ZEP_LuXwsf1rJGaG65UHn5sj=DMyMdCnzKD9T-vnyg@mail.gmail.com>
References: <20180103223827.39601-1-mark.rutland@arm.com> <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
 <20180104010754.22ca6a74@alans-desktop> <CAPcyv4ge14OPyfoQvXHLyXwqX7cjWvm4DouUOc=WrNo1Lr9Qyw@mail.gmail.com>
 <alpine.DEB.2.20.1801040728140.2148@hadrien> <CAPcyv4gLcC7vsxLUCEJdEvDRf4AhgF0x1fpTEcH7AOe=kuNfoQ@mail.gmail.com>
 <20180104192648.GA10427@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:38013 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751829AbeADVnO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Jan 2018 16:43:14 -0500
Received: by mail-oi0-f43.google.com with SMTP id r65so1942838oie.5
        for <linux-arch@vger.kernel.org>; Thu, 04 Jan 2018 13:43:14 -0800 (PST)
In-Reply-To: <20180104192648.GA10427@amd>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Julia Lawall <julia.lawall@lip6.fr>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>, Dan Carpenter <dan.carpenter@oracle.com>

On Thu, Jan 4, 2018 at 11:26 AM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> >> > What remains to be seen is if there are other patterns that affect
>> >> > different processors.
>> >> >
>> >> > In the longer term the compiler itself needs to know what is and is=
n't
>> >> > safe (ie you need to be able to write things like
>> >> >
>> >> > void foo(tainted __user int *x)
>> >> >
>> >> > and have the compiler figure out what level of speculation it can d=
o and
>> >> > (on processors with those features like IA64) when it can and can't=
 do
>> >> > various kinds of non-trapping loads.
>> >> >
>> >>
>> >> It would be great if coccinelle and/or smatch could be taught to catc=
h
>> >> some of these case at least as a first pass "please audit this code
>> >> block" type of notification.
>> >>
>> >
>> > What should one be looking for.  Do you have a typical example?
>> >
>>
>> See "Exploiting Conditional Branch Misprediction" from the paper [1].
>>
>> The typical example is an attacker controlled index used to trigger a
>> dependent read near a branch. Where an example of "near" from the
>> paper is "up to 188 simple instructions inserted in the source code
>> between the =E2=80=98if=E2=80=99 statement and the line accessing array.=
..".
>>
>> if (attacker_controlled_index < bound)
>>      val =3D array[attacker_controlled_index];
>> else
>>     return error;
>>
>> ...when the cpu speculates that the 'index < bound' branch is taken it
>> reads index and uses that value to read array[index]. The result of an
>> 'array' relative read is potentially observable in the cache.
>
> You still need
>
>         (void) array2[val];
>
> after that to get something observable, right?

As far as I understand the presence of array2[val] discloses more
information, but in terms of the cpu taking an action that it is
observable in the cache that's already occurred when "val =3D
array[attacker_controlled_index];" is speculated. Lets err on the side
of caution and shut down all the observable actions that are already
explicitly gated by an input validation check. In other words, a low
bandwidth information leak is still a leak.

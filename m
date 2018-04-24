From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [uml-devel] [REVIEW][PATCH 19/22] signal/um: Use force_sig_fault in relay_signal.
Date: Tue, 24 Apr 2018 17:24:24 -0500
Message-ID: <87lgdc1bvr.fsf@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
        <20180420143811.9994-19-ebiederm@xmission.com>
        <7074fe36-27c5-ee82-9659-da703cfc91fe@kot-begemot.co.uk>
        <CAFLxGvyM+Kru=ERDvccjVuMjSPbu+FQzjbUbMwSyEbL1rVGkBQ@mail.gmail.com>
        <7ddd238f-88a8-ed03-fe9e-0f4e5f2a490d@kot-begemot.co.uk>
        <87zi1sd28d.fsf@xmission.com>
        <CAMD8JhwgcWCp6c=O4-spNW1VdY5M-eAjr7M5PieeAfeTSe_4yw@mail.gmail.com>
        <CAMD8JhxHwcuXh68o1=fbZ_t6DH7x_dO_0nEMqL=cHXBfZXub=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMD8JhxHwcuXh68o1=fbZ_t6DH7x_dO_0nEMqL=cHXBfZXub=w@mail.gmail.com>
        ("Martin \=\?utf-8\?Q\?P\=C3\=A4rtel\=22's\?\= message of "Wed, 25 Apr 2018 01:03:39
 +0300")
Sender: linux-kernel-owner@vger.kernel.org
To: Martin =?utf-8?Q?P=C3=A4rtel?= <martin.partel@gmail.com>
Cc: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, Richard Weinberger <richard.weinberger@gmail.com>, Linux-Arch <linux-arch@vger.kernel.org>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>
List-Id: linux-arch.vger.kernel.org

Martin Pärtel <martin.partel@gmail.com> writes:

> And once more in plain text..
>
> On 25 April 2018 at 01:00, Martin Pärtel <martin.partel@gmail.com> wrote:
>>
>> Hi all,
>>
>> This was ages ago, but from what I remember...
>>
>>>
>>> Having a second look I really don't understand what relay_signal is
>>> trying to do.
>>>
>>> The function relay_signal does not pass siginfo through unchanged.
>>
>>
>> Just copying the entire struct would do the wrong thing. It was discussed here:
>> https://marc.info/?l=user-mode-linux-devel&m=133910707911999&w=2

So you are regnerating siginfo to ensure you don't copy unintended
things such as the host pid and host uid.

Then my analysis is correct that you simply missed filtering out the
si codes that are not signal specific and do not use the fault layout
in struct siginfo.

Is si_addr safe to copy across?  I presume so since the kernel just
ptraces an ordinary process, but I figure I should ask and double
check.

I am going to respin my patch.  I would say that you really need a
white-list of si_codes that whose use of struct siginfo that you know.
Otherwise you could get into the same problem of under or over copying
data.

Eric

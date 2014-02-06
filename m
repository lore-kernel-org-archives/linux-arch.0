From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v3 0/2] qspinlock: Introducing a 4-byte queue spinlock
Date: Wed, 05 Feb 2014 22:09:13 -0500
Message-ID: <52F2FCD9.3010402@hp.com>
References: <1390933151-1797-1-git-send-email-Waiman.Long@hp.com> <52EA139C.8040106@linux.vnet.ibm.com> <52EA71F8.7070308@hp.com> <52EA9ECA.5040400@linux.vnet.ibm.com> <52EF588B.4050904@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:16304 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754476AbaBFDJk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2014 22:09:40 -0500
In-Reply-To: <52EF588B.4050904@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Andi Kleen <andi@firstfloor.org>, Rik van Riel <riel@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, George Spelvin <linux@horizon.com>, Tim Chen <tim.c.chen@linux.intel.com>, Daniel J Blueman <daniel@numascale.com>, Alexander Fyodorov <halcy@yandex.ru>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>, Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>

On 02/03/2014 03:51 AM, Raghavendra K T wrote:
> On 01/31/2014 12:19 AM, Raghavendra K T wrote:
>> On 01/30/2014 09:08 PM, Waiman Long wrote:
>>> On 01/30/2014 03:55 AM, Raghavendra K T wrote:
>>>> On 01/28/2014 11:49 PM, Waiman Long wrote:
>> [...]
>>                    from kernel/bounds.c:9:
>>>> include/linux/log2.h: In function =E2=80=98__ilog2_u32=E2=80=99:
>>>> include/linux/log2.h:34:2: error: implicit declaration of function
>>>> =E2=80=98fls=E2=80=99 [-Werror=3Dimplicit-function-declaration]
>>>> include/linux/log2.h: In function =E2=80=98__ilog2_u64=E2=80=99:
>>>> include/linux/log2.h:42:2: error: implicit declaration of function
>>>> =E2=80=98fls64=E2=80=99 [-Werror=3Dimplicit-function-declaration]
>>>> include/linux/log2.h: In function =E2=80=98__roundup_pow_of_two=E2=
=80=99:
>>>> .
>>>> .
>>>> [trimmed]
>>>>
>>>
>>> The code will need to be compiled in either the latest linux tree a=
s=20
>>> the
>>> patches have dependency on some new memory barrier that are in 3.14=
=2E
>>> Alternatively, you can compile with the latest tip tree.
>>>
>>> If you have already done that, please send me your config file so=20
>>> that I
>>> can reproduce the compilation error in my build environment.
>>>
>>
>> I did compile on latest linux tree which had barrier.txt. May be I '=
ll
>> recheck if I am missing something obvious.
>>
>> Here is .config attached
>
> An Update:
> The reason for failure was that I was compiling for guest. and
> CONFIG_PARAVIRT was enabled.
>
>
>
Thank for the information. I will update my patch to correct that probl=
em.

-Longman

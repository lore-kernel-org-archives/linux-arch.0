From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [RFC v1 0/6] kunit: create a centralized executor to dispatch all
 KUnit tests
Date: Tue, 28 Jan 2020 22:24:53 -0600
Message-ID: <dcf2d008-c044-f2d4-63b9-47151157eeb4@gmail.com>
References: <20191216220555.245089-1-brendanhiggins@google.com>
 <20200106224022.GX11244@42.do-not-panic.com>
 <CAFd5g456c2Zs7rCvRPgio83G=SrtPGi25zbqAUyTBHspHwtu4w@mail.gmail.com>
 <594b7815-0611-34ea-beb5-0642114b5d82@gmail.com>
 <CAFd5g469TWzrLKmQNR2i0HACJ3FEu-=4-Rk005g9szB5UsZAcw@mail.gmail.com>
 <e801e4ac-b7c2-3d0a-71e7-f8153a3dfbc8@gmail.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF982C9840@USCULXMSG17.am.sony.com>
 <CAFd5g46Ut9Suptmp_bBspkp=KKt2GP+=1C5zLu0FXJY9dGJbFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46369 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgA2EY4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jan 2020 23:24:56 -0500
In-Reply-To: <CAFd5g46Ut9Suptmp_bBspkp=KKt2GP+=1C5zLu0FXJY9dGJbFQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>, "Bird, Timothy" <Tim.Bird@sony.com>, Alan Maguire <alan.maguire@oracle.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>, Iurii Zaikin <yzaikin@google.com>, David Gow <davidgow@google.com>, Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com, Greg KH <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Knut Omang <knut.omang@oracle.com>, linux-um <linux-um@lists.infradead.org>, linux-arch@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, KUnit Development <kunit-dev@googlegroups.com>, Linux

On 1/28/20 1:53 PM, Brendan Higgins wrote:
> On Tue, Jan 28, 2020 at 11:35 AM <Tim.Bird@sony.com> wrote:
>>
>>> -----Original Message-----
>>> From:  Frank Rowand on January 28, 2020 11:37 AM
>>>
>>> On 1/28/20 1:19 AM, Brendan Higgins wrote:
>>>> On Mon, Jan 27, 2020 at 9:40 AM Frank Rowand <frowand.list@gmail.com> wrote:
>> ...
>>>> we could add Kconfigs to control this, but the compiler nevertheless
>>>> complains because it doesn't know what phase KUnit runs in.
>>>>
>>>> Is there any way to tell the compiler that it is okay for non __init
>>>> code to call __init code? I would prefer not to have a duplicate
>>>> version of all the KUnit libraries with all the symbols marked __init.
>>>
>>> I'm not sure.  The build messages have always been useful and valid in
>>> my context, so I never thought to consider that possibility.
>>>
>>>> Thoughts?
>>
>> I'm not sure there's a restriction on non __init code calling __init
>> code.  In init/main.c arch_call_reset_init() is in __init, and it calls
>> rest_init which is non __init, without any special handling.
>>
>> Is the compiler complaint mentioned above related to  calling
>> into __init code, or with some other issue?
> 
> I distinctly remember having the compiler complain at me when I was
> messing around with the device tree unit tests because of KUnit
> calling code marked as __init. Maybe it's time to start converting
> those to KUnit to force the issue? Frank, does that work for you?

I have agreed to try converting the devicetree unittest to KUnit.

Now that KUnit is in 5.5, I think there is a solid foundation for
me to proceed.

-Frank

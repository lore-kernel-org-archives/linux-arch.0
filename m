Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:50744 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163145AbdEYUW7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2017 16:22:59 -0400
Subject: Re: CPU_BIG_ENDIAN in generic code (was: Re: [PATCH v3 3/7]
 arch/sparc: Define config parameter CPU_BIG_ENDIAN)
References: <CAMuHMdVjh+1TR19mUUQYHSazHnBHa4uxn7KyHUO+jAh7WDxy5Q@mail.gmail.com>
 <CAK8P3a1XZGQk3b3q+JFJ+mLgw_upUdAtTM1VBjHZq5f2m-YdUg@mail.gmail.com>
 <8ddc7276-6296-2284-51d3-01093ccbeccb@oracle.com>
 <CAK8P3a0MEkZ0wpsrit+sS8A0Z5T_jFWF5vFq_BqF2A1tReb7tQ@mail.gmail.com>
From: Babu Moger <babu.moger@oracle.com>
Message-ID: <0b20ab53-a154-0b57-e842-4636b6048e40@oracle.com>
Date: Thu, 25 May 2017 15:22:13 -0500
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0MEkZ0wpsrit+sS8A0Z5T_jFWF5vFq_BqF2A1tReb7tQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, sparclinux <sparclinux@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Message-ID: <20170525202213.l8O2DU2f8wTB-_3Ylqrr30YxxFd3k-eQM_4cC_yZbKA@z>


On 5/25/2017 3:09 PM, Arnd Bergmann wrote:
> On Thu, May 25, 2017 at 4:51 PM, Babu Moger <babu.moger@oracle.com> wrote:
>> On 5/24/2017 5:18 AM, Arnd Bergmann wrote:
>>>> I guess the time is ripe for adding (both) symbols to all architectures?
>>> Good idea. I think we can do most of this by adding a few lines to
>>> arch/Kconfig:
>>>
>>> config CPU_BIG_ENDIAN
>>>           bool
>>>
>>> config CPU_LITTLE_ENDIAN
>>>          def_bool !CPU_BIG_ENDIAN
>>>
>>> This way, we only need to add 'select CPU_BIG_ENDIAN' to the
>>> architectures that are always big-endian, and we don't need to
>>> change anything for the ones that have a single 'CPU_BIG_ENDIAN'
>>> option.
>>>
>>> The three architectures that have a 'choice' statement (mips, ppc and
>>> sh) will have to convert, and m32r will have to replace the
>>
>> what to you mean by "(mips, ppc andsh) will have to convert"?  Do you expect
>> any changes here?
>>
> Kconfig does not allow you to have the same symbol as both a regular
> 'bool' and also 'bool within choice', so those three have to replace the
> choice with a user-visible 'config CPU_BIG_ENDIAN' option like the
> other ones have.

Ok. I will address it in my  next version.  Thanks

>
> I also notice that  for arch/s390/Kconfig you now have both the
> 'select CPU_BIG_ENDIAN' and the 'config CPU_BIG_ENDIAN
> def_bool y', I'd remove the second one in the same patch.

Sure. Will correct it.
>         Arnd

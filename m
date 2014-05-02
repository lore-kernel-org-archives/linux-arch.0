From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH 07/28] nios2: I/O Mapping
Date: Fri, 2 May 2014 18:37:55 +0800
Message-ID: <CAFiDJ58MT1z-hw6_ZWBc5QcCJoEdNCdaVPfVgXE2BpUr9c9ztA@mail.gmail.com>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
	<1397845149-3141-1-git-send-email-lftan@altera.com>
	<1397845149-3141-3-git-send-email-lftan@altera.com>
	<201404221559.37560.arnd@arndb.de>
	<CAFiDJ5_79UoFS0bbgyd6htRELXpsF4bD091Bg1EVsocXt76NEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:56115 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbaEBKh4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 2 May 2014 06:37:56 -0400
In-Reply-To: <CAFiDJ5_79UoFS0bbgyd6htRELXpsF4bD091Bg1EVsocXt76NEw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, cltang@codesourcery.com

On Thu, Apr 24, 2014 at 2:02 PM, Ley Foon Tan <lftan@altera.com> wrote:
> On Tue, Apr 22, 2014 at 9:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Friday 18 April 2014, Ley Foon Tan wrote:
>>
>>> +
>>> +#include <asm/pgtable-bits.h>
>>> +
>>> +#define IO_SPACE_LIMIT 0xffffffff
>>
>> Please use 0xffff here, this should work for almost any PCI bus.
> Ah, CONFIG_PCI is not enable in nios2. So, I think IO_SPACE_LIMIT
> should set to 0.
>
>
>>> +
>>> +/* Use "Duff's Device" to unroll the loops. */
>>> +#define __IO_OUT_LOOP(a, b, l)                               \
>>> +     do {                                            \
>>> +             if (l > 0) {                            \
>>> +                     int _n = (l + 7) / 8;           \
>>> +                     switch (l % 8) {                \
>>> +                     case 0:                         \
>>> +                             do {                    \
>>> +                                     *a = *b++;      \
>>
>> I would recommend just doing all of this in out-of-line implementations
>> rather than macros and inline functions.
> Okay. Will move the macros to out-of-line function.
I'm start working on this and found that it is better to keep it as
macros. This is because the input arguments "a" and "b" can be
byte/short/int pointers. Otherwise, we need to have separate function
calls for byte/short/int.

Regards
Ley Foon

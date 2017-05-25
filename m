Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35205 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1946116AbdEYW1t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2017 18:27:49 -0400
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1XZGQk3b3q+JFJ+mLgw_upUdAtTM1VBjHZq5f2m-YdUg@mail.gmail.com>
References: <CAMuHMdVjh+1TR19mUUQYHSazHnBHa4uxn7KyHUO+jAh7WDxy5Q@mail.gmail.com>
 <CAK8P3a1XZGQk3b3q+JFJ+mLgw_upUdAtTM1VBjHZq5f2m-YdUg@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 25 May 2017 15:27:48 -0700
Message-ID: <CAMo8BfL8G0Fzn2SZ1356yaoxGgm8tpTDmFJ8cCxEEEgyObMwCQ@mail.gmail.com>
Subject: Re: CPU_BIG_ENDIAN in generic code (was: Re: [PATCH v3 3/7]
 arch/sparc: Define config parameter CPU_BIG_ENDIAN)
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Babu Moger <babu.moger@oracle.com>, "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, sparclinux <sparclinux@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Message-ID: <20170525222748.HYcqA-sgz0AsVjpyrp9liWkr5aRSpe6y5WgTg-9WWek@z>

On Wed, May 24, 2017 at 3:18 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, May 24, 2017 at 11:59 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> I guess the time is ripe for adding (both) symbols to all architectures?
>
> Good idea. I think we can do most of this by adding a few lines to
> arch/Kconfig:
>
> config CPU_BIG_ENDIAN
>         bool
>
> config CPU_LITTLE_ENDIAN
>        def_bool !CPU_BIG_ENDIAN
>
> This way, we only need to add 'select CPU_BIG_ENDIAN' to the
> architectures that are always big-endian, and we don't need to
> change anything for the ones that have a single 'CPU_BIG_ENDIAN'
> option.
>
> The three architectures that have a 'choice' statement (mips, ppc and
> sh) will have to convert, and m32r will have to replace the
> option with the opposite one, which could break 'make oldconfig',
> but nobody really cares about m32r any more.

Xtensa may have either endianness and for xtensa we define
CONFIG_CPU_BIG_ENDIAN or CONFIG_CPU_LITTLE_ENDIAN
in the arch/xtensa/Makefile based on the value of the compiler builtin
macro.

-- 
Thanks.
-- Max

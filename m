Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb0-f196.google.com ([209.85.213.196]:34099 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760337AbdEYWwV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2017 18:52:21 -0400
MIME-Version: 1.0
In-Reply-To: <116e7ba5-cb5e-8e96-ea74-bf91b4818d69@oracle.com>
References: <CAMuHMdVjh+1TR19mUUQYHSazHnBHa4uxn7KyHUO+jAh7WDxy5Q@mail.gmail.com>
 <CAK8P3a1XZGQk3b3q+JFJ+mLgw_upUdAtTM1VBjHZq5f2m-YdUg@mail.gmail.com>
 <CAMo8BfL8G0Fzn2SZ1356yaoxGgm8tpTDmFJ8cCxEEEgyObMwCQ@mail.gmail.com> <116e7ba5-cb5e-8e96-ea74-bf91b4818d69@oracle.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 25 May 2017 15:52:14 -0700
Message-ID: <CAMo8Bf+m0mqnrpC=b+3sGq0iMfqUj2uVtQxtLU6+5pNc_4fWNw@mail.gmail.com>
Subject: Re: CPU_BIG_ENDIAN in generic code (was: Re: [PATCH v3 3/7]
 arch/sparc: Define config parameter CPU_BIG_ENDIAN)
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Babu Moger <babu.moger@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, sparclinux <sparclinux@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Message-ID: <20170525225214.KNGhHZElOdvigwtEh0eAawPo-AVtp2faNyJuFPTTYGw@z>

On Thu, May 25, 2017 at 3:41 PM, Babu Moger <babu.moger@oracle.com> wrote:
> On 5/25/2017 5:27 PM, Max Filippov wrote:
>> Xtensa may have either endianness and for xtensa we define
>> CONFIG_CPU_BIG_ENDIAN or CONFIG_CPU_LITTLE_ENDIAN
>> in the arch/xtensa/Makefile based on the value of the compiler builtin
>> macro.
>
> Hmm.. That means defining  CPU_LITTLE_ENDIAN  based on "def_bool
> !CPU_BIG_ENDIAN" will
>  be a problem for Xtensa because menuconfig does not have the knowledge of
> compiler builtin macro.
> Is that correct?

I think so. OTOH outside the arch/ CPU_LITTLE_ENDIAN is only used in
two Kconfig files:

drivers/crypto/nx/Kconfig
drivers/isdn/hisax/Kconfig

both of which are irrelevant for xtensa.

-- 
Thanks.
-- Max

From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH v5 29/29] nios2: Build infrastructure
Date: Mon, 27 Oct 2014 17:44:53 +0800
Message-ID: <CAFiDJ5_LKWB_iZc0mX2AYA8mqAHcskEE6TdOdz3YUKCV6QouRA@mail.gmail.com>
References: <1414139071-3818-1-git-send-email-lftan@altera.com>
	<1414139071-3818-30-git-send-email-lftan@altera.com>
	<CAMuHMdXTg3s_ZKL5M+=LwiNBa4gL8Z=eOchocD3qjvp-d=gW_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXTg3s_ZKL5M+=LwiNBa4gL8Z=eOchocD3qjvp-d=gW_Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Chung-Lin Tang <cltang@codesourcery.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Oct 24, 2014 at 5:10 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Fri, Oct 24, 2014 at 10:24 AM, Ley Foon Tan <lftan@altera.com> wrote:
>> --- /dev/null
>> +++ b/arch/nios2/boot/install.sh
>> @@ -0,0 +1,52 @@
>> +#!/bin/sh
>> +#
>> +# This file is subject to the terms and conditions of the GNU General Public
>> +# License.  See the file "COPYING" in the main directory of this archive
>> +# for more details.
>> +#
>> +# Copyright (C) 1995 by Linus Torvalds
>> +#
>> +# Adapted from code in arch/i386/boot/Makefile by H. Peter Anvin
>> +#
>> +# "make install" script for m68k architecture
>
> You probably want to s/m68k/nios2/ here.
Yes, will change this.

Regards
Ley Foon

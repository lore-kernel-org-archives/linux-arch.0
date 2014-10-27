Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:45341 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbaJ0Jo4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Oct 2014 05:44:56 -0400
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXTg3s_ZKL5M+=LwiNBa4gL8Z=eOchocD3qjvp-d=gW_Q@mail.gmail.com>
References: <1414139071-3818-1-git-send-email-lftan@altera.com>
	<1414139071-3818-30-git-send-email-lftan@altera.com>
	<CAMuHMdXTg3s_ZKL5M+=LwiNBa4gL8Z=eOchocD3qjvp-d=gW_Q@mail.gmail.com>
Date: Mon, 27 Oct 2014 17:44:53 +0800
Message-ID: <CAFiDJ5_LKWB_iZc0mX2AYA8mqAHcskEE6TdOdz3YUKCV6QouRA@mail.gmail.com>
Subject: Re: [PATCH v5 29/29] nios2: Build infrastructure
From: Ley Foon Tan <lftan@altera.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Chung-Lin Tang <cltang@codesourcery.com>
Message-ID: <20141027094453.BJNRjOCoEuF2UQv1cBaAx9EMK2_g5ND_I7L3jkTLR3g@z>

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

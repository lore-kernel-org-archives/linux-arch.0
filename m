Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:43110 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750AbaDWKHu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 Apr 2014 06:07:50 -0400
MIME-Version: 1.0
In-Reply-To: <20140422142831.GC15745@arch.cereza>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
	<1397845149-3141-1-git-send-email-lftan@altera.com>
	<1397845149-3141-2-git-send-email-lftan@altera.com>
	<20140422142831.GC15745@arch.cereza>
Date: Wed, 23 Apr 2014 18:07:49 +0800
Message-ID: <CAFiDJ5_XXXRAG7nv8zb6myK1Vn97SHRTq2mvf4AJhH9ZDSHVQg@mail.gmail.com>
Subject: Re: [PATCH 05/28] nios2: Traps exception handling
From: Ley Foon Tan <lftan@altera.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, cltang@codesourcery.com
Message-ID: <20140423100749.eCm_tdpmzZn9fBXJz4zZpOjRvXixyJcnkYmk32TIsIg@z>

On Tue, Apr 22, 2014 at 10:28 PM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> Hello Ley Foon,
>
> On Apr 19, Ley Foon Tan wrote:
>> +
>> +#ifndef CONFIG_ALIGNMENT_TRAP
>> +/* Alignment exception handler */
>> +asmlinkage void handle_unaligned_c(struct pt_regs *fp, int cause)
>> +{
>> +     unsigned long addr = RDCTL(CTL_BADADDR);
>> +
>> +     cause >>= 2;
>> +     fp->ea -= 4;
>> +
>> +     if (fixup_exception(fp))
>> +             return;
>
> This will throw an undeclared error if you build with CONFIG_ALIGNMENT_TRAP=n.
>
> You need to add the uaccess.h header, or implement some similar fix.
Okay, I will try with CONFIG_ALIGNMENT_TRAP=n and fix it.

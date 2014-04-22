Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:52393 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065AbaDVIJr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Apr 2014 04:09:47 -0400
MIME-Version: 1.0
In-Reply-To: <20140419160552.GA19577@amd.pavel.ucw.cz>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
	<1397824031-4892-7-git-send-email-lftan@altera.com>
	<20140419160552.GA19577@amd.pavel.ucw.cz>
Date: Tue, 22 Apr 2014 16:09:46 +0800
Message-ID: <CAFiDJ5_gcSfJT1Dphc6kizkExssvkd4Pdd40iDZpr9J7Y55g-g@mail.gmail.com>
Subject: Re: [PATCH 09/28] nios2: Page table management
From: Ley Foon Tan <lftan@altera.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pavel Machek <pavel@denx.de>
Cc: linux-arch@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, cltang@codesourcery.com
Message-ID: <20140422080946.j3tgvhW2eTFmztVinPQ-DdrvUi-Wn527kGNvQ5_EOgc@z>

Hi

On Sun, Apr 20, 2014 at 12:05 AM, Pavel Machek <pavel@denx.de> wrote:

>> +static void pgd_init(pgd_t *pgd)
>> +{
>> +     unsigned long *p = (unsigned long *) pgd;
>> +     int i;
>> +
>> +     for (i = 0; i < USER_PTRS_PER_PGD; i += 8) {
>> +             p[i + 0] = (unsigned long) invalid_pte_table;
>> +             p[i + 1] = (unsigned long) invalid_pte_table;
>> +             p[i + 2] = (unsigned long) invalid_pte_table;
>> +             p[i + 3] = (unsigned long) invalid_pte_table;
>> +             p[i + 4] = (unsigned long) invalid_pte_table;
>> +             p[i + 5] = (unsigned long) invalid_pte_table;
>> +             p[i + 6] = (unsigned long) invalid_pte_table;
>> +             p[i + 7] = (unsigned long) invalid_pte_table;
>> +     }
>
> Umm. Manual loop unrolling. Does it really improve performance? Is the
> code hot enough to warrant the uglyness?
We can use the memset here because invalid_pte_table is full 32 bit value.
BTW, arch for score and mips have the similar implementation as well.

Regards

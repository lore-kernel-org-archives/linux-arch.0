Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:39282 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbaG3Kwv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 30 Jul 2014 06:52:51 -0400
MIME-Version: 1.0
In-Reply-To: <20140730085743.GC10301@distanz.ch>
References: <1405413956-2772-1-git-send-email-lftan@altera.com>
	<1405413956-2772-6-git-send-email-lftan@altera.com>
	<CAMuHMdUyif5JS9OdiamHhf+r5oeTRdd7Gzd6-rBUyamnNQ6C8A@mail.gmail.com>
	<CAFiDJ5_9a7pr+16gjV5-cA_Ruoz1LDMKivFemNiOf_Me4bLEUg@mail.gmail.com>
	<CAMuHMdWw7WGibh38OdAQEmFzV3J9-z3=B74y8i8XxNsdTvOEyw@mail.gmail.com>
	<20140730085743.GC10301@distanz.ch>
Date: Wed, 30 Jul 2014 18:52:50 +0800
Message-ID: <CAFiDJ5-hu8HDMiteNA2LeWkkSHXtnFefZZ1Bi=HqVRwuvZaowA@mail.gmail.com>
Subject: Re: [PATCH v2 05/29] nios2: Memory management
From: Ley Foon Tan <lftan@altera.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Chung-Lin Tang <cltang@codesourcery.com>
Message-ID: <20140730105250.yhrD8NmH1DoXvi9QHvgsGFm1UWO-TH9c8q_e6SAot9E@z>

On Wed, Jul 30, 2014 at 4:57 PM, Tobias Klauser <tklauser@distanz.ch> wrote:

>> >> Any chance you can use mmu.h from asm-generic instead?
>> >> It uses a struct with a single "unsigned long end_brk" member (unless
>> >> CONFIG_BINFMT_ELF_FDPIC is defined).
>> > From asm-generic/mmu.h, it is for nommu implementations.
>> > So, I will keep this as it is now.
>>
>> Right, you have a MMU.
>> I got confused by the "Taken from m68knommu" comment, and you still
>> only need a single "unsigned long".
>
> That comment stems from the initial Nios II NOMMU port done by
> Microtronix. Since Nios II NOMMU support was dropped for mainline
> submission anyhow, it might be better to drop that comment to avoid any
> future confusion :)
Okay, I will remove these nommu comments.

Thanks.

Regards
Ley Foon

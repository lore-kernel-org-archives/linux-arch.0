Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37804 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbeHFAzI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Aug 2018 20:55:08 -0400
Received: by mail-oi0-f67.google.com with SMTP id j205-v6so18979396oib.4
        for <linux-arch@vger.kernel.org>; Sun, 05 Aug 2018 15:48:55 -0700 (PDT)
Subject: Re: [PATCH] sh: remove unneeded constructor.
References: <20180731051519.101249-1-ysato@users.sourceforge.jp>
 <CAMuHMdUQReuzR=x54gnC1XdP77RrT1TaWoFFXUhUQ02A+giPqQ@mail.gmail.com>
 <87600us5k9.wl-ysato@users.sourceforge.jp>
 <20180804103550.GA3183@bombadil.infradead.org>
 <CAMuHMdXsz-+zsxouaLP5tTKA46G34iAACSce+RXrD8AiiQc2+A@mail.gmail.com>
 <20180804105149.GB3183@bombadil.infradead.org>
 <4e9e1599-9dbf-75dc-561e-77d5cb063714@landley.net>
 <20180805163234.GR1392@brightrain.aerifal.cx>
From: Rob Landley <rob@landley.net>
Message-ID: <61a157f1-7d43-6554-5d26-84d47ce6cabe@landley.net>
Date: Sun, 5 Aug 2018 17:48:52 -0500
MIME-Version: 1.0
In-Reply-To: <20180805163234.GR1392@brightrain.aerifal.cx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rich Felker <dalias@libc.org>
Cc: Matthew Wilcox <willy@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On 08/05/2018 11:32 AM, Rich Felker wrote:
> On Sun, Aug 05, 2018 at 10:54:56AM -0500, Rob Landley wrote:
>> On 08/04/2018 05:51 AM, Matthew Wilcox wrote:
>>> On Sat, Aug 04, 2018 at 12:47:08PM +0200, Geert Uytterhoeven wrote:
>>>> You do want to readd the __GFP_ZERO flag to the second user of PGALLOC_GFP,
>>>> don't you?
>>>
>>> I missed that!  Probably only relevant for SH-64.  But yes ... probably better
>>> to make this explicit then:
>>
>> As far as I know sh5/sh-64 never shipped, it was just some prototype hardware
>> that didn't go to production?
> 
> I'm not sure about the details, but GCC has removed support and it's
> effectively dead. I would be happy to merge patches removing the
> existing SH-64 stuff in the kernel too. I'm not sure if generality to
> support LP64 should be left in the arch/sh tree for future or if the
> eventual 64-bit j-core should just be done as a separate arch tree; I
> suspect the latter might be cleaner.

LP64 is mostly just "long fits in a pointer", which is true on 32 bit too. What
extra "lp64" support are you referring to?

It seems like the only architecture with 32 and 64 bit variants that _doesn't_
have them together is arm? (x86 does, powerpc does, mips does...)

Rob

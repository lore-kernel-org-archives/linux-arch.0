Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33335 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbeHESAA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Aug 2018 14:00:00 -0400
Received: by mail-oi0-f65.google.com with SMTP id 8-v6so18086504oip.0
        for <linux-arch@vger.kernel.org>; Sun, 05 Aug 2018 08:54:58 -0700 (PDT)
Subject: Re: [PATCH] sh: remove unneeded constructor.
References: <20180731051519.101249-1-ysato@users.sourceforge.jp>
 <CAMuHMdUQReuzR=x54gnC1XdP77RrT1TaWoFFXUhUQ02A+giPqQ@mail.gmail.com>
 <87600us5k9.wl-ysato@users.sourceforge.jp>
 <20180804103550.GA3183@bombadil.infradead.org>
 <CAMuHMdXsz-+zsxouaLP5tTKA46G34iAACSce+RXrD8AiiQc2+A@mail.gmail.com>
 <20180804105149.GB3183@bombadil.infradead.org>
From: Rob Landley <rob@landley.net>
Message-ID: <4e9e1599-9dbf-75dc-561e-77d5cb063714@landley.net>
Date: Sun, 5 Aug 2018 10:54:56 -0500
MIME-Version: 1.0
In-Reply-To: <20180804105149.GB3183@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On 08/04/2018 05:51 AM, Matthew Wilcox wrote:
> On Sat, Aug 04, 2018 at 12:47:08PM +0200, Geert Uytterhoeven wrote:
>> You do want to readd the __GFP_ZERO flag to the second user of PGALLOC_GFP,
>> don't you?
> 
> I missed that!  Probably only relevant for SH-64.  But yes ... probably better
> to make this explicit then:

As far as I know sh5/sh-64 never shipped, it was just some prototype hardware
that didn't go to production?

(I know the j-core project is taking a different 64 bit approach, much more like
x86-64's mode bit than itanium two completely different instruction sets, but
last I heard they're just now testing the j32 with-mmu bitstreams so it'll be a
while before that's relevant. :)

Rob

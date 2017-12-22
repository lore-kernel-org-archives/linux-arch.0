From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Function pointer alignment
Date: Fri, 22 Dec 2017 14:58:37 +0100
Message-ID: <CAMuHMdUzDc0POByhGZCAf8j07KAcVCAX74XvJ_kN_tZC2Xf4Cg@mail.gmail.com>
References: <20171222035518.GC23624@bombadil.infradead.org>
 <CAMuHMdVNF66QSnRvJxkNowMuVKeSoc7PHa+Ep-ojYmA2ywPRxQ@mail.gmail.com>
 <CAMuHMdWM-1VepP2fDxAwG6m+WC33UqPWN=DL7JEYVwSbtU8Xkg@mail.gmail.com> <20171222130936.GC6401@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35434 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755887AbdLVN6j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Dec 2017 08:58:39 -0500
Received: by mail-qt0-f195.google.com with SMTP id u10so36372997qtg.2
        for <linux-arch@vger.kernel.org>; Fri, 22 Dec 2017 05:58:39 -0800 (PST)
In-Reply-To: <20171222130936.GC6401@bombadil.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>

Hi Willy,

On Fri, Dec 22, 2017 at 2:09 PM, Matthew Wilcox <willy@infradead.org> wrote:
> On Fri, Dec 22, 2017 at 01:30:51PM +0100, Geert Uytterhoeven wrote:
>> On Fri, Dec 22, 2017 at 1:28 PM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>> > On Fri, Dec 22, 2017 at 4:55 AM, Matthew Wilcox <willy@infradead.org> wrote:
>> >> What alignment can we rely on for function pointers?
>> >
>> > Only one bit to steal on m68k...
>>
>> Same on SH.
>
> How much damage would we do by adding -falign-functions=4 to CFLAGS
> on m68k?  Can you measure that for me?

With defconfig (aka multi_defconfig) and gcc 4.1.2:

   text    data     bss     dec     hex filename
3594487 959460 186492 4740439 485557 vmlinux.old
3611159 959484 185724 4756367 48938f vmlinux

text +16672
data +24
bss -768 (why?)
total +15928

Given kernel size increased on average almost 50 KiB between
v4.x and v4.(x+1), the damage wouldn't be that bad ;-)

Note that this aligned C functions only.  Assembler code (incl. the '040 and
'060 integer/floating point support packages) still has to be fixed.

Gr{oetje,eeting}s,

                        Geert

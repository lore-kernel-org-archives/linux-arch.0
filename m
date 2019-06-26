Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:56185 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725958AbfFZP4S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Jun 2019 11:56:18 -0400
Subject: Re: [RFC] remove arch/sh?
References: <20190625085616.GA32399@lst.de>
 <ccfa78f3-35c2-1d26-98b5-b21a76b90e1e@physik.fu-berlin.de>
 <20190625112146.GA9580@angband.pl>
 <401b12c0-d175-2720-d26c-b96ce3b28c71@physik.fu-berlin.de>
 <CAK8P3a3irwwwCQ_kPh5BTg-jGGbJOj=3fhVrTDBUZgH1V7bpFQ@mail.gmail.com>
 <20190625142832.GD1506@brightrain.aerifal.cx>
 <CAK8P3a0j_9fzZxhxqCMHfoJ5DdZpHFvANEPqs1pbP23TCei6ng@mail.gmail.com>
 <87tvccr3kv.wl-ysato@users.sourceforge.jp>
 <20190626153820.GP1506@brightrain.aerifal.cx>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <cf3c3583-2b6c-8c45-a37f-357aca8ee80c@physik.fu-berlin.de>
Date: Wed, 26 Jun 2019 17:56:12 +0200
MIME-Version: 1.0
In-Reply-To: <20190626153820.GP1506@brightrain.aerifal.cx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Arnd Bergmann <arnd@arndb.de>, Adam Borowski <kilobyte@angband.pl>, Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-sh list <linux-sh@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20190626155612.5cZFjA9DPmOwiStHZvw3unuGYgV-QTFMgYUmNDt0jxY@z>

On 6/26/19 5:38 PM, Rich Felker wrote:
>>> Maybe everything but J2 and SH4(a) can just get retired?
>>>
>>>      Arnd
>>
>> I also have some boards, so it's possible to rewrite more.
>> I can not rewrite the target I do not have, so I think that
>> there is nothing but to retire.
> 
> To clarify, are you agreeing with Arnd's suggestion to retire/remove
> everything but jcore and sh4[a]?

I would keep J-Core, SH3 and SH4[a]. SH5 can go in any case since there
is no hardware available and gcc has no longer support for the target
either.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

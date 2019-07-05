Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:42329 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725837AbfGEOFD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Jul 2019 10:05:03 -0400
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
 <87a7ds4mis.wl-ysato@users.sourceforge.jp>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <e69b583d-0bed-3331-a82a-d41a3687d3c7@physik.fu-berlin.de>
Date: Fri, 5 Jul 2019 16:04:49 +0200
MIME-Version: 1.0
In-Reply-To: <87a7ds4mis.wl-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Adam Borowski <kilobyte@angband.pl>, Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-sh list <linux-sh@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20190705140449.y-ZG32AdnakENtMSlGxMGgR5K1J-toZH2qzzxc8Dy7Y@z>

On 7/5/19 3:51 PM, Yoshinori Sato wrote:
> I have SH2/2A/3 target board.

I've also got SH2/2A/3 boards ;).

> So can mantain CPU support.
> But with board support it will be difficult.
> I would like to make the transition to a common framework.

Yes, that would be great. I assume the basis will be device trees.

> I also have to fix the parts that depend on each board for migration,
> so I would like to limit the target for maintenance to only those
> that can be used now.

FWIW, could you open a pull request for Linus so that the SH fixes,
especially the kprobes fix, gets merged into Linus' tree?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

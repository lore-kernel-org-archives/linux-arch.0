Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:54415 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727730AbfFYOcD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Jun 2019 10:32:03 -0400
Subject: Re: [RFC] remove arch/sh?
References: <20190625085616.GA32399@lst.de>
 <ccfa78f3-35c2-1d26-98b5-b21a76b90e1e@physik.fu-berlin.de>
 <20190625142144.GC1506@brightrain.aerifal.cx> <20190625142341.GA6948@lst.de>
 <20190625142927.GE1506@brightrain.aerifal.cx>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <17b69880-3adc-202a-8ee3-4bce118934cb@physik.fu-berlin.de>
Date: Tue, 25 Jun 2019 16:31:59 +0200
MIME-Version: 1.0
In-Reply-To: <20190625142927.GE1506@brightrain.aerifal.cx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190625143159.kGL2VtrlDh4RFS6f1x4sByxUTARTLxE0Daat-1Uk3AM@z>

Hi Rich and Sato-san!

On 6/25/19 4:29 PM, Rich Felker wrote:
> On Tue, Jun 25, 2019 at 04:23:41PM +0200, Christoph Hellwig wrote:
>> On Tue, Jun 25, 2019 at 10:21:44AM -0400, Rich Felker wrote:
>>> I'm generally okay with all proposed non-functional changes that come
>>> up that are just eliminating arch-specific cruft to use new shared
>>> kernel infrastructure. I recall replying to a few indicating this, but
>>> I missed a lot more. If it would be helpful I think I can commit to
>>> doing at least this more consistently, but I'm happy to have other
>>> maintainers make that call too.
>>
>> It woud be great if you could at least apply with a tentative ack.
>> At least for some trees we try very hard to get a maintainer ack,
>> so silence is holding things back to some extent.
> 
> OK.

Could either of you review this patch by Michael Karcher which unbreaks
the SH kernel when kprobes are enabled [1]?

Sorry for being persistent, but the fix is actually needed to get the
Debian kernel boot on qemu-sh4 again since Debian enables kprobes.

Thanks a lot!
Adrian

> [1] https://marc.info/?l=linux-sh&m=156034655921917&w=2

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

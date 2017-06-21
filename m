From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/5] kbuild: thin archives final link close
 --whole-archives option
Date: Wed, 21 Jun 2017 12:51:20 +0200
Message-ID: <CAK8P3a2MB37oqB2PerOtnjhp-NW+oKMsE1Vm7M4=zrJEL9nM9w@mail.gmail.com>
References: <20170609052417.561-1-npiggin@gmail.com> <20170609052417.561-2-npiggin@gmail.com>
 <CAK7LNASxuE-6eMk+Y-vyrMfibtYoD2JkjNS2z8QF85x9NdiiaA@mail.gmail.com>
 <20170619165100.3ce26d00@roar.ozlabs.ibm.com> <CAK7LNARuuQzGkYBdzoy3bVpBuNPZEMGerHSEdmrH+PqK0Gbyzg@mail.gmail.com>
 <20170619182714.2cb60e17@roar.ozlabs.ibm.com> <CAK7LNATznx=5A1KnhkFHpjencsJj7AGUsHtDUu6M-Qkw=jvpPQ@mail.gmail.com>
 <20170620015205.329519b2@roar.ozlabs.ibm.com> <CAK7LNAS6zucv54-XwqfTbm=y20eFVQYLwgsVCdtS7mYknsYK+Q@mail.gmail.com>
 <20170621124708.6bce7692@roar.ozlabs.ibm.com> <CAK7LNATPyoVcsDtFjRhdmFh7v_HE9F=2GVX=z+XVWV2fXsEukA@mail.gmail.com>
 <20170621140445.4d6fd92a@roar.ozlabs.ibm.com> <CAK8P3a34gWKqPCFDAnWki4H-eyj50Xgar+YFT_+2Og-qJb_i8A@mail.gmail.com>
 <20170621191607.33c8db74@roar.ozlabs.ibm.com> <CAK8P3a0NT42HKOU+ZDRg_-1hA+RzYnL0RtzqbMsLbY=yTUxGRA@mail.gmail.com>
 <20170621203824.719ffdc5@roar.ozlabs.ibm.com> <CAK8P3a1o91guXimc99sY3UOUjKTX5QxhQyOfY+j-x7MMCdRbdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:34842 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750823AbdFUKvV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2017 06:51:21 -0400
In-Reply-To: <CAK8P3a1o91guXimc99sY3UOUjKTX5QxhQyOfY+j-x7MMCdRbdw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, kbuild test robot <fengguang.wu@intel.com>, Josh Triplett <josh@joshtriplett.org>, Nicolas Pitre <nicolas.pitre@linaro.org>

On Wed, Jun 21, 2017 at 12:49 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Jun 21, 2017 at 12:38 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
>> On Wed, 21 Jun 2017 12:21:16 +0200
>> Arnd Bergmann <arnd@arndb.de> wrote:

>>> so we are fine as long as we enable THIN_ARCHIVES
>>> and LD_DEAD_CODE_DATA_ELIMINATION at the same time
>>> on ARM.
>>
>> Well the current proposal is to unconditionally enable it for all archs
>> for 4.13. After that I'll submit patches to x86 and powerpc arch
>> maintainers to allow LD_DEAD_CODE_DATA_ELIMINATION as an option. I guess
>> you will do ARM and there have been MIPS guys looking at it too.
>>
>> That leaves a window of one release. ARM could unselect thin archives if
>> necessary but I think it would be much better to enable it and flush out
>> any toolchain and build issues before doing the LD_DCDE option. Disabling
>> should be a last resort if we can't fix something in time for release.
>
> I see.

[hit 'send' too early]

We can always revert 06e226c7fb23 ("clk: sunxi-ng: Move all clock types to a
library"), it's also scheduled for 4.13 and has not been in a release yet.

       Arnd

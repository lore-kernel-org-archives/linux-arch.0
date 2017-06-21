From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/5] kbuild: thin archives final link close
 --whole-archives option
Date: Wed, 21 Jun 2017 22:55:06 +0200
Message-ID: <CAK8P3a2vV10+ymS7vHybfhRf_DVvACOW4O2OZzyz+v75y2Ak4w@mail.gmail.com>
References: <20170621140445.4d6fd92a@roar.ozlabs.ibm.com> <CAK8P3a34gWKqPCFDAnWki4H-eyj50Xgar+YFT_+2Og-qJb_i8A@mail.gmail.com>
 <20170621191607.33c8db74@roar.ozlabs.ibm.com> <CAK8P3a0NT42HKOU+ZDRg_-1hA+RzYnL0RtzqbMsLbY=yTUxGRA@mail.gmail.com>
 <20170621203824.719ffdc5@roar.ozlabs.ibm.com> <CAK8P3a1o91guXimc99sY3UOUjKTX5QxhQyOfY+j-x7MMCdRbdw@mail.gmail.com>
 <20170621211002.44525d9b@roar.ozlabs.ibm.com> <CAK8P3a2A9fMrNZPWJft2t+52kmGkGgm3gv_fxJntjevWtJ69Zw@mail.gmail.com>
 <20170621220213.2b33d56d@roar.ozlabs.ibm.com> <CAK8P3a0nVPz=eLV8ET6BYR2Qs0H3PQZuhYsu4Cb_kJSPACrR9w@mail.gmail.com>
 <20170621161913.GY4493@codeaurora.org> <20170622040838.1c63ebb7@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35600 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdFUUzH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2017 16:55:07 -0400
In-Reply-To: <20170622040838.1c63ebb7@roar.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, kbuild test robot <fengguang.wu@intel.com>, Josh Triplett <josh@joshtriplett.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>

On Wed, Jun 21, 2017 at 8:08 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> On Wed, 21 Jun 2017 09:19:13 -0700
> Stephen Boyd <sboyd@codeaurora.org> wrote:
>> On 06/21, Arnd Bergmann wrote:
>>
>> Ok. Can you send a revert patch to the list with some information
>> on why we can't do the hack anymore and also Cc lkml/kbuild
>> lists? The commit is in linux-next now as commit 06e226c7fb23
>> (clk: sunxi-ng: Move all clock types to a library, 2017-06-02).
>>
>
> I grabbed this patch and applied it to the kbuid/thin-ac tree. I tested
> with thin archives enabled and disabled with arm defconfig which ends up
> setting CONFIG_SUNXI_CCU=3Dy.
>
> The patch makes no difference to vmlinux size whether using traditional
> incremental link, or thin archives (there is a small difference between
> inclink and thinarc but that's unrelated).
>
> So this thin archives change does not break your patch, it's just that
> it doesn't really do the right thing. I like the general idea, but we
> need to work out how to make it properly supported by the build system.
>
> With the patch applied, this is what the build system currently does:
>
> arm-linux-gnueabihf-ld -EL    -r -o drivers/clk/sunxi-ng/built-in.o drive=
rs/clk/sunxi-ng/ccu-sun5i.o drivers/clk/sunxi-ng/ccu-sun6i-a31.o drivers/cl=
k/sunxi-ng/ccu-sun8i-a23.o drivers/clk/sunxi-ng/ccu-sun8i-a33.o drivers/clk=
/sunxi-ng/ccu-sun8i-h3.o drivers/clk/sunxi-ng/ccu-sun8i-v3s.o drivers/clk/s=
unxi-ng/ccu-sun8i-r.o drivers/clk/sunxi-ng/ccu-sun9i-a80.o drivers/clk/sunx=
i-ng/ccu-sun9i-a80-de.o drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.o drivers/cl=
k/sunxi-ng/lib.a drivers/clk/sunxi-ng/lib-ksyms.o
>
> This incremental link pulls in all your lib.a objects and links them
> into built-in.o. They can no longer be selectively linked.

I think the ARM defconfig actually needs all those objects because it
enables all the high-level drivers. You could try disabling e.g. all except
CONFIG_SUN8I_DE2_CCU if you want the objects to actually becomes
unused.

       Arnd

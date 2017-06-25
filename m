From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 1/5] kbuild: thin archives final link close
 --whole-archives option
Date: Sun, 25 Jun 2017 12:55:12 +0900
Message-ID: <CAK7LNATajsaJxFs9tzvKCz53ZoY7cymbA5f0yCYHXjBgB8+ciA@mail.gmail.com>
References: <20170621211002.44525d9b@roar.ozlabs.ibm.com> <CAK8P3a2A9fMrNZPWJft2t+52kmGkGgm3gv_fxJntjevWtJ69Zw@mail.gmail.com>
 <20170621220213.2b33d56d@roar.ozlabs.ibm.com> <CAK8P3a0nVPz=eLV8ET6BYR2Qs0H3PQZuhYsu4Cb_kJSPACrR9w@mail.gmail.com>
 <20170621161913.GY4493@codeaurora.org> <20170622040838.1c63ebb7@roar.ozlabs.ibm.com>
 <CAK8P3a2vV10+ymS7vHybfhRf_DVvACOW4O2OZzyz+v75y2Ak4w@mail.gmail.com>
 <20170622061838.ljlmk4enzpvdlyyu@flea.lan> <20170623015021.58f74316@roar.ozlabs.ibm.com>
 <CAK7LNATbd5n2uMsTN_jaUN+QjpB5DN3AvS+6iqqt3w3kuwQS3A@mail.gmail.com>
 <20170623145734.7pv3rdgucveg66s3@flea.lan> <CAK8P3a1m9teuQV-r5-753FBVtFTDsz=31bC_zeuCZ5ViBTQKRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a1m9teuQV-r5-753FBVtFTDsz=31bC_zeuCZ5ViBTQKRw@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Nicholas Piggin <npiggin@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, kbuild test robot <fengguang.wu@intel.com>, Josh Triplett <josh@joshtriplett.org>, Nicolas Pitre <nicolas.pitre@linaro.org>
List-Id: linux-arch.vger.kernel.org

2017-06-24 0:04 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Fri, Jun 23, 2017 at 4:57 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
>> On Fri, Jun 23, 2017 at 02:31:40PM +0900, Masahiro Yamada wrote:
>>> As far as I tried,  minus MACH_SUN8I still enabled the following:
>>> CONFIG_SUNXI_CCU=y
>>> CONFIG_SUNXI_CCU_DIV=y
>>> CONFIG_SUNXI_CCU_FRAC=y
>>> CONFIG_SUNXI_CCU_GATE=y
>>> CONFIG_SUNXI_CCU_MUX=y
>>> CONFIG_SUNXI_CCU_MULT=y
>>> CONFIG_SUNXI_CCU_PHASE=y
>>> CONFIG_SUNXI_CCU_NK=y
>>> CONFIG_SUNXI_CCU_NKM=y
>>> CONFIG_SUNXI_CCU_NKMP=y
>>> CONFIG_SUNXI_CCU_NM=y
>>> CONFIG_SUNXI_CCU_MP=y
>>>
>>> I think you need to disable some more MACH_SUN*I and
>>> perhaps disable some CONFIG_SUN*I_*_CCU explicitly,
>>> then you will see difference in the result.
>>
>> Ah, right, it's all selected by the rest.
>>
>> I guess to get a meaningful example you could disable all the
>> SUN*I_CCU (SUN5I, SUN8I, and the likes) options and while keeping
>> SUN8I_R_CCU.
>>
>> Most of the clock types shouldn't be used but div and gates.
>
> Given that we appear to basically always pull in all (or most) of
> the CCU parts anyway, and it's hard to even test with a subset
> being disabled, I wonder how much we care about dropping
> the unused objects at all:
>
> Maybe the answer is that we just always build all of them into
> the kernel and make only the SoC-specific objects configurable ;-)
>
> Once we start linking with  --gc-sections, it will all be fine anyway.
>

I agree!




-- 
Best Regards
Masahiro Yamada

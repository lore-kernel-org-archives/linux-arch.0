From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 05/12] m68k: move exports to definitions
Date: Mon, 1 Feb 2016 14:30:16 +0100
Message-ID: <CAMuHMdUUecCdGcK5FxL6e2FeD6-gyoWkbC_+RZzzb_mzHrcGyg@mail.gmail.com>
References: <20160129191744.GB17997@ZenIV.linux.org.uk>
	<1454095114-4128-5-git-send-email-viro@ZenIV.linux.org.uk>
	<CAMuHMdXTu9t9Jnd4F2X=U16X9psF-_oxj5Oxd6tz9wnK+BY2sQ@mail.gmail.com>
	<20160201121834.GJ17997@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20160201121834.GJ17997@ZenIV.linux.org.uk>
Sender: linux-kbuild-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi Al,

On Mon, Feb 1, 2016 at 1:18 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Mon, Feb 01, 2016 at 11:52:27AM +0100, Geert Uytterhoeven wrote:
>> On Fri, Jan 29, 2016 at 8:18 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>> > From: Al Viro <viro@zeniv.linux.org.uk>
>> >
>> > the rest of architectures should just use generic-y += export.h in
>> > asm/Kbuild
>> >
>> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>>
>> Looks good, and (some of, not all) the symbols end up in kstrtab, so
>>
>> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>
>> Note that none of the m68k defconfigs build modules that refer to these
>> symbols. This changes completely with allmodconfig, which adds lots of
>> references in many of the same modules.
>> CONFIG_LBDAF=y is set in the defconfigs.
>>
>> Unfortunately I haven't managed to boot a kernel that uses these symbols
>> in modules...
>
> Details, please...  Which symbols are missing?

The kernel has all the *di3 variants:

002eae2c T __ashldi3
002eae70 T __ashrdi3
002eaebc T __lshrdi3
002eaf00 T __muldi3
0038a6d0 R __ksymtab___ashldi3
0038a6d8 R __ksymtab___ashrdi3
0038ab68 R __ksymtab___lshrdi3
0038ab90 R __ksymtab___muldi3
003a8a5a r __kstrtab___ashldi3
003a8a64 r __kstrtab___ashrdi3
003a8a6e r __kstrtab___lshrdi3
003a8a78 r __kstrtab___muldi3

Hence the *si3 are missing:

__divsi3
__modsi3
__mulsi3
__udivsi3
__umodsi3

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

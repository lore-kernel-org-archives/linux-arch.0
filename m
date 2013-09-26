From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 2/8] um: Do not use SUBARCH
Date: Thu, 26 Sep 2013 16:24:44 +0200
Message-ID: <524443AC.3040409@nod.at>
References: <1377073172-3662-1-git-send-email-richard@nod.at> <1377073172-3662-3-git-send-email-richard@nod.at> <CALkWK0kCrQ9hPABD_XQ9QFG-vByP+xZWZs+RkVK77+cX7Odz7g@mail.gmail.com> <52441025.9030308@nod.at> <CALkWK0k5neR50h+AWEF5AgnpbgWMitZUnbv_caVzt6HiUA6mXg@mail.gmail.com> <52441407.9010603@nod.at> <CALkWK0=FG4COEjv5+mu1JRiiFQ2k6vop1mhFPmAT4bjtYeK6nA@mail.gmail.com> <52442108.1020304@nod.at> <CALkWK0nm=9n7DiV0MaGKVLMs=vxAiiQUx=OFuOg-DinkdMej5A@mail.gmail.com> <CALkWK0ndMtyQxE0uK4H-Ly6oy+tRn-SFc=_1WoC2QAp2uy0dtw@mail.gmail.com> <CAMuHMdU3LdDhbp_AKjD7b8Wytbqfp29DrPwTdtwQa2hUNdcy3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdU3LdDhbp_AKjD7b8Wytbqfp29DrPwTdtwQa2hUNdcy3Q@mail.gmail.com>
Sender: linux-m68k-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, Linux-Arch <linux-arch@vger.kernel.org>, Michal Marek <mmarek@suse.cz>, Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>, Jeff Dike <jdike@addtoit.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, Linux-sh list <linux-sh@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
List-Id: linux-arch.vger.kernel.org

Am 26.09.2013 15:26, schrieb Geert Uytterhoeven:
> On Thu, Sep 26, 2013 at 3:13 PM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>> Ramkumar Ramachandra wrote:
>>> Richard Weinberger wrote:
>>>> I told you already that "make defconfig ARCH=um SUBARCH=x86" will spuriously
>>>> create a x86_64 config on x86_64.
>>>> This breaks existing setups.
>>>
>>> I'll fix this and resubmit soon.
>>
>> Wait a minute. You're now arguing about whether the generic "x86"
>> means i386 or x86_64. Its meaning is already defined in
>> arch/x86/Kconfig and arch/x86/um/Kconfig: see the config 64BIT. Unless
>> i386 is explicitly specified, the default is to build a 64-bit kernel.
>> That is already defined for a normal Linux kernel, and user-mode Linux
>> should not break that convention. So, in the example you pulled out of
>> your hat:
>>
>>   $ make defconfig ARCH=um SUBARCH=x86
>>
>> the user should expect a 64-bit build, and not an i386 build as you
>> say. Both my patches are correct, and the "regression" that you
>> pointed out is a red herring.
> 
> Sorry for chiming in, but... what about cross compiling?
> SUBARCH=x86 should give you a 32-bit ia32 kernel, right?

Correct.
Users expect from SUBARCH=x86 a i386 32bit UML kernel.

Thanks,
//richard

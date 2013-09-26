From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 2/8] um: Do not use SUBARCH
Date: Thu, 26 Sep 2013 17:04:13 +0200
Message-ID: <52444CED.40401@nod.at>
References: <1377073172-3662-1-git-send-email-richard@nod.at> <1377073172-3662-3-git-send-email-richard@nod.at> <CALkWK0kCrQ9hPABD_XQ9QFG-vByP+xZWZs+RkVK77+cX7Odz7g@mail.gmail.com> <52441025.9030308@nod.at> <CALkWK0k5neR50h+AWEF5AgnpbgWMitZUnbv_caVzt6HiUA6mXg@mail.gmail.com> <52441407.9010603@nod.at> <CALkWK0=FG4COEjv5+mu1JRiiFQ2k6vop1mhFPmAT4bjtYeK6nA@mail.gmail.com> <52442108.1020304@nod.at> <CALkWK0nm=9n7DiV0MaGKVLMs=vxAiiQUx=OFuOg-DinkdMej5A@mail.gmail.com> <CALkWK0ndMtyQxE0uK4H-Ly6oy+tRn-SFc=_1WoC2QAp2uy0dtw@mail.gmail.com> <CAMuHMdU3LdDhbp_AKjD7b8Wytbqfp29DrPwTdtwQa2hUNdcy3Q@mail.gmail.com> <524443AC.3040409@nod.at> <CALkWK0kcd03t9W4O24wiVBQ8SZQ8ZcrbvQaUkcCm+y5n=d1wPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CALkWK0kcd03t9W4O24wiVBQ8SZQ8ZcrbvQaUkcCm+y5n=d1wPw@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux-Arch <linux-arch@vger.kernel.org>, Michal Marek <mmarek@suse.cz>, Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>, Jeff Dike <jdike@addtoit.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, Linux-sh list <linux-sh@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
List-Id: linux-arch.vger.kernel.org

Am 26.09.2013 16:36, schrieb Ramkumar Ramachandra:
> Richard Weinberger wrote:
>>> Sorry for chiming in, but... what about cross compiling?
>>> SUBARCH=x86 should give you a 32-bit ia32 kernel, right?
>>
>> Correct.
>> Users expect from SUBARCH=x86 a i386 32bit UML kernel.
> 
> This is an insane expectation. This is kernel convention (it has
> nothing to do with uml):

Hmm, looks like I missed commit ffee0de411, thanks for pointing that out.
Before ffee0de411 "make defconfig ARCH=x86" produced a 32bit defconfig.
Now it produces a x86_64 defconfig.

As UML is a variant of x86 it makes not much sense to do things the other
way around even if we break assumptions.

And, of course, this makes your patch valid.
Can you also please ensure that your new defconfigs are minimal?
See make savedefconfig.

Thanks,
//richard


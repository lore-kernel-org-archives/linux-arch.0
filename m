From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 2/8] um: Do not use SUBARCH
Date: Thu, 26 Sep 2013 15:56:07 +0200
Message-ID: <6ca106c1-3ba4-4d49-97ad-9f400045dd2c@email.android.com>
References: <1377073172-3662-1-git-send-email-richard@nod.at>
	<1377073172-3662-3-git-send-email-richard@nod.at>
	<CALkWK0kCrQ9hPABD_XQ9QFG-vByP+xZWZs+RkVK77+cX7Odz7g@mail.gmail.com>
	<52441025.9030308@nod.at>
	<CALkWK0k5neR50h+AWEF5AgnpbgWMitZUnbv_caVzt6HiUA6mXg@mail.gmail.com>
	<52441407.9010603@nod.at>
	<CALkWK0=FG4COEjv5+mu1JRiiFQ2k6vop1mhFPmAT4bjtYeK6nA@mail.gmail.com>
	<52442108.1020304@nod.at>
	<CALkWK0nm=9n7DiV0MaGKVLMs=vxAiiQUx=OFuOg-DinkdMej5A@mail.gmail.com>
	<CALkWK0ndMtyQxE0uK4H-Ly6oy+tRn-SFc=_1WoC2QAp2uy0dtw@mail.gmail.com>
	<CAMuHMdU3LdDhbp_AKjD7b8Wytbqfp29DrPwTdtwQa2hUNdcy3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0116695874985918407=="
Return-path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
In-Reply-To: <CAMuHMdU3LdDhbp_AKjD7b8Wytbqfp29DrPwTdtwQa2hUNdcy3Q@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <geert@linux-m68k.org>, Ramkumar Ramachandra <artagnon@gmail.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Michal Marek <mmarek@suse.cz>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, linux-kbuild <linux-kbuild@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Paul Mundt <lethal@linux-sh.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-arch.vger.kernel.org

--===============0116695874985918407==
Content-Type: multipart/alternative;
	boundary="----5QY7030VZWCJNE5X8N17B2HC1XHSHG"

------5QY7030VZWCJNE5X8N17B2HC1XHSHG
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit

Correct. Users expect Form SUBARCH=x86 a 32bit kernel.



Geert Uytterhoeven <geert@linux-m68k.org> schrieb:

>On Thu, Sep 26, 2013 at 3:13 PM, Ramkumar Ramachandra
><artagnon@gmail.com> wrote:
>> Ramkumar Ramachandra wrote:
>>> Richard Weinberger wrote:
>>>> I told you already that "make defconfig ARCH=um SUBARCH=x86" will
>spuriously
>>>> create a x86_64 config on x86_64.
>>>> This breaks existing setups.
>>>
>>> I'll fix this and resubmit soon.
>>
>> Wait a minute. You're now arguing about whether the generic "x86"
>> means i386 or x86_64. Its meaning is already defined in
>> arch/x86/Kconfig and arch/x86/um/Kconfig: see the config 64BIT.
>Unless
>> i386 is explicitly specified, the default is to build a 64-bit
>kernel.
>> That is already defined for a normal Linux kernel, and user-mode
>Linux
>> should not break that convention. So, in the example you pulled out
>of
>> your hat:
>>
>>   $ make defconfig ARCH=um SUBARCH=x86
>>
>> the user should expect a 64-bit build, and not an i386 build as you
>> say. Both my patches are correct, and the "regression" that you
>> pointed out is a red herring.
>
>Sorry for chiming in, but... what about cross compiling?
>SUBARCH=x86 should give you a 32-bit ia32 kernel, right?
>
>Gr{oetje,eeting}s,
>
>                        Geert
>
>--
>Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
>geert@linux-m68k.org
>
>In personal conversations with technical people, I call myself a
>hacker. But
>when I'm talking to journalists I just say "programmer" or something
>like that.
>                                -- Linus Torvalds

-- 
Diese Nachricht wurde von meinem Android-Mobiltelefon mit K-9 Mail gesendet.
------5QY7030VZWCJNE5X8N17B2HC1XHSHG
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head/><body><html><head></head><body>Correct. Users expect Form SUBARCH=x86 a 32bit kernel.<br><br><div class="gmail_quote"><br>
<br>
Geert Uytterhoeven &lt;geert@linux-m68k.org&gt; schrieb:<blockquote class="gmail_quote" style="margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<pre style="white-space: pre-wrap; word-wrap:break-word; font-family: sans-serif; margin-top: 0px">On Thu, Sep 26, 2013 at 3:13 PM, Ramkumar Ramachandra<br />&lt;artagnon@gmail.com&gt; wrote:<br /><blockquote class="gmail_quote" style="margin: 0pt 0pt 1ex 0.8ex; border-left: 1px solid #729fcf; padding-left: 1ex;">Ramkumar Ramachandra wrote:<br /><blockquote class="gmail_quote" style="margin: 0pt 0pt 1ex 0.8ex; border-left: 1px solid #ad7fa8; padding-left: 1ex;">Richard Weinberger wrote:<br /><blockquote class="gmail_quote" style="margin: 0pt 0pt 1ex 0.8ex; border-left: 1px solid #8ae234; padding-left: 1ex;">I told you already that "make defconfig ARCH=um SUBARCH=x86" will spuriously<br />create a x86_64 config on x86_64.<br />This breaks existing setups.</blockquote><br />I'll fix this and
  resubmit soon.</blockquote><br />Wait a minute. You're now arguing about whether the generic "x86"<br />means i386 or x86_64. Its meaning is already defined in<br />arch/x86/Kconfig and
arch/x86/um/Kconfig: see the config 64BIT. Unless<br />i386 is explicitly specified, the default is to build a 64-bit kernel.<br />That is already defined for a normal Linux kernel, and user-mode Linux<br />should not break that convention. So, in the example you pulled out of<br />your hat:<br /><br />$ make defconfig ARCH=um SUBARCH=x86<br /><br />the user should expect a 64-bit build, and not an i386 build as you<br />say. Both my patches are correct, and the "regression" that you<br />pointed out is a red herring.</blockquote><br />Sorry for chiming in, but... what about cross compiling?<br />SUBARCH=x86 should give you a 32-bit ia32 kernel, right?<br /><br />Gr{oetje,eeting}s,<br /><br />Geert<br /><br />--<br />Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6
 8k.org<br /><br />In personal conversations with technical people, I call myself a hacker. But<br />when I'm talking to journalists I just say "programmer" or something like that.<br />-- Linus
Torvalds<br /></pre></blockquote></div><br>
-- <br>
Diese Nachricht wurde von meinem Android-Mobiltelefon mit K-9 Mail gesendet.</body></html></body></html>
------5QY7030VZWCJNE5X8N17B2HC1XHSHG--



--===============0116695874985918407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60133471&iu=/4140/ostg.clktrk
--===============0116695874985918407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0116695874985918407==--

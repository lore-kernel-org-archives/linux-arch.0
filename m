From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [linux-review:James-Hogan/kbuild-Remove-stale-asm-generic-wrappers/20160119-183642]
 d979f99e9cc14e2667e9b6e268db695977e4197a BUILD DONE
Date: Fri, 29 Jan 2016 09:01:31 +0100
Message-ID: <CAMuHMdX33SQe8n7SRda0TjQV05yP1zbuw129Jqjknt8=CY=LjA@mail.gmail.com>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com>
	<20160128031435.GA25625@wfg-t540p.sh.intel.com>
	<20160128174241.GN10826@n2100.arm.linux.org.uk>
	<7619136.niuXthzi6R@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:34377 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbcA2IBb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2016 03:01:31 -0500
In-Reply-To: <7619136.niuXthzi6R@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Fengguang Wu <fengguang.wu@intel.com>, Linux-Arch <linux-arch@vger.kernel.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, James Hogan <james.hogan@imgtec.com>, Paul Burton <paul.burton@imgtec.com>, linux-kbuild <linux-kbuild@vger.kernel.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Florian Fainelli <f.fainelli@gmail.com>, Michal Marek <mmarek@suse.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Arnd,

On Fri, Jan 29, 2016 at 12:07 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> The other related issue is the DEBUG_UART_{VIRT,PHYS} setting,
> where there is no safe platform-specific default. I have two
> ideas for working around that, maybe one of them sounds ok to
> you:
>
> a) find a way to warn and/or disable DEBUG_LL when no address
>    is set, rather than failing the build
>
> b) add 'default 0 if COMPILE_TEST' to make it harder to get this
>    wrong by accident (hopefully nobody tries to run a COMPILE_TEST
>    kernel). Also maybe add a #warning if DEBUG_UART_VIRT is

Make sure to add it at the end of the list, so enabling COMPILE_TEST in a
working .config should give another working .config.

Perhaps you can use 0xdeadbeef instead of 0, and add

    #if DEBUG_UART_PHYS == 0xdeadbeed
    #warning Broken value of DEBUG_UART_PHYS.
    #endif

somewhere?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v9 11/17] h8300: clock driver
Date: Tue, 28 Apr 2015 12:03:52 +0200
Message-ID: <CAMuHMdX=iSswkP_z8MOEwLbLTO00ZsCXCPDE1C6GKZZAo4Y+6A@mail.gmail.com>
References: <1430112924-1134-1-git-send-email-ysato@users.sourceforge.jp>
	<1430112924-1134-12-git-send-email-ysato@users.sourceforge.jp>
	<2321574.fdIMjhZdv2@wuerfel>
	<87bni8vb9i.wl-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:36514 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933000AbbD1KDx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 28 Apr 2015 06:03:53 -0400
In-Reply-To: <87bni8vb9i.wl-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

Hi Sato-san,

On Tue, Apr 28, 2015 at 11:43 AM, Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
>> Clock drivers are generally not 'platform_drivers'. Please do one of two
>> things:
>>
>> a) use CLK_OF_DECLARE() to register a probe function, and use a device
>>    tree for describing your hardware
>>
>> b) rename clk_probe() to h8300_clk_init() and just call that function
>>    from the architecture code.
>>
>
> OK.
> I'll think of "a".

Which is not an option if you want to postpone DT support...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

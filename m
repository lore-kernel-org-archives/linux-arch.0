From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] ARC: add negative dependency for VGA_CONSOLE
Date: Tue, 25 Aug 2015 07:47:44 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075CFB85748@IN01WEMBXB.internal.synopsys.com>
References: <1439826777-11489-1-git-send-email-yuriy.kolerov@synopsys.com>
 <CAMuHMdW0hzGN74pCRhCUwJ0Ua3YN94csFfu3Mb-STeCuLosoGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Yuriy Kolerov <yuriy.kolerov@synopsys.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "Anton.Kolesov@synopsys.com" <Anton.Kolesov@synopsys.com>, Francois Bedard <Francois.Bedard@synopsys.com>
List-Id: linux-arch.vger.kernel.org

On Monday 17 August 2015 09:51 PM, Geert Uytterhoeven wrote:
> On Mon, Aug 17, 2015 at 5:52 PM, Yuriy Kolerov
> <yuriy.kolerov@synopsys.com> wrote:
>> Architectures which support VGA console must define screen_info
>> structurture from "uapi/linux/screen_info.h". Otherwise undefined
>> symbol error occurs. Usually it's defined in "setup.c" for each
>> architecture.
>>
>> If an architecture does not support VGA console (ARC's case)
>> there are 2 ways: define a dummy instance of screen_info or add
>> a negative dependency for VGA_CONSOLE in to prevent selecting
>> this option.
>>
>> I've implemented the second way. However the best solution is to
>> add HAVE_VGA_CONSOLE option for targets which support VGA
>> console. Then turn off VGA_CONSOLE by default and add dependency
>> to HAVE_VGA_CONSOLE. But right now it's better to just add a
>> negative dependency for ARC and then consider how to collaborate
>> about this issue with maintainers of other architectures.
> +1
>
>> Signed-off-by: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Hi Tomi,

Is anything else needed for this to be merged.

Thx,
-Vineet

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
>

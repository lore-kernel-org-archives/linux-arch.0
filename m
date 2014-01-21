From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 73/73] include: remove needless instances of <linux/init.h>
Date: Tue, 21 Jan 2014 22:37:45 +0100
Message-ID: <CAMuHMdX+H-jqmpUt+E6_-pSnFFboS0FPNai+0oBQpJz9qOzJYQ@mail.gmail.com>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
	<1390339396-3479-74-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:37013 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754956AbaAUVhq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jan 2014 16:37:46 -0500
In-Reply-To: <1390339396-3479-74-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On Tue, Jan 21, 2014 at 10:23 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> diff --git a/include/linux/zorro.h b/include/linux/zorro.h
> index 63fbba0..529604b 100644
> --- a/include/linux/zorro.h
> +++ b/include/linux/zorro.h
> @@ -15,7 +15,6 @@
>  #include <uapi/linux/zorro.h>
>
>  #include <linux/device.h>
> -#include <linux/init.h>
>  #include <linux/ioport.h>
>  #include <linux/mod_devicetable.h>

There's an __initdata below in that file:

extern struct zorro_dev_init zorro_autocon_init[ZORRO_NUM_AUTO] __initdata;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

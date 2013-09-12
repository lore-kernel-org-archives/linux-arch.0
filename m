From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] xtensa: define NO_IRQ as 0, remove other definitions
Date: Thu, 12 Sep 2013 09:26:20 +0200
Message-ID: <CAMuHMdVko5v2vma+spq_XhzaESVNOT5PdBgmEgFZQhRXamNhmw@mail.gmail.com>
References: <1378970254-29094-1-git-send-email-jcmvbkbc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:63754 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599Ab3ILH0U (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 12 Sep 2013 03:26:20 -0400
Received: by mail-ie0-f182.google.com with SMTP id aq17so21749115iec.13
        for <linux-arch@vger.kernel.org>; Thu, 12 Sep 2013 00:26:20 -0700 (PDT)
In-Reply-To: <1378970254-29094-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@tensilica.com>, Baruch Siach <baruch@tkos.co.il>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, Linux-Arch <linux-arch@vger.kernel.org>

On Thu, Sep 12, 2013 at 9:17 AM, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> sound/soc/fsl/fsl_ssi.c: In function 'fsl_ssi_probe':
> sound/soc/fsl/fsl_ssi.c:939:26: error: 'NO_IRQ' undeclared (first use in this function)
>
> Previous definitions (-1) were correct when used as a hardware IRQ number,
> but are incorrect as a mapped IRQ number.
>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  arch/xtensa/include/asm/irq.h                      |    4 ++++
>  .../platforms/xtfpga/include/platform/hardware.h   |    4 ----
>  arch/xtensa/variants/s6000/include/variant/irq.h   |    1 -
>  3 files changed, 4 insertions(+), 5 deletions(-)

Shouldn't sound/soc/fsl/fsl_ssi.c be changed instead:

-if (ssi_private->irq == NO_IRQ) {
+if (!ssi_private->irq) {

Cfr. the thread https://lkml.org/lkml/2013/7/25/642

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

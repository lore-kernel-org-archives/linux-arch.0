Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua1-f68.google.com ([209.85.222.68]:32908 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbfEVNsh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 09:48:37 -0400
Received: by mail-ua1-f68.google.com with SMTP id 49so886976uas.0
        for <linux-arch@vger.kernel.org>; Wed, 22 May 2019 06:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190522132754.46640-1-vincenzo.frascino@arm.com>
In-Reply-To: <20190522132754.46640-1-vincenzo.frascino@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 22 May 2019 15:48:22 +0200
Message-ID: <CAMuHMdXoUWHk-RvgwbDc0YZ+KnBSaL+1XE2n134oAVR7Y5jazg@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: Fix spdxcheck.py
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, jcline@redhat.com

Hi Vincenzo,

On Wed, May 22, 2019 at 3:28 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
> The LICENSE directory has recently changed structure and this makes
> spdxcheck fails as per below:
>
> FAIL: "Blob or Tree named 'other' not found"
> Traceback (most recent call last):
>   File "scripts/spdxcheck.py", line 240, in <module>
> spdx = read_spdxdata(repo)
>   File "scripts/spdxcheck.py", line 41, in read_spdxdata
> for el in lictree[d].traverse():
> [...]
> KeyError: "Blob or Tree named 'other' not found"
>
> Fix the script to restore the correctness on checkpatch License
> checking.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jeremy Cline <jcline@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Thanks for your patch!

Looks the issue is already fixed in linux-next:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/scripts/spdxcheck.py

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

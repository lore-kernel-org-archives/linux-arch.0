Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:38211 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752456AbeENVax (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 May 2018 17:30:53 -0400
Received: by mail-it0-f66.google.com with SMTP id q4-v6so14798656ite.3
        for <linux-arch@vger.kernel.org>; Mon, 14 May 2018 14:30:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMuHMdW0nxOmq7gjJiySg0fho2XDYkyrCgp88OOuULRLH+jt6w@mail.gmail.com>
References: <20180504195728.72932-1-maco@android.com> <201805060540.zjwonWcp%fengguang.wu@intel.com>
 <CAB0TPYG-Q6Ki_FMM1u+i_g+0ykQgeUTRpm00qycAUVQOqVH6eQ@mail.gmail.com>
 <20180514120338.GA5265@infradead.org> <CAMuHMdW0nxOmq7gjJiySg0fho2XDYkyrCgp88OOuULRLH+jt6w@mail.gmail.com>
From: Martijn Coenen <maco@android.com>
Date: Mon, 14 May 2018 23:30:52 +0200
Message-ID: <CAB0TPYG4Jg54Hg+BWwHqjgZWepxOmcBek=aa3rc=G_h5i=5jNg@mail.gmail.com>
Subject: Re: [PATCH] ANDROID: binder: remove 32-bit binder interface.
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@infradead.org>, kbuild test robot <lkp@intel.com>, Greg KH <gregkh@linuxfoundation.org>, kbuild-all@01.org, John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@google.com>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, Amit Pundir <amit.pundir@linaro.org>, Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>, "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>, Martijn Coenen <maco@google.com>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Linux-Arch <linux-arch@vger.kernel.org>
Message-ID: <20180514213052.NODsEkSAWrT0pCPF13oU9rYwjGxDDvQOE3aVZ4CxgWU@z>

On Mon, May 14, 2018 at 4:00 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Patch sent.

Thanks for the quick turn-around!

>
> BTW, sh also doesn't seem to have 64-bit get_user().
> There may be others.

I checked quickly, nios2 is the only other arch that explicitly
doesn't support it and would result in a build error; some other archs
don't define __get_user, but in that case they just fall back to
raw_copy_from_user().

>
> BTW2, does the Android Binder need to care about endianness when talking
> to userspace?

No, I don't think it should.

Thanks,
Martijn

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

Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:42413 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753635AbeENOAV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 May 2018 10:00:21 -0400
MIME-Version: 1.0
In-Reply-To: <20180514120338.GA5265@infradead.org>
References: <20180504195728.72932-1-maco@android.com> <201805060540.zjwonWcp%fengguang.wu@intel.com>
 <CAB0TPYG-Q6Ki_FMM1u+i_g+0ykQgeUTRpm00qycAUVQOqVH6eQ@mail.gmail.com> <20180514120338.GA5265@infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 May 2018 16:00:19 +0200
Message-ID: <CAMuHMdW0nxOmq7gjJiySg0fho2XDYkyrCgp88OOuULRLH+jt6w@mail.gmail.com>
Subject: Re: [PATCH] ANDROID: binder: remove 32-bit binder interface.
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Martijn Coenen <maco@android.com>, kbuild test robot <lkp@intel.com>, Greg KH <gregkh@linuxfoundation.org>, kbuild-all@01.org, John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@google.com>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, Amit Pundir <amit.pundir@linaro.org>, Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>, "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>, Martijn Coenen <maco@google.com>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Linux-Arch <linux-arch@vger.kernel.org>
Message-ID: <20180514140019.yKdo-3hMVJhj6OEtbqVsTG20Qp-UdiH0SJY5MK11vXQ@z>

Hi Christoph,

On Mon, May 14, 2018 at 2:03 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, May 11, 2018 at 09:57:52AM +0200, Martijn Coenen wrote:
>> On Sat, May 5, 2018 at 2:10 PM, kbuild test robot <lkp@intel.com> wrote:
>> >    drivers/android/binder.o: In function `binder_thread_write':
>> >>> binder.c:(.text+0x6a16): undefined reference to `__get_user_bad'
>>
>> Looks like m68k doesn't support 64-bit get_user(). I could just have
>> binder depend on !CONFIG_M68K, but there may be other architectures
>> still that don't support this. Another alternative would be to
>> whitelist the architectures Android supports - eg arm, arm64, x86,
>> x86_64. But I'm not sure if arch-limited drivers are considered bad
>> form. Does anybody have suggestions for how to deal with this?
>
> The proper fix is to just support 640bit get/put_user on m68k instead

I hope we'll never need 640bit support in {get,put}_user() ;-)

> of working around this.

Patch sent.

BTW, sh also doesn't seem to have 64-bit get_user().
There may be others.

BTW2, does the Android Binder need to care about endianness when talking
to userspace?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

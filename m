From: Martijn Coenen <maco@android.com>
Subject: Re: [PATCH] ANDROID: binder: remove 32-bit binder interface.
Date: Mon, 14 May 2018 23:30:52 +0200
Message-ID: <CAB0TPYG4Jg54Hg+BWwHqjgZWepxOmcBek=aa3rc=G_h5i=5jNg@mail.gmail.com>
References: <20180504195728.72932-1-maco@android.com>
 <201805060540.zjwonWcp%fengguang.wu@intel.com>
 <CAB0TPYG-Q6Ki_FMM1u+i_g+0ykQgeUTRpm00qycAUVQOqVH6eQ@mail.gmail.com>
 <20180514120338.GA5265@infradead.org>
 <CAMuHMdW0nxOmq7gjJiySg0fho2XDYkyrCgp88OOuULRLH+jt6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <CAMuHMdW0nxOmq7gjJiySg0fho2XDYkyrCgp88OOuULRLH+jt6w@mail.gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Amit Pundir <amit.pundir@linaro.org>, "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>, Arnd Bergmann <arnd@arndb.de>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Greg KH <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, Martijn Coenen <maco@google.com>, John Stultz <john.stultz@linaro.org>, kbuild-all@01.org, Linux-Arch <linux-arch@vger.kernel.org>, Todd Kjos <tkjos@google.com>
List-Id: linux-arch.vger.kernel.org

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

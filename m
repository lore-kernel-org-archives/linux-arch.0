From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 00/16] genrtc removal
Date: Thu, 28 Apr 2016 09:48:57 +0200
Message-ID: <CAMuHMdUcrB38jL1_estfq5aK55UFUeF=4JciVGFqcE17pY9X7g@mail.gmail.com>
References: <1461796470-1291527-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <1461796470-1291527-1-git-send-email-arnd@arndb.de>
Sender: linux-alpha-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Rich Felker <dalias@libc.org>, David Howells <dhowells@redhat.com>, alpha <linux-alpha@vger.kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Linux-sh list <linux-sh@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, RTCLINUX <rtc-linux@googlegroups.com>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Apr 28, 2016 at 12:34 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> I ended up stuffing the two patch series into one, as they are now
> more dependent on one another. This now thoroughly removes the
> genrtc driver including the asm/rtc.h headers it uses. For all
> architectures that still have a meaningful asm/rtc.h, this goes
> through two stages:
>
> 1) make the rtc-generic implementation independent of asm/rtc.h
> 2) remove the asm/rtc.h header and disallow the gen_rtc driver
>
> As the last step, the driver itself gets removed.

In general, after fixing the minor nit:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

For the m68k bits:
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

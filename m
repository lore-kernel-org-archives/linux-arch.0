From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC, PATCH, v3.9] default exported asm symbols to zero
Date: Fri, 2 Dec 2016 13:59:15 +0100
Message-ID: <CAMuHMdUMdxKHY0O=fVZgZ9Gtp7zvm=F2HR=AACYDM=8c7NpFUQ@mail.gmail.com>
References: <20161129131922.GA31466@angband.pl> <CA+55aFxg_s8k1LBmsXjpVYw=BKh8sNEuL3n6MhzZGTuUPKMOwg@mail.gmail.com>
 <14455987.OWjnZpEEup@wuerfel> <8452191.39CeLIHTBT@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <8452191.39CeLIHTBT@wuerfel>
Sender: linux-kbuild-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Ben Hutchings <ben@decadent.org.uk>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Modra <amodra@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Dec 2, 2016 at 1:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> With binutils-2.16 and before, a weak missing symbol was kept during the

2.26?

> final link, and a missing CRC for an export would lead to that CRC
> being treated as zero implicitly. With binutils-2.17, the crc

2.27?

> symbol gets dropped, and any module trying to use it will fail to
> load.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

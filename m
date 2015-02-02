From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Can this be a invalid memory access? (was: Re: [PATCH]
 spi/xilinx: Cast ioread32/iowrite32 function pointers)
Date: Mon, 2 Feb 2015 14:04:06 +0100
Message-ID: <CAMuHMdXsUZD5PW2AmCg-uFZRm5M5p9kFO6XyjKUbjrwN+BMTKw@mail.gmail.com>
References: <CAPybu_16LBPDjuhL-Vw-rqFK-13+gLHrRc-3KuYwUTi0XyDX7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPybu_16LBPDjuhL-Vw-rqFK-13+gLHrRc-3KuYwUTi0XyDX7Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux-Arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi Ricardo,

On Mon, Feb 2, 2015 at 1:49 PM, Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
> Regarding ioread8 et al.
>
> On include/asm-generic/io.h is defined as:
> extern unsigned int ioread8(void __iomem *);
>
> On include/asm-generic/io.h:
> static inline u8 ioread8(const volatile void __iomem *addr)
>
> Please ignore the qualifiers right now. The first function returns an
> unsigned integer, the second a u8.
>
> Through #ifdefs, different arches uses the first or the second definitions.
>
> If we consider this code:
>
> u8 varA;
> u8 varB;
> u8 varC;
> void * pvar=varB;

... = &varB;

> *pvar = ioread8(valid_memory);
>
> Depending if ioread8 returns a u8 or a unsigned int, aren't we also
> accessing varC?
>
> Could not this be a problem?

Please try to compile the above.
The compiler will tell you you cannot dereference a void pointer.

Now, replace "void *" by "unsigned int *".
After that, varC will indeed be overwritten. But the compiler will still have
warned you that you assigned the address of an u8 variable to an
unsigned int pointer.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

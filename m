From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [v2 PATCH 1/2] Add new uio device for dynamic memory allocation
Date: Sun, 4 Nov 2012 14:20:00 +0100
Message-ID: <CAMuHMdWKByLXR-2wkiej=F1WPf7xePf3nMkUqwSf_hEJNNZbvg@mail.gmail.com>
References: <1348553352-14334-1-git-send-email-dhobsong@igel.co.jp>
	<1348553352-14334-2-git-send-email-dhobsong@igel.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1348553352-14334-2-git-send-email-dhobsong@igel.co.jp>
Sender: linux-sh-owner@vger.kernel.org
To: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Cc: hjk@hansjkoch.de, gregkh@linuxfoundation.org, magnus.damm@gmail.com, horms@verge.net.au, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, hdk@igel.co.jp, Linux-Next <linux-next@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Sep 25, 2012 at 8:09 AM, Damian Hobson-Garcia
<dhobsong@igel.co.jp> wrote:
> are holding the device file open, the address returned to userspace i=
s
> DMA_ERROR_CODE.

Only a small subset of the architectures
(arm/ia64/microblaze/openrisc/powerpc/sparc/x86)
seem to define DMA_ERROR_CODE, causing everywhere else:

drivers/uio/uio_dmem_genirq.c: In function =E2=80=98uio_dmem_genirq_rel=
ease=E2=80=99:
drivers/uio/uio_dmem_genirq.c:95: error: =E2=80=98DMA_ERROR_CODE=E2=80=99=
 undeclared
(first use in this function)
drivers/uio/uio_dmem_genirq.c:95: error: (Each undeclared identifier
is reported only once
drivers/uio/uio_dmem_genirq.c:95: error: for each function it appears i=
n.)
drivers/uio/uio_dmem_genirq.c: In function =E2=80=98uio_dmem_genirq_pro=
be=E2=80=99:
drivers/uio/uio_dmem_genirq.c:238: error: =E2=80=98DMA_ERROR_CODE=E2=80=
=99 undeclared
(first use in this function)
make[1]: *** [drivers/uio/uio_dmem_genirq.o] Error 1
make: *** [drivers/uio/] Error 2

(e.g. http://kisskb.ellerman.id.au/kisskb/buildresult/7462173/)

=46urthermore, none of them define it in <uapi/...>, so DMA_ERROR_CODE =
is not
part of the userspace API (yet), while it is architecture-specific (som=
e use 0,
others ~0).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
                                -- Linus Torvalds

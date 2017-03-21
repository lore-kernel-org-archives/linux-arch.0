From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 2/4] asm-generic/io.h: Remove unused generic
 __ioremap() definition
Date: Tue, 21 Mar 2017 11:37:11 +0100
Message-ID: <CAMuHMdXzCPwijpHsvgHGDYRawF5paBxi4RNYPjxA8fRKOHQb0w@mail.gmail.com>
References: <20170320182014.4858.22352.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20170320184253.4858.12956.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:33121 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756186AbdCUKh2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2017 06:37:28 -0400
In-Reply-To: <20170320184253.4858.12956.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>, Linux-Arch <linux-arch@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>

Hi Bj=C3=B6rn,

On Mon, Mar 20, 2017 at 7:42 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Several arches use __ioremap() to help implement the generic ioremap(),
> ioremap_nocache(), and ioremap_wc() interfaces, but this usage is all
> inside the arch/ directory.
>
> The only __ioremap() uses outside arch/ are in the ZorroII RAM disk drive=
r
> and some framebuffer drivers that are only buildable on m68k and powerpc,
> and they use the versions provided by those arches.
>
> There's no need for a generic version of __ioremap(), so remove it.

These all predate the ioremap_*() variants, and can be converted to
either ioremap_nocache() or ioremap_wt().

However, PPC doesn't implement ioremap_wt() yet, so asm-generic will
fall back to the less-efficient nocache variant.
PPC does support __ioremap(..., _PAGE_WRITETHRU), so adding a wrapper
is trivial.

> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Regardless,
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

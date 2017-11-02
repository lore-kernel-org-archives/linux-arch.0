From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] kbuild: clean up *.dtb and *.dtb.S patterns from
 top-level Makefile
Date: Thu, 2 Nov 2017 10:08:58 +0100
Message-ID: <CAK8P3a0r=un9H8y2AizW3v5KzkTEGgb70hfBx8C88qphDjJksg@mail.gmail.com>
References: <1509591085-23940-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK8P3a3FoRJeO=TQGMRf6t4-bP8nP6KUEhkCrHP6L8XaF1Ee7g@mail.gmail.com> <bb7c1a637afa47e8943ce494798f957c@SOC-EX01V.e01.socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:54770 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752237AbdKBJI7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Nov 2017 05:08:59 -0400
In-Reply-To: <bb7c1a637afa47e8943ce494798f957c@SOC-EX01V.e01.socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: DTML <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Pantelis Antoniou <pantelis.antoniou@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Frank Rowand <frowand.list@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Thu, Nov 2, 2017 at 9:48 AM,  <yamada.masahiro@socionext.com> wrote:

>>       Arnd
>
> Yeah, I had also noticed this race problem on parallel building
> with CONFIG_OF_ALL_DTBS.
>
> I was planning to do it
> when I come up with a clean implementation.
>
> One idea is to handle dtb-y and CONFIG_OF_ALL_DTBS
> natively in scripts/Makefile.build or somewhere
> as scripts/Makefile.dtbinst already recognizes dtb-y as a special variable.

Ah, nice, that does sound better, yes.

      Arnd

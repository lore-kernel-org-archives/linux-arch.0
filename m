From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [PATCH 16/31] nds32: VDSO support
Date: Wed, 8 Nov 2017 12:14:12 -0800
Message-ID: <CABeXuvqvyeXYZMj05bfeKOgBK5i3mK6imsD2iNFfKES1kTjUng@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <0911917e908c7648d25b33663afc88f5aca6bb4d.1510118606.git.green.hu@gmail.com>
 <CAK8P3a2BDfCLg6J5qmAFD86ZoxzXLNrXO8UTfkvScws=R-T5jw@mail.gmail.com>
 <CABeXuvoJyQxXaCGyu-9fw-E32hHMgpZ0x1njbM1O5znCr1audA@mail.gmail.com> <CAK8P3a0HkSx6QsLuKk_7Ht+zDbt4bHv0Wk2SwN+eAo2O+_i+FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:48119 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752329AbdKHUON (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Nov 2017 15:14:13 -0500
In-Reply-To: <CAK8P3a0HkSx6QsLuKk_7Ht+zDbt4bHv0Wk2SwN+eAo2O+_i+FQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime Hu <green.hu@gmail.com>, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>, Palmer Dabbelt <palmer@dabbelt.com>

> Do applications call into the vdso directly and expect to get a timespec
> out? If they always go through the C library as an intermediate, then
> the glibc clock_gettime() could do the conversion.

It is recommended that applications do not call vdso symbols directly.
According to manpage:

"If you're trying to call the vDSO in your own application rather than
using the C library, you're most likely doing it wrong."

-Deepa

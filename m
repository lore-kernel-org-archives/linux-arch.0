Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:39898 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754902AbeARJ4z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jan 2018 04:56:55 -0500
MIME-Version: 1.0
In-Reply-To: <790e05e9b9675b3f6ef41693a794d1f09795c151.1515766253.git.green.hu@gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <790e05e9b9675b3f6ef41693a794d1f09795c151.1515766253.git.green.hu@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 18 Jan 2018 10:56:53 +0100
Message-ID: <CAK8P3a2qx5pZmE-=QM5Bwrsib4XcfVac7RQr-QMzEseQ_oBPEA@mail.gmail.com>
Subject: Re: [PATCH v6 03/36] sparc: io: To use the define of
 ioremap_[nocache|wc|wb] in asm-generic/io.h
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>, Randy Dunlap <rdunlap@infradead.org>, David Miller <davem@davemloft.net>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>
Message-ID: <20180118095653.XTfAmcI6eYTABioV3kNikw55ui1wk4euyuRVjvJfJvo@z>

On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote:
> From: Greentime Hu <greentime@andestech.com>
>
> It will be built failed if commit id: d25ea659 is selected. This patch
> can fix this build error.
>
> Signed-off-by: Greentime Hu <greentime@andestech.com>

The change is fine, but the reference to commit 'd25ea659' is not for
two reasons:

- when you rebase the tree, you will get a different ID
- the recommended format for referring to another commit is to list it with
  12 digits and the one-line summary like this:

   commit d25ea659bc37 ("asm-generic/io.h: move
  ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_=E2=80=A6")

- Ideally you use a 'Fixes:' tag in the patch description.

You can add these lines in your .gitconfig to help you here

[alias]
        fixes =3D show --format=3D'Fixes: %h (\"%s\")' -s
[core]
        abbrev =3D 12

That will give you a 'git fixes' command to output the Fixes: line
in the correct format for future bug fixes. For this particular change,
I would actually just merge the two patches into one patch that
then doesn't break anything in the first place.

      Arnd

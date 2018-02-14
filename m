From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v7 07/37] nds32: Kernel booting and initialization
Date: Wed, 14 Feb 2018 15:35:45 +0100
Message-ID: <CAK8P3a3yfdZOWsv59j2d=SW6Rbwz+wyoVYGUBvFDTyANvxKVFw@mail.gmail.com>
References: <cover.1518505384.git.greentime@andestech.com> <7fe1c8908c84b873c98947b31bcce92daea6d67f.1518505384.git.greentime@andestech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <7fe1c8908c84b873c98947b31bcce92daea6d67f.1518505384.git.greentime@andestech.com>
Sender: netdev-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.co>
List-Id: linux-arch.vger.kernel.org

On Tue, Feb 13, 2018 at 10:09 AM, Greentime Hu <green.hu@gmail.com> wrote:
> This patch includes the kernel startup code. It can get dtb pointer
> passed from bootloader. It will create a temp mapping by tlb
> instructions at beginning and goto start_kernel.
>
> Signed-off-by: Vincent Chen <vincentc@andestech.com>
> Signed-off-by: Greentime Hu <greentime@andestech.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

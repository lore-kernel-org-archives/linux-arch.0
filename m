From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v7 30/37] nds32: Build infrastructure
Date: Wed, 14 Feb 2018 15:34:22 +0100
Message-ID: <CAK8P3a0C+ib=xb9pbeb33y+DynNKs2HNM4EUrMBsZo+X+ymgMQ@mail.gmail.com>
References: <cover.1518505384.git.greentime@andestech.com> <5c26fda7b2ae143a0b14b18b66f5ddbc069b0a28.1518505384.git.greentime@andestech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5c26fda7b2ae143a0b14b18b66f5ddbc069b0a28.1518505384.git.greentime@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.co>
List-Id: linux-arch.vger.kernel.org

On Tue, Feb 13, 2018 at 10:09 AM, Greentime Hu <green.hu@gmail.com> wrote:
> This patch adds Makefile, Kconfig and vmlinux.lds.S files required for building
> an nds32 kernel.
>
> Signed-off-by: Vincent Chen <vincentc@andestech.com>
> Signed-off-by: Greentime Hu <greentime@andestech.com>

With the latest changes

Acked-by: Arnd Bergmann <arnd@arndb.de>

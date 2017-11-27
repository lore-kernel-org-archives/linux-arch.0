From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 24/35] nds32: defconfig
Date: Mon, 27 Nov 2017 15:27:24 +0100
Message-ID: <CAK8P3a01n6Buy24JWagJNL+Lauuk-RE=Ee2rxS0Cu33NP+oNEw@mail.gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <ba7df99550bdd5c06d01ef8f427d116280b8f52d.1511785528.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ba7df99550bdd5c06d01ef8f427d116280b8f52d.1511785528.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 27, 2017 at 1:28 PM, Greentime Hu <green.hu@gmail.com> wrote:

> +CONFIG_EXPERT=y

You normally shouldn't need CONFIG_EXPERT in a defconfig file, by definition
this is needed for unusual configurations only.

> +CONFIG_NDS32_BUILTIN_DTB="ae3xx"

Having a built-in DTB also makes no sense for a defconfig, when the idea is that
it can run on as many machines as possible.

> +CONFIG_BLK_DEV_LOOP=y
> +CONFIG_BLK_DEV_RAM=y
> +CONFIG_BLK_DEV_RAM_SIZE=8192

Having ramdisk built-in is rather unusual, most users don't use ramdisks
any more since we don't need it for booting with the initramfs.

> +CONFIG_BRIDGE=y
> +CONFIG_TUN=y

These also look unusual. Would it make sense to have these as loadable
modules, or do you require having everything built-in for your workflow?

> +CONFIG_SOUND=y
> +CONFIG_SND=y
> +# CONFIG_SND_SUPPORT_OLD_API is not set
> +# CONFIG_SND_VERBOSE_PROCFS is not set

It seems the sound subsystem is enabled, but no drivers are selected,
so it won't actually do anything.

> +# CONFIG_USB_SUPPORT is not set
> +CONFIG_MMC=y

Same for MMC. If you are still trying to get the respective device drivers
merged, that doesn't need to stop you from enabling the configurations
here.

       Arnd

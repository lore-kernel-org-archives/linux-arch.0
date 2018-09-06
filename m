From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3 02/26] csky: defconfig
Date: Thu, 6 Sep 2018 15:58:51 +0200
Message-ID: <CAK8P3a1obhCyZcY6D-X7_HnGnHCO3+srZQXniThiMNqvxLSQzA@mail.gmail.com>
References: <cover.1536138304.git.ren_guo@c-sky.com> <dc7a52f2c2571a85c87e163d49cecddd3c2f2430.1536138304.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <dc7a52f2c2571a85c87e163d49cecddd3c2f2430.1536138304.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 5, 2018 at 2:08 PM Guo Ren <ren_guo@c-sky.com> wrote:
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---
>  arch/csky/configs/defconfig | 76 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 arch/csky/configs/defconfig
>
> diff --git a/arch/csky/configs/defconfig b/arch/csky/configs/defconfig
> new file mode 100644
> index 0000000..c6a5a40
> --- /dev/null
> +++ b/arch/csky/configs/defconfig
> @@ -0,0 +1,76 @@
> +# CONFIG_LOCALVERSION_AUTO is not set
> +CONFIG_DEFAULT_HOSTNAME="csky"
> +# CONFIG_SWAP is not set
> +CONFIG_SYSVIPC=y
> +CONFIG_POSIX_MQUEUE=y
> +CONFIG_USELIB=y

CONFIG_USELIB seems misplaced here, very few architectures can even
call that, and it's not in the asm-generic/unistd.h file.

> +CONFIG_RELAY=y

relay is selected by drivers that need it, you should not need to turn
it on here.

> +CONFIG_SYSCTL_SYSCALL=y

Also not in the asm-generic syscall table. We should probably hide the
CONFIG_USELIB and CONFIG_SYSCTL_SYSCALL options so they
only appear on architectures that can use them (patches welcome).

> +CONFIG_KALLSYMS_ALL=y

While useful for debugging, this is also something I would not expect
in the defconfig file

> +CONFIG_USERFAULTFD=y

Probably not needed either, unless you have a specific use
case.

> +CONFIG_EMBEDDED=y

This (and CONFIG_EXPERT) is mostly there to expose options
that are otherwise hidden for good reasons. Is there any option
you tweak that depends on this? If not, then remove this as well.

> +CONFIG_PROFILING=y

This is only for oprofile, which new architectures should generally
no longer implement. Better implement PERF only.

> +CONFIG_BLK_DEV_INTEGRITY=y

This is also fairly unusual.

> +CONFIG_EXT2_FS=y
> +CONFIG_EXT2_FS_XATTR=y
> +CONFIG_EXT2_FS_POSIX_ACL=y
> +CONFIG_EXT2_FS_SECURITY=y
> +CONFIG_EXT3_FS=y
> +CONFIG_EXT3_FS_POSIX_ACL=y
> +CONFIG_EXT3_FS_SECURITY=y

Better enable only EXT4 and drop EXT2/EXT3.

> +CONFIG_UNUSED_SYMBOLS=y

You should only need this to work around bugs, so
I'd turn it off.

       Arnd

From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 03/17] base: fix order of OF initialization
Date: Wed, 7 Jun 2017 09:07:20 +0200
Message-ID: <CAMuHMdXWH5fU8YKfR37D5SMi1GpSk75Bq-OcYmm5ZuHe+XK0PQ@mail.gmail.com>
References: <20170523004107.536-1-palmer@dabbelt.com> <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-4-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170606230007.19101-4-palmer@dabbelt.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, albert@sifive.com, patches@groups.riscv.org, "Wesley W. Terpstra" <wesley@sifive.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

CC devicetree folks

On Wed, Jun 7, 2017 at 12:59 AM, Palmer Dabbelt <palmer@dabbelt.com> wrote:
> From: "Wesley W. Terpstra" <wesley@sifive.com>
>
> This fixes: [    0.010000] cpu cpu0: Error -2 creating of_node link
> ... which you get for every CPU on all architectures with a OF cpu/ node.
>
> This affects riscv, nios, etc.
>
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> ---
>  drivers/base/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/init.c b/drivers/base/init.c
> index 48c0e220acc0..0dcd17e561d0 100644
> --- a/drivers/base/init.c
> +++ b/drivers/base/init.c
> @@ -31,9 +31,9 @@ void __init driver_init(void)
>         /* These are also core pieces, but must come after the
>          * core core pieces.
>          */
> +       of_core_init();
>         platform_bus_init();
>         cpu_dev_init();
>         memory_dev_init();
>         container_dev_init();
> -       of_core_init();
>  }
> --
> 2.13.0

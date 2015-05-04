From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v10 04/19] sh-sci: Add H8/300 SCI.
Date: Mon, 4 May 2015 15:58:17 +0200
Message-ID: <CAMuHMdXK==yacRPHqZe3JqP83GPCk+TJsCH6OPETwcB8mOxNfw@mail.gmail.com>
References: <1430736122-20929-2-git-send-email-ysato@users.sourceforge.jp>
	<1430736122-20929-6-git-send-email-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:34428 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbbEDN6R (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 May 2015 09:58:17 -0400
In-Reply-To: <1430736122-20929-6-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

CC devicetree

On Mon, May 4, 2015 at 12:41 PM, Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> H8/300 internal serial controller of same as sh-sci.
> So h8300 use SH_SCI.
> And add sci bindings.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
>  Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 1 +
>  drivers/tty/serial/Kconfig                                      | 2 +-
>  drivers/tty/serial/sh-sci.c                                     | 6 ++++++
>  3 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> index ae73bb0..7534d46 100644
> --- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> +++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> @@ -29,6 +29,7 @@ Required properties:
>      - "renesas,scifa" for generic SCIFA compatible UART.
>      - "renesas,scifb" for generic SCIFB compatible UART.
>      - "renesas,hscif" for generic HSCIF compatible UART.
> +    - "renesas,sci" for generic SCI compatible UART.
>
>      When compatible with the generic version, nodes must list the
>      SoC-specific version corresponding to the platform first followed by the
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index f8120c1..dea1eff 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -728,7 +728,7 @@ config SERIAL_IP22_ZILOG_CONSOLE
>
>  config SERIAL_SH_SCI
>         tristate "SuperH SCI(F) serial port support"
> -       depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
> +       depends on SUPERH || ARCH_SHMOBILE || H8300 || COMPILE_TEST
>         select SERIAL_CORE
>
>  config SERIAL_SH_SCI_NR_UARTS
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index e7d6566..1468ec5 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -2536,6 +2536,12 @@ static const struct of_device_id of_sci_match[] = {
>                         .regtype = SCIx_HSCIF_REGTYPE,
>                 },
>         }, {
> +               .compatible = "renesas,sci",
> +               .data = &(const struct sci_port_info) {
> +                       .type = PORT_SCI,
> +                       .regtype = SCIx_SCI_REGTYPE,
> +               },
> +       }, {
>                 /* Terminator */
>         },
>  };
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

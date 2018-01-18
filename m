Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:44203 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754656AbeARLCU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jan 2018 06:02:20 -0500
MIME-Version: 1.0
In-Reply-To: <e9577ec0f6b6ca17077aa2f576c8bef191c3d7c2.1515766253.git.green.hu@gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <e9577ec0f6b6ca17077aa2f576c8bef191c3d7c2.1515766253.git.green.hu@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 18 Jan 2018 12:02:18 +0100
Message-ID: <CAK8P3a0HGhx3WpF-AwC+7m8+FoaiQBTYoCLqhECrATBRLX7x5g@mail.gmail.com>
Subject: Re: [PATCH v6 31/36] dt-bindings: nds32 CPU Bindings
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>, Randy Dunlap <rdunlap@infradead.org>, David Miller <davem@davemloft.net>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, Vincent Chen <vincentc@andestech.com>, Rick Chen <rick@andestech.com>, Zong Li <zong@andestech.com>
Message-ID: <20180118110218.uKi3DqZ0VnXXT3sLAWHQNJq2gfnYc5IZqq3bpW8UsIw@z>

On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote:
> From: Greentime Hu <greentime@andestech.com>
>
> This patch adds nds32 CPU binding documents.
>
> Signed-off-by: Vincent Chen <vincentc@andestech.com>
> Signed-off-by: Rick Chen <rick@andestech.com>
> Signed-off-by: Zong Li <zong@andestech.com>
> Signed-off-by: Greentime Hu <greentime@andestech.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/nds32/cpus.txt |   37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nds32/cpus.txt
>
> diff --git a/Documentation/devicetree/bindings/nds32/cpus.txt b/Documentation/devicetree/bindings/nds32/cpus.txt
> new file mode 100644
> index 0000000..9a52937
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nds32/cpus.txt
> @@ -0,0 +1,37 @@
> +* Andestech Processor Binding
> +
> +This binding specifies what properties must be available in the device tree
> +representation of a Andestech Processor Core, which is the root node in the
> +tree.
> +
> +Required properties:
> +
> +       - compatible:
> +               Usage: required
> +               Value type: <string>
> +               Definition: should be one of:
> +                       "andestech,n13"
> +                       "andestech,n15"
> +                       "andestech,d15"
> +                       "andestech,n10"
> +                       "andestech,d10"
> +                       "andestech,nds32v3"

Based on https://lkml.org/lkml/2017/11/27/1290, this should say that
the device tree should always list 'andestech,nds32v3' as the most
generic 'compatible' value and list exactly one of the others in
addition.

       Arnd

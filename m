From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 30/31] dt-bindings: nds32 CPU Bindings
Date: Wed, 8 Nov 2017 07:18:48 -0600
Message-ID: <CAL_JsqJAtTSGg=yGvANGdTCWa4tDAicvOvWYr4pK5M1rjPFtfg@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <1a8efba0727437d510d10755f3fcea806833651d.1510118606.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751674AbdKHNTK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Nov 2017 08:19:10 -0500
In-Reply-To: <1a8efba0727437d510d10755f3fcea806833651d.1510118606.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, netdev <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>, Rick Chen <rick@andestech.com>, Zong Li <zong@andestech.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Please Cc the DT list on bindings.

On Tue, Nov 7, 2017 at 11:55 PM, Greentime Hu <green.hu@gmail.com> wrote:
> From: Greentime Hu <greentime@andestech.com>

Commit message needed.

> Signed-off-by: Vincent Chen <vincentc@andestech.com>
> Signed-off-by: Rick Chen <rick@andestech.com>
> Signed-off-by: Zong Li <zong@andestech.com>
> Signed-off-by: Greentime Hu <greentime@andestech.com>
> ---
>  Documentation/devicetree/bindings/nds32/cpus.txt |   33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nds32/cpus.txt
>
> diff --git a/Documentation/devicetree/bindings/nds32/cpus.txt b/Documentation/devicetree/bindings/nds32/cpus.txt
> new file mode 100644
> index 0000000..97394cb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nds32/cpus.txt
> @@ -0,0 +1,33 @@
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

SMP supported for any of these?

> +
> +    - device_type
> +               Usage: required
> +               Value type: <string>
> +               Definition: must be "cpu"
> +
> +* Examples
> +
> +/ {
> +       cpus {
> +               cpu@0 {

Needs a reg property or drop the unit address.

> +                       device_type = "cpu";
> +                       compatible = "andestech,n13", "andestech,n15";

n13 is a superset of n15?

> +               };
> +       };
> +};
> --
> 1.7.9.5
>

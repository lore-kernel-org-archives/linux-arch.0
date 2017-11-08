From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 27/31] dt-bindings: interrupt-controller: Andestech
 Internal Vector Interrupt Controller
Date: Wed, 8 Nov 2017 07:25:10 -0600
Message-ID: <CAL_JsqLGQGZq9VYW2By84rf0BHPm4=QvKNts7ETCqVT3g7LA-w@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <a7b9f0a21bf6e0c3325a0d9a28a8503082cafd14.1510118606.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a7b9f0a21bf6e0c3325a0d9a28a8503082cafd14.1510118606.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, netdev <netdev@vger.kernel.org>, Rick Chen <rick@andestech.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

+DT list

On Tue, Nov 7, 2017 at 11:55 PM, Greentime Hu <green.hu@gmail.com> wrote:
> From: Greentime Hu <greentime@andestech.com>

Commit msg needed.

> Signed-off-by: Rick Chen <rick@andestech.com>
> Signed-off-by: Greentime Hu <greentime@andestech.com>
> ---
>  .../interrupt-controller/andestech,ativic32.txt    |   27 ++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt b/Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
> new file mode 100644
> index 0000000..6bac908
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
> @@ -0,0 +1,27 @@
> +* Andestech Internal Vector Interrupt Controller
> +
> +The Internal Vector Interrupt Controller (IVIC) is a basic interrupt controller
> +suitable for a simpler SoC platform not requiring a more sophisticated and
> +bigger External Vector Interrupt Controller.
> +
> +
> +Main node required properties:
> +
> +- compatible : should at least contain  "andestech,ativic32".
> +- interrupt-parent: Empty for the interrupt controller itself

Drop this.

> +- interrupt-controller : Identifies the node as an interrupt controller
> +- #interrupt-cells: The number of cells to define the interrupts. Should be 2.
> +       The first cell is the IRQ number
> +       The second cell is used to specify mode:
> +               1 = low-to-high edge triggered
> +               2 = high-to-low edge triggered
> +               4 = active high level-sensitive
> +               8 = active low level-sensitive

Just state 2 cells and refer to interrupt-controller/interrupts.txt.

> +               Default for internal sources should be set to 4 (active high).
> +
> +Examples:
> +       intc: interrupt-controller {
> +               compatible = "andestech,ativic32";
> +               #interrupt-cells = <2>;
> +               interrupt-controller;
> +       };
> --
> 1.7.9.5
>

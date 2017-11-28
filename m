From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 26/35] dt-bindings: interrupt-controller: Andestech
 Internal Vector Interrupt Controller
Date: Tue, 28 Nov 2017 08:05:45 -0600
Message-ID: <20171128140545.6sicdf6eau66xn75@rob-hp-laptop>
References: <cover.1511785528.git.green.hu@gmail.com>
 <d2539a0128f8c1cf0b32fd5151fd2f8775e5c511.1511785528.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:46875 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751822AbdK1OFr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Nov 2017 09:05:47 -0500
Content-Disposition: inline
In-Reply-To: <d2539a0128f8c1cf0b32fd5151fd2f8775e5c511.1511785528.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, Rick Chen <rick@andestech.com>

On Mon, Nov 27, 2017 at 08:28:13PM +0800, Greentime Hu wrote:
> From: Greentime Hu <greentime@andestech.com>
> 
> This patch adds an irqchip driver document for the Andestech Internal Vector
> Interrupt Controller.
> 
> Signed-off-by: Rick Chen <rick@andestech.com>
> Signed-off-by: Greentime Hu <greentime@andestech.com>
> ---
>  .../interrupt-controller/andestech,ativic32.txt    |   19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt

Acked-by: Rob Herring <robh@kernel.org>

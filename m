Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33477 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbdLLRdw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Dec 2017 12:33:52 -0500
Date: Tue, 12 Dec 2017 11:33:50 -0600
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 31/33] dt-bindings: interrupt-controller: Andestech
 Internal Vector Interrupt Controller
Message-ID: <20171212173350.2skxihbzzzpdenwf@rob-hp-laptop>
References: <cover.1512723245.git.green.hu@gmail.com>
 <a0bb0a384a74bc180c0d4e9aa5741bb52653211b.1512723245.git.green.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0bb0a384a74bc180c0d4e9aa5741bb52653211b.1512723245.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, Rick Chen <rick@andestech.com>
Message-ID: <20171212173350.ikJeQlhdwPie-m6XVb1JfrKRxQuKhzzjCevRb7iXBN8@z>

On Fri, Dec 08, 2017 at 05:12:14PM +0800, Greentime Hu wrote:
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

I acked v2. Please add acks when posting new versions.

Rob

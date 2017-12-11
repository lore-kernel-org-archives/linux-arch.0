Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53904 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751622AbdLKJQR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 11 Dec 2017 04:16:17 -0500
Subject: Re: [PATCH v3 32/33] irqchip: Andestech Internal Vector Interrupt
 Controller driver
References: <cover.1512723245.git.green.hu@gmail.com>
 <4fb7bd1cd2619287061fd68a38a774c8aef7dbe9.1512723245.git.green.hu@gmail.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <fed9bc8a-4a07-59ca-1e8b-9007d5ce3acd@arm.com>
Date: Mon, 11 Dec 2017 09:16:11 +0000
MIME-Version: 1.0
In-Reply-To: <4fb7bd1cd2619287061fd68a38a774c8aef7dbe9.1512723245.git.green.hu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>, greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com
Cc: Rick Chen <rick@andestech.com>
Message-ID: <20171211091611.jOyTHayWMZyh1yDyASaIa66TxAKRtPg_vLQdIoCd-R4@z>

On 08/12/17 09:12, Greentime Hu wrote:
> From: Greentime Hu <greentime@andestech.com>
> 
> This patch adds the Andestech Internal Vector Interrupt Controller
> driver. You can find the spec here. Ch4.9 of AndeStar SPA V3 Manual.
> http://www.andestech.com/product.php?cls=9
> 
> Signed-off-by: Rick Chen <rick@andestech.com>
> Signed-off-by: Greentime Hu <greentime@andestech.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

Once there is an agreement on this series being fit for mainline, let me
know how you want to get this merged (either as a whole series, or with
this driver going through the irq tree).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

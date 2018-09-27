Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40879 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbeI0X4A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Sep 2018 19:56:00 -0400
Date: Thu, 27 Sep 2018 12:36:38 -0500
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V5 27/30] dt-bindings: interrupt-controller: C-SKY APB
 intc
Message-ID: <20180927173638.GA5231@bogus>
References: <cover.1537789736.git.ren_guo@c-sky.com>
 <962274d8ec61f3900b19c07bbe8923674c94d044.1537789737.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <962274d8ec61f3900b19c07bbe8923674c94d044.1537789737.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, green.hu@gmail.com, palmer@sifive.com
Message-ID: <20180927173638.AydL9BqPzPoQKg5pHVBSyiiZkjVRGQIedMeH-kQ1lT0@z>

On Tue, 25 Sep 2018 07:39:30 +0800, Guo Ren wrote:
>  - Dt-bindings doc about C-SKY apb bus interrupt controller.
> 
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---
>  .../interrupt-controller/csky,apb-intc.txt         | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

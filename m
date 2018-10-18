Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43373 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbeJRWcy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Oct 2018 18:32:54 -0400
Date: Thu, 18 Oct 2018 09:31:35 -0500
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V9 18/21] dt-bindings: csky CPU Bindings
Message-ID: <20181018143135.GA22243@bogus>
References: <cover.1539655731.git.ren_guo@c-sky.com>
 <867b2328e3dbaef58d0b5e7fc58e8545d1510951.1539655732.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <867b2328e3dbaef58d0b5e7fc58e8545d1510951.1539655732.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, hch@infradead.org, marc.zyngier@arm.com, mark.rutland@arm.com, peterz@infradead.org, robh@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, c-sky_gcc_upstream@c-sky.com
Message-ID: <20181018143135.HueUtuRgcEOJjzrk56JpY4uq5UE34rv8UESOpHJeSeA@z>

On Tue, 16 Oct 2018 10:58:37 +0800, Guo Ren wrote:
> This patch adds the documentation to describe that how to add cpu nodes in
> dts for SMP.
> 
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Rob Herring <robh@kernel.org>
> ---
> Changelog:
>  - Add compatible.
>  - Remove status part.
> ---
> ---
>  Documentation/devicetree/bindings/csky/cpus.txt | 73 +++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/csky/cpus.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

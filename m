From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V9 18/21] dt-bindings: csky CPU Bindings
Date: Thu, 18 Oct 2018 09:31:35 -0500
Message-ID: <20181018143135.GA22243@bogus>
References: <cover.1539655731.git.ren_guo@c-sky.com>
 <867b2328e3dbaef58d0b5e7fc58e8545d1510951.1539655732.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <867b2328e3dbaef58d0b5e7fc58e8545d1510951.1539655732.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, hch@infradead.org, marc.zyngier@arm.com, mark.rutland@arm.com, peterz@infradead.org, robh@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, c-sky_gcc_upstream@c-sky.com, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

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

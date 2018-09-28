From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V6 20/33] csky/dma: fix up dma_mapping error
Date: Fri, 28 Sep 2018 09:21:16 -0700
Message-ID: <20180928162116.GF19827@infradead.org>
References: <cover.1538058840.git.ren_guo@c-sky.com>
 <378d4064bf29863785f4cc637999e07507e2e926.1538058840.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <378d4064bf29863785f4cc637999e07507e2e926.1538058840.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

On Fri, Sep 28, 2018 at 08:51:17AM +0800, Guo Ren wrote:
> The arch_sync_dma_for_cpu()/arch_sync_dma_for_device() implementation is
> broken for some combinations that end up in a BUG() instead of performing
> the necessary flushes.

This should be folded into the original patch adding this code.

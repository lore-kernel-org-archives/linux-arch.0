From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V6 13/33] csky: Library functions
Date: Fri, 28 Sep 2018 09:20:30 -0700
Message-ID: <20180928162030.GE19827@infradead.org>
References: <cover.1538058840.git.ren_guo@c-sky.com>
 <2418a9d77fb92ff7606c08e209d8994e4f21e7ff.1538058840.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2418a9d77fb92ff7606c08e209d8994e4f21e7ff.1538058840.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, green.hu@gmail.com, Chen Linfei <linfei_chen@c-sky.com>, Mao Han <han_mao@c-sky.com>
List-Id: linux-arch.vger.kernel.org

> +unsigned long long notrace __bswapdi2(unsigned long long u)
> +{
> +	return (((u) & 0xff00000000000000ull) >> 56) |
> +	       (((u) & 0x00ff000000000000ull) >> 40) |
> +	       (((u) & 0x0000ff0000000000ull) >> 24) |
> +	       (((u) & 0x000000ff00000000ull) >>  8) |
> +	       (((u) & 0x00000000ff000000ull) <<  8) |
> +	       (((u) & 0x0000000000ff0000ull) << 24) |
> +	       (((u) & 0x000000000000ff00ull) << 40) |
> +	       (((u) & 0x00000000000000ffull) << 56);
> +}

How is this any better than using the generic byteswap helpers?

> +unsigned int notrace __bswapsi2(unsigned int u)
> +{
> +	return (((u) & 0xff000000) >> 24) |
> +	       (((u) & 0x00ff0000) >>  8) |
> +	       (((u) & 0x0000ff00) <<  8) |
> +	       (((u) & 0x000000ff) << 24);
> +}

Same here.

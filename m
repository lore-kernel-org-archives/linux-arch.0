From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH v2 06/35] nds32: MMU fault handling and page table
 management
Date: Thu, 7 Dec 2017 16:40:41 +0000
Message-ID: <20171207164040.GD21978@ZenIV.linux.org.uk>
References: <cover.1511785528.git.green.hu@gmail.com>
 <ba92adae5d20d99c7c18e75146642a2ccbd5d047.1511785528.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ba92adae5d20d99c7c18e75146642a2ccbd5d047.1511785528.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 27, 2017 at 08:27:53PM +0800, Greentime Hu wrote:
> +void do_page_fault(unsigned long entry, unsigned long addr,
> +		   unsigned int error_code, struct pt_regs *regs)
[snip]
> +	/*
> +	 * If we're in an interrupt or have no user
> +	 * context, we must not take the fault..
> +	 */
> +	if (unlikely(in_atomic() || !mm))

Broken.  in_atomic() is wrong here - it should be faulthandler_disabled().

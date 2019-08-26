From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 5/7] arm64: smp: use generic SMP stop common code
Date: Tue, 27 Aug 2019 00:26:05 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1908270025340.1939@nanos.tec.linutronix.de>
References: <20190823115720.605-1-cristian.marussi@arm.com> <20190823115720.605-6-cristian.marussi@arm.com> <20190826153236.GA9591@infradead.org> <c6a86709-6faf-bf84-08aa-c41dab61c58f@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c6a86709-6faf-bf84-08aa-c41dab61c58f@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mark.rutland@arm.com, peterz@infradead.org, catalin.marinas@arm.com, takahiro.akashi@linaro.org, james.morse@arm.com, hidehiro.kawai.ez@hitachi.com, will@kernel.org, dave.martin@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Mon, 26 Aug 2019, Cristian Marussi wrote:
> On 8/26/19 4:32 PM, Christoph Hellwig wrote:
> > > +config ARCH_USE_COMMON_SMP_STOP
> > > +	def_bool y if SMP
> > 
> > The option belongs into common code and the arch code shoud only
> > select it.
> > 
> 
> In fact that was my first approach, but then I noticed that in kernel/ topdir
> there was no generic Kconfig but only subsystem specific ones:
> 
> Kconfig.freezer  Kconfig.hz       Kconfig.locks    Kconfig.preempt

arch/Kconfig

Thanks,

	tglx

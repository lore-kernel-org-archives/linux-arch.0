From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 5/7] arm64: smp: use generic SMP stop common code
Date: Mon, 26 Aug 2019 08:32:36 -0700
Message-ID: <20190826153236.GA9591@infradead.org>
References: <20190823115720.605-1-cristian.marussi@arm.com>
 <20190823115720.605-6-cristian.marussi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190823115720.605-6-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mark.rutland@arm.com, peterz@infradead.org, catalin.marinas@arm.com, takahiro.akashi@linaro.org, james.morse@arm.com, hidehiro.kawai.ez@hitachi.com, tglx@linutronix.de, will@kernel.org, dave.martin@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

> +config ARCH_USE_COMMON_SMP_STOP
> +	def_bool y if SMP

The option belongs into common code and the arch code shoud only
select it.

Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:55304 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbfHZPck (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Aug 2019 11:32:40 -0400
Date: Mon, 26 Aug 2019 08:32:36 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 5/7] arm64: smp: use generic SMP stop common code
Message-ID: <20190826153236.GA9591@infradead.org>
References: <20190823115720.605-1-cristian.marussi@arm.com>
 <20190823115720.605-6-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823115720.605-6-cristian.marussi@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mark.rutland@arm.com, peterz@infradead.org, catalin.marinas@arm.com, takahiro.akashi@linaro.org, james.morse@arm.com, hidehiro.kawai.ez@hitachi.com, tglx@linutronix.de, will@kernel.org, dave.martin@arm.com, linux-arm-kernel@lists.infradead.org
Message-ID: <20190826153236.OvP978uP-i5XiZvGzY1SowSf2REj8yRF_ku5yNnk_-A@z>

> +config ARCH_USE_COMMON_SMP_STOP
> +	def_bool y if SMP

The option belongs into common code and the arch code shoud only
select it.

Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:57672 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbfHZPeE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Aug 2019 11:34:04 -0400
Date: Mon, 26 Aug 2019 08:34:01 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 0/7] Unify SMP stop generic logic to common code
Message-ID: <20190826153401.GB9591@infradead.org>
References: <20190823115720.605-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823115720.605-1-cristian.marussi@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mark.rutland@arm.com, peterz@infradead.org, catalin.marinas@arm.com, takahiro.akashi@linaro.org, james.morse@arm.com, hidehiro.kawai.ez@hitachi.com, tglx@linutronix.de, will@kernel.org, dave.martin@arm.com, linux-arm-kernel@lists.infradead.org
Message-ID: <20190826153401.7Y0-PREc2MOcwPqlVHxHL7xp0iDFr6xhd3sRSsj0z0A@z>

On Fri, Aug 23, 2019 at 12:57:13PM +0100, Cristian Marussi wrote:
> An architecture willing to rely on this SMP common logic has to define its
> own helpers and set CONFIG_ARCH_USE_COMMON_SMP_STOP=y.
> The series wire this up for arm64.
> 
> Behaviour is not changed for architectures not adopting this new common
> logic.

Seens like this common code only covers arm64.  I think we should
generally have at least two users for common code.

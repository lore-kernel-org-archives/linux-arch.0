Return-Path: <SRS0=fNgb=3C=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728877AbgAMQkg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Jan 2020 11:40:36 -0500
Date: Mon, 13 Jan 2020 16:40:29 +0000
From: Will Deacon <will@kernel.org>
Subject: Re: [RFC PATCH v3 00/12] Unify SMP stop generic logic to common code
Message-ID: <20200113164029.GE4458@willie-the-truck>
References: <20191219121905.26905-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219121905.26905-1-cristian.marussi@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mark.rutland@arm.com, peterz@infradead.org, catalin.marinas@arm.com, takahiro.akashi@linaro.org, james.morse@arm.com, hidehiro.kawai.ez@hitachi.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, mingo@redhat.com, x86@kernel.org, dzickus@redhat.com, ehabkost@redhat.com, linux@armlinux.org.uk, davem@davemloft.net, sparclinux@vger.kernel.org, hch@infradead.org
Message-ID: <20200113164029.W9OzlIOu9AkZVMs6GIrl56ZW2s-xWMC2Er9A_oqqUzQ@z>

On Thu, Dec 19, 2019 at 12:18:53PM +0000, Cristian Marussi wrote:
> the logic underlying SMP stop and kexec crash procedures, beside containing
> some arch-specific bits, is mostly generic and common across all archs:
> despite this fact, such logic is now scattered across all architectures and
> on some of them is flawed, in such a way that, under some specific
> conditions, you can end up with a CPU left still running after a panic and
> possibly lost across a subsequent kexec crash reboot. [1]

Is this still the case even after 20bb759a66be ("panic: ensure preemption is
disabled during panic()")?

Will

Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:58561 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752071Ab2IHI3M (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 8 Sep 2012 04:29:12 -0400
Received: by qcse13 with SMTP id e13so699902qcs.1
        for <linux-arch@vger.kernel.org>; Sat, 08 Sep 2012 01:29:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1347035226-18649-29-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com> <1347035226-18649-29-git-send-email-catalin.marinas@arm.com>
From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Date: Sat, 8 Sep 2012 13:58:49 +0530
Message-ID: <CAMQu2gyLihPnujff6Nq3wzRaX3n+je+4fVfUE_OPVsb_dO14FQ@mail.gmail.com>
Subject: Re: [PATCH v3 28/31] arm64: Generic timers support
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20120908082849.r5I2DPdX4PkOkuudAGZ1u70xOO9cvMKe0SCXnnW9OUA@z>

On Fri, Sep 7, 2012 at 9:57 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
>
> This patch adds support for the ARM generic timers with A64 instructions
> for accessing the timer registers. It uses the physical counter as the
> clock source and the virtual counter as sched_clock.
>
> The timer frequency can be specified via DT or read from the CNTFRQ_EL0
> register. The physical counter is also accessible from user space
> allowing fast gettimeofday() implementation.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> ---
Thanks for C3STOP update.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

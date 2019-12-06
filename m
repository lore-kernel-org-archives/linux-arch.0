Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:52756 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfLFSRD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Dec 2019 13:17:03 -0500
Date: Fri, 6 Dec 2019 18:16:56 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 0/3] sysfs: add sysfs based cpuinfo
Message-ID: <20191206181655.GA35318@lakrids.cambridge.arm.com>
References: <20191206162421.15050-1-trenn@suse.de>
 <20191206165803.GD21671@lakrids.cambridge.arm.com>
 <2898795.Dnvf4huJ59@skinner.arch.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2898795.Dnvf4huJ59@skinner.arch.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Renninger <trenn@suse.de>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk, will.deacon@arm.com, x86@kernel.org, fschnitzlein@suse.de
Message-ID: <20191206181656.BsUdpnDdeT27ioneC1aeSYNCd5zoV6ujED_cccClojI@z>

On Fri, Dec 06, 2019 at 06:29:39PM +0100, Thomas Renninger wrote:
> On Friday, December 6, 2019 5:58:03 PM CET Mark Rutland wrote:
> > On Fri, Dec 06, 2019 at 05:24:18PM +0100, Thomas Renninger wrote:

> > For arm64 we already expose the MIDR and REVIDR register values under
> > /sys/devices/system/cpu/cpu*/regs/identification, and that's the bulk of
> > the useful information above
> 
> I'd like to come up with an extra CONFIG which parses:
> 
> arch/arm64/include/asm/cputype.h:
> 
> #define ARM_CPU_PART_AEM_V8             0xD0F
> #define ARM_CPU_PART_FOUNDATION         0xD00
> #define ARM_CPU_PART_CORTEX_A57         0xD07
> #define ARM_CPU_PART_CORTEX_A72         0xD08
> 
> and
> 
> #define ARM_CPU_IMP_ARM                 0x41
> #define ARM_CPU_IMP_APM                 0x50
> #define ARM_CPU_IMP_CAVIUM              0x43
> #define ARM_CPU_IMP_BRCM                0x42
> #define ARM_CPU_IMP_QCOM                0x51
> #define ARM_CPU_IMP_NVIDIA              0x4E
> 
> and converts the defines to strings, same as here:

A similar approach for /proc/cpuinfo has been NAK'd repeatedly in the
past. While some arguments against that don't apply here, I don't think
that we want to have to maintain an ever-growing list of strings that
end up being ABI which we cannot manage in a forwards-compatible manner.

When it is necessary to reliably and unambiguously identify a CPU, it'll
always end up being necessary to look at the MIDR (and possibly REVIDR),
so that's what applications should always do, and it's what users will
necessarily have to do when the kernel doesn't have a string for a CPU,
as is the case for all existing kernels.

I don't think that in-kernel stringification of the MIDR is a good idea,
and I would suggest not wasting your time on that.

Thanks,
Mark.

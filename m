From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 19/22] arm64: mte: Allow user control of the tag check
 mode via prctl()
Date: Wed, 12 Feb 2020 11:45:17 +0000
Message-ID: <20200212114517.GF488264@arrakis.emea.arm.com>
References: <20191211184027.20130-1-catalin.marinas@arm.com>
 <20191211184027.20130-20-catalin.marinas@arm.com>
 <cdd9d203-00c8-0a63-69b5-66234c0e9d9a@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:59952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728247AbgBLLpV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Feb 2020 06:45:21 -0500
Content-Disposition: inline
In-Reply-To: <cdd9d203-00c8-0a63-69b5-66234c0e9d9a@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Richard Earnshaw <Richard.Earnshaw@arm.com>, Andrey Konovalov <andreyknvl@google.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org

On Fri, Dec 27, 2019 at 02:34:32PM +0000, Kevin Brodsky wrote:
> Not just related to this patch, but here goes. While trying to debug an
> MTE-enabled process, I realised that there's no way to tell the tagged addr
> / MTE thread configuration from outside of the thread. At this point I
> thought it'd be really nice if this were to be exposed in /proc/pid, maybe
> in /proc/pid/status. Unfortunately there seems to be no precedent for an
> arch-specific feature to be exposed there. I guess a ptrace call would work
> as well, although it wouldn't be as practical without using a debugger.

There is proc_pid_arch_status(), currently only used by x86 to report
the avx512 status. We could do the same on arm64 and provide information
information on the MTE status, SVE configuration, ptrauth. I think this
can be a separate patch covering all these.

-- 
Catalin

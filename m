From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v6 05/16] perf/x86: Add Hygon Dhyana support to PMU
 infrastructure
Date: Mon, 10 Sep 2018 20:17:30 +0200
Message-ID: <20180910181730.GF4386@zn.tnic>
References: <cover.1536550549.git.puwen@hygon.cn>
 <1e7b20df2bb5ebca6d72339f8b4e1453325cef10.1536550550.git.puwen@hygon.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1e7b20df2bb5ebca6d72339f8b4e1453325cef10.1536550550.git.puwen@hygon.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Pu Wen <puwen@hygon.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Sep 10, 2018 at 09:16:43PM +0800, Pu Wen wrote:
> The PMU architecture for Hygon Dhyana CPU is similar to the AMD Family
> 17h one. To support Hygon Dhyana PMU, call amd_pmu_init() to share
> AMD PMU initialization flow, and change the PMU name to "HYGON".
> 
> The Hygon Dhyana CPU support both legacy and extension PMC MSRs(perf

I don't know but for some reason, you are writing "Hygon Dhyana CPU" as
being plural. But it is singular:

"The Hygon Dhyna CPU supports both ..."
			    ^
			   |||

> counter registers and event selection registers), so add Hygon Dhyana
> support to get bit offset in the similar way as AMD does.

"to get bit offset"?

> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  arch/x86/events/amd/core.c             |  4 ++++
>  arch/x86/events/amd/uncore.c           | 20 +++++++++++++-------
>  arch/x86/events/core.c                 |  4 ++++
>  arch/x86/kernel/cpu/perfctr-watchdog.c |  2 ++
>  4 files changed, 23 insertions(+), 7 deletions(-)

With that addressed:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

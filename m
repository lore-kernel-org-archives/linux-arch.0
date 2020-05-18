From: Vladimir Murzin <vladimir.murzin@arm.com>
Subject: Re: [PATCH v4 24/26] arm64: mte: Introduce early param to disable MTE
 support
Date: Mon, 18 May 2020 12:26:30 +0100
Message-ID: <a2ad6cbf-2632-3cda-eb49-74ddfbed2cec@arm.com>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
 <20200515171612.1020-25-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:38446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbgERL0C (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 May 2020 07:26:02 -0400
In-Reply-To: <20200515171612.1020-25-catalin.marinas@arm.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, Szabolcs Nagy <szabolcs.nagy@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>, Dave P Martin <Dave.Martin@arm.com>

On 5/15/20 6:16 PM, Catalin Marinas wrote:
> For performance analysis it may be desirable to disable MTE altogether
> via an early param. Introduce arm64.mte_disable and, if true, filter out
> the sanitised ID_AA64PFR1_EL1.MTE field to avoid exposing the HWCAP to
> user.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> ---
> 
> Notes:
>     New in v4.
> 
>  Documentation/admin-guide/kernel-parameters.txt |  4 ++++
>  arch/arm64/kernel/cpufeature.c                  | 11 +++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f2a93c8679e8..7436e7462b85 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -373,6 +373,10 @@
>  	arcrimi=	[HW,NET] ARCnet - "RIM I" (entirely mem-mapped) cards
>  			Format: <io>,<irq>,<nodeID>
>  
> +	arm64.mte_disable=
> +			[ARM64] Disable Linux support for the Memory
> +			Tagging Extension (both user and in-kernel).
> +

Should it really to take parameter (on/off/true/false)? It may lead to expectation
that arm64.mte_disable=false should enable MT and, yes, double negatives make it
look ugly, so if we do need parameter, can it be arm64.mte=on/off/true/false?

Cheers
Vladimir

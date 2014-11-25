Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0179.hostedemail.com ([216.40.44.179]:44986 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750834AbaKYTnY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 25 Nov 2014 14:43:24 -0500
Message-ID: <1416944122.8358.10.camel@perches.com>
Subject: Re: [PATCH v6 5/5] patch to allow arm cross-compile
From: Joe Perches <joe@perches.com>
Date: Tue, 25 Nov 2014 11:35:22 -0800
In-Reply-To: <20141125183322.1486.90766.stgit@ahduyck-server>
References: <20141125183009.1486.20845.stgit@ahduyck-server>
	 <20141125183322.1486.90766.stgit@ahduyck-server>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexander Duyck <alexander.h.duyck@redhat.com>, Russell King <linux@arm.linux.org.uk>
Cc: linux-arch@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mathieu.desnoyers@polymtl.ca, peterz@infradead.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, mingo@kernel.org, mikey@neuling.org, donald.c.skidmore@intel.com, matthew.vick@intel.com, geert@linux-m68k.org, jeffrey.t.kirsher@intel.com, romieu@fr.zoreil.com, paulmck@linux.vnet.ibm.com, nic_swsd@realtek.com, arnd@arndb.de, will.deacon@arm.com, michael@ellerman.id.au, tony.luck@intel.com, torvalds@linux-foundation.org, oleg@redhat.com, schwidefsky@de.ibm.com, fweisbec@gmail.com, davem@davemloft.net
Message-ID: <20141125193522.TRcurTMfC5L3yAgfB4wbCRsKEVOlnZuAupDohuOhcq4@z>

(adding Russell King)

On Tue, 2014-11-25 at 10:33 -0800, Alexander Duyck wrote:
> ---
>  arch/arm/kernel/asm-offsets.c |    4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
> index 2d2d608..6f8e79c 100644
> --- a/arch/arm/kernel/asm-offsets.c
> +++ b/arch/arm/kernel/asm-offsets.c
> @@ -49,10 +49,6 @@
>  #error Your compiler is too buggy; it is known to miscompile kernels.
>  #error    Known good compilers: 3.3, 4.x
>  #endif
> -#if GCC_VERSION >= 40800 && GCC_VERSION < 40803
> -#error Your compiler is too buggy; it is known to miscompile kernels
> -#error and result in filesystem corruption and oopses.
> -#endif
>  #endif




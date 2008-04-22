Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate6.de.ibm.com ([195.212.29.155]:26131 "EHLO
	mtagate6.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758680AbYDVIGM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Apr 2008 04:06:12 -0400
Subject: Re: [PATCH 11/11] s390: convert to generic helpers for IPI
	function calls
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <1208851058-8500-12-git-send-email-jens.axboe@oracle.com>
References: <1208851058-8500-1-git-send-email-jens.axboe@oracle.com>
	 <1208851058-8500-12-git-send-email-jens.axboe@oracle.com>
Content-Type: text/plain
Date: Tue, 22 Apr 2008 10:04:50 +0200
Message-ID: <1208851490.10852.0.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, npiggin@suse.de, torvalds@linux-foundation.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Message-ID: <20080422080450.HhJo29gu6Oc2Kf8-qC5eIczln6rwHs6_Fwj1rnhgfAY@z>

On Tue, 2008-04-22 at 09:57 +0200, Jens Axboe wrote:
> diff --git a/arch/sparc64/kernel/sparc64_ksyms.c b/arch/sparc64/kernel/sparc64_ksyms.c
> index 3873646..17b16b1 100644
> --- a/arch/sparc64/kernel/sparc64_ksyms.c
> +++ b/arch/sparc64/kernel/sparc64_ksyms.c
> @@ -112,6 +112,7 @@ EXPORT_SYMBOL(__write_unlock);
>  EXPORT_SYMBOL(__write_trylock);
> 
>  EXPORT_SYMBOL(smp_call_function);
> +EXPORT_SYMBOL(smp_call_function_single);
>  #endif /* CONFIG_SMP */
> 
>  #if defined(CONFIG_MCOUNT)

This does not belong into the s390 patch ;-)

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.



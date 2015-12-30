From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 08/34] asm-generic: smp_store_mb should use smp_mb
Date: Wed, 30 Dec 2015 14:44:21 +0100
Message-ID: <5946017.BCmPrpGMuh@wuerfel>
References: <1451473761-30019-1-git-send-email-mst@redhat.com> <1451473761-30019-9-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:50837 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753991AbbL3No7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 30 Dec 2015 08:44:59 -0500
In-Reply-To: <1451473761-30019-9-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>

On Wednesday 30 December 2015 15:24:47 Michael S. Tsirkin wrote:
> asm-generic variant of smp_store_mb() calls mb() which is stronger
> than implied by both the name and the documentation.
> 
> smp_store_mb is only used by core kernel code at the moment, so
> we know no one mis-uses it for an MMIO barrier.
> Make it call smp_mb consistently before some arch-specific
> code uses it as such by mistake.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/asm-generic/barrier.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index 538f8d1..987b2e0 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -93,7 +93,7 @@
>  #endif	/* CONFIG_SMP */
>  
>  #ifndef smp_store_mb
> -#define smp_store_mb(var, value)  do { WRITE_ONCE(var, value); mb(); } while (0)
> +#define smp_store_mb(var, value)  do { WRITE_ONCE(var, value); smp_mb(); } while (0)
>  #endif
>  
>  #ifndef smp_mb__before_atomic
> 

The same patch is already in the tip tree scheduled for 4.5 as d5a73cadf3fd
("lcoking/barriers, arch: Use smp barriers in smp_store_release()").

I think you can drop your version.

	arnd

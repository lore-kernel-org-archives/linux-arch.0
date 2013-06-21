From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [RFC PATCH 10/16] mips: locks: remove unused arch_*_relax operations
Date: Fri, 21 Jun 2013 10:48:21 -0700
Message-ID: <51C491E5.7000109@caviumnetworks.com>
References: <1371835057-19335-1-git-send-email-will.deacon@arm.com> <1371835057-19335-11-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bl2lp0210.outbound.protection.outlook.com ([207.46.163.210]:45819
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1423307Ab3FURyY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 21 Jun 2013 13:54:24 -0400
In-Reply-To: <1371835057-19335-11-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, David Daney <david.daney@cavium.com>

On 06/21/2013 10:17 AM, Will Deacon wrote:
> The arch_{spin,read,write}_relax macros are not used anywhere in the
> kernel and are typically just aliases for cpu_relax().
>
> This patch removes the unused definitions for MIPS.
>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: David Daney <david.daney@cavium.com>

FWIW: Acked-by: David Daney <david.daney@cavium.com>

> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>   arch/mips/include/asm/spinlock.h | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/arch/mips/include/asm/spinlock.h b/arch/mips/include/asm/spinlock.h
> index 78d201f..7bd850a 100644
> --- a/arch/mips/include/asm/spinlock.h
> +++ b/arch/mips/include/asm/spinlock.h
> @@ -419,8 +419,4 @@ static inline int arch_write_trylock(arch_rwlock_t *rw)
>   #define arch_read_lock_flags(lock, flags) arch_read_lock(lock)
>   #define arch_write_lock_flags(lock, flags) arch_write_lock(lock)
>
> -#define arch_spin_relax(lock)	cpu_relax()
> -#define arch_read_relax(lock)	cpu_relax()
> -#define arch_write_relax(lock)	cpu_relax()
> -
>   #endif /* _ASM_SPINLOCK_H */
>

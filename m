Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B978B3EDE6A;
	Mon, 29 Jun 2026 08:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782721143; cv=none; b=eldJBFh8/Tox9U+16WQw4785Cti6PEbUVUVCGG9C71zIZlyiafNz//z8D4XYn1OMr8+OqHtwAd720rRDVj+1hkb2qr4WlXzAbeKSOT2V9UrEYnyB3hhh8jK2F3JzTNp7QMUKdSJ7fVRaReBnHx7SEoCfzhAJ7KX0eQX51OOiz+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782721143; c=relaxed/simple;
	bh=vdIwsM5VwLMwOyR5nmZmGyQCjALyr3YaMsY8v0GXe6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5K9PFRFhkT3ytniuIOQLDlf6PRHJbi/Hvto1Ul1465QtiDvgRM2tl9YgxzFwYSWZmY4D3xp69YLQyZP3pLKtUTUdvWIgvFEV3ivXK6XqJsupvWuXRY9/KsA7C+CcCFN55qSUdctjYwlTZCXHNwzbf17SKq73O3ub9gBkMSLisY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=irVpVIBd; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="irVpVIBd"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C83B1A00;
	Mon, 29 Jun 2026 01:18:55 -0700 (PDT)
Received: from [192.168.7.252] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50C943F836;
	Mon, 29 Jun 2026 01:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782721140; bh=vdIwsM5VwLMwOyR5nmZmGyQCjALyr3YaMsY8v0GXe6E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=irVpVIBdPYx6IgoFS4gIJNMnmB19XzTpVbrzPw/Pv91RzbqL4TsZD0/uNldTg64Vk
	 BMdgzIZz6C0yJjCRqxhnxEhP+VlFwCX37LZQIwx8FaLBMpLWvqkhiFNP+34Mctjx43
	 /+ot73ukejEkdy52U3ym2VzQWo0HpZtL1nKVbMkY=
Message-ID: <e63ff5e2-831c-4b9c-8306-ba6cf343e524@arm.com>
Date: Mon, 29 Jun 2026 09:18:58 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdso: Replace __ASSEMBLY__ with __ASSEMBLER__ in header
 files
Content-Language: en-GB
To: Thomas Huth <thuth@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org
References: <20260619100600.121042-1-thuth@redhat.com>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20260619100600.121042-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Thomas,

thank you for your patch.

On 19/06/2026 11:06, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> While the GCC and Clang compilers already define __ASSEMBLER__
> automatically when compiling assembly code, __ASSEMBLY__ is a
> macro that only gets defined by the Makefiles in the kernel.
> This can be very confusing when switching between userspace
> and kernelspace coding, or when dealing with uapi headers that
> rather should use __ASSEMBLER__ instead. So let's standardize now
> on the __ASSEMBLER__ macro that is provided by the compilers.
> 
> This is a completely mechanical patch (done with a simple "sed -i"
> statement).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  Note: This patch has been split from an earlier bigger patch of mine
>        to ease reviewing.
> 
>  include/asm-generic/vdso/vsyscall.h | 4 ++--
>  include/vdso/datapage.h             | 6 +++---
>  include/vdso/helpers.h              | 4 ++--
>  include/vdso/processor.h            | 4 ++--
>  include/vdso/vsyscall.h             | 4 ++--
>  5 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/vsyscall.h
> index 5c6d9799f4e74..a6b03cfba0e24 100644
> --- a/include/asm-generic/vdso/vsyscall.h
> +++ b/include/asm-generic/vdso/vsyscall.h
> @@ -2,7 +2,7 @@
>  #ifndef __ASM_GENERIC_VSYSCALL_H
>  #define __ASM_GENERIC_VSYSCALL_H
>  
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  
>  #ifndef __arch_get_vdso_u_time_data
>  static __always_inline const struct vdso_time_data *__arch_get_vdso_u_time_data(void)
> @@ -30,6 +30,6 @@ static __always_inline void __arch_sync_vdso_time_data(struct vdso_time_data *vd
>  }
>  #endif /* __arch_sync_vdso_time_data */
>  
> -#endif /* !__ASSEMBLY__ */
> +#endif /* !__ASSEMBLER__ */
>  
>  #endif /* __ASM_GENERIC_VSYSCALL_H */
> diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
> index 5977723fb3b5d..09897f76ae07a 100644
> --- a/include/vdso/datapage.h
> +++ b/include/vdso/datapage.h
> @@ -2,7 +2,7 @@
>  #ifndef __VDSO_DATAPAGE_H
>  #define __VDSO_DATAPAGE_H
>  
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  
>  #include <linux/types.h>
>  
> @@ -176,7 +176,7 @@ enum vdso_pages {
>  	VDSO_NR_PAGES
>  };
>  
> -#else /* !__ASSEMBLY__ */
> +#else /* !__ASSEMBLER__ */
>  
>  #ifdef CONFIG_VDSO_GETRANDOM
>  #define __vdso_u_rng_data	PROVIDE(vdso_u_rng_data = vdso_u_data + 2 * PAGE_SIZE);
> @@ -197,6 +197,6 @@ enum vdso_pages {
>  	__vdso_u_arch_data					\
>  
>  
> -#endif /* !__ASSEMBLY__ */
> +#endif /* !__ASSEMBLER__ */
>  
>  #endif /* __VDSO_DATAPAGE_H */
> diff --git a/include/vdso/helpers.h b/include/vdso/helpers.h
> index a3bf4f1c0d37d..65151b681c4f5 100644
> --- a/include/vdso/helpers.h
> +++ b/include/vdso/helpers.h
> @@ -2,7 +2,7 @@
>  #ifndef __VDSO_HELPERS_H
>  #define __VDSO_HELPERS_H
>  
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  
>  #include <asm/barrier.h>
>  #include <vdso/datapage.h>
> @@ -111,6 +111,6 @@ static __always_inline void vdso_write_end(struct vdso_time_data *vd)
>  	vdso_write_seq_end(&vc[CS_RAW]);
>  }
>  
> -#endif /* !__ASSEMBLY__ */
> +#endif /* !__ASSEMBLER__ */
>  
>  #endif /* __VDSO_HELPERS_H */
> diff --git a/include/vdso/processor.h b/include/vdso/processor.h
> index fbe8265ea3c49..cc781912a696e 100644
> --- a/include/vdso/processor.h
> +++ b/include/vdso/processor.h
> @@ -5,10 +5,10 @@
>  #ifndef __VDSO_PROCESSOR_H
>  #define __VDSO_PROCESSOR_H
>  
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  
>  #include <asm/vdso/processor.h>
>  
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
>  
>  #endif /* __VDSO_PROCESSOR_H */
> diff --git a/include/vdso/vsyscall.h b/include/vdso/vsyscall.h
> index b0fdc9c6bf439..c5c2a2c078571 100644
> --- a/include/vdso/vsyscall.h
> +++ b/include/vdso/vsyscall.h
> @@ -2,13 +2,13 @@
>  #ifndef __VDSO_VSYSCALL_H
>  #define __VDSO_VSYSCALL_H
>  
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  
>  #include <asm/vdso/vsyscall.h>
>  
>  unsigned long vdso_update_begin(void);
>  void vdso_update_end(unsigned long flags);
>  
> -#endif /* !__ASSEMBLY__ */
> +#endif /* !__ASSEMBLER__ */
>  
>  #endif /* __VDSO_VSYSCALL_H */

-- 
Regards,
Vincenzo


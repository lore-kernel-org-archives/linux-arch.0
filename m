Return-Path: <SRS0=hCVk=4O=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46862 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgBZFrf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Feb 2020 00:47:35 -0500
Received: by mail-pg1-f196.google.com with SMTP id y30so730953pga.13
        for <linux-arch@vger.kernel.org>; Tue, 25 Feb 2020 21:47:35 -0800 (PST)
Date: Tue, 25 Feb 2020 21:47:32 -0800
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v6 05/11] arm64: elf: Enable BTI at exec based on ELF
 program properties
Message-ID: <202002252146.7230873E@keescook>
References: <20200212192906.53366-1-broonie@kernel.org>
 <20200212192906.53366-6-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212192906.53366-6-broonie@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Marc Zyngier <maz@kernel.org>, Eugene Syromiatnikov <esyr@redhat.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, "H . J . Lu " <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Richard Henderson <richard.henderson@linaro.org>, Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Florian Weimer <fweimer@redhat.com>, Sudakshina Das <sudi.das@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>
Message-ID: <20200226054732.c_UL4n6JJ6Fq-qEoT73sr0jIl_esx-Gp6nuDti4X5MQ@z>

On Wed, Feb 12, 2020 at 07:29:00PM +0000, Mark Brown wrote:
> diff --git a/include/linux/elf.h b/include/linux/elf.h
> index 1b6e8955c597..5d5b0321da0b 100644
> --- a/include/linux/elf.h
> +++ b/include/linux/elf.h
> @@ -63,7 +63,11 @@ extern int elf_coredump_extra_notes_size(void);
>  extern int elf_coredump_extra_notes_write(struct coredump_params *cprm);
>  #endif
>  
> -/* NT_GNU_PROPERTY_TYPE_0 header */
> +/*
> + * NT_GNU_PROPERTY_TYPE_0 header:
> + * Keep this internal until/unless there is an agreed UAPI definition.
> + * pr_type values (GNU_PROPERTY_*) are public and defined in the UAPI header.
> + */
>  struct gnu_property {
>  	u32 pr_type;
>  	u32 pr_datasz;

I think this hunk should be in patch 1.

-- 
Kees Cook

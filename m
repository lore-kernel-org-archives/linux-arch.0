Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr710092.outbound.protection.outlook.com ([40.107.71.92]:48288
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726045AbfE3PlT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 11:41:19 -0400
From: Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH v6 18/19] x86: Add support for generic vDSO
Date: Thu, 30 May 2019 15:41:13 +0000
Message-ID: <BYAPR21MB1221D54FCEC97509EEF7395CD7180@BYAPR21MB1221.namprd21.prod.outlook.com>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-19-vincenzo.frascino@arm.com>
In-Reply-To: <20190530141531.43462-19-vincenzo.frascino@arm.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>
Message-ID: <20190530154113.9FUTMbAa8dsj7qEjK8UjRqDga1Dkn7qyYqspeMdTvcw@z>

From: Vincenzo Frascino <vincenzo.frascino@arm.com> On Thursday, May 30, 20=
19 7:16 AM
>=20
> The x86 vDSO library requires some adaptations to take advantage of the
> newly introduced generic vDSO library.
>=20
> Introduce the following changes:
>  - Modification of vdso.c to be compliant with the common vdso datapage
>  - Use of lib/vdso for gettimeofday
>=20
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>
>
> diff --git a/arch/x86/include/asm/mshyperv-tsc.h b/arch/x86/include/asm/m=
shyperv-tsc.h
> new file mode 100644
> index 000000000000..99c98ccea0bf
> --- /dev/null
> +++ b/arch/x86/include/asm/mshyperv-tsc.h
> @@ -0,0 +1,76 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_MSHYPER_TSCPAGE_H
> +#define _ASM_X86_MSHYPER_TSCPAGE_H
> +
> +#include <asm/hyperv-tlfs.h>
> +
> +#ifdef CONFIG_HYPERV_TSCPAGE
> +struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
> +static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *=
tsc_pg,
> +				       u64 *cur_tsc)
> +{
> +	u64 scale, offset;
> +	u32 sequence;
> +
> +	/*
> +	 * The protocol for reading Hyper-V TSC page is specified in Hypervisor
> +	 * Top-Level Functional Specification ver. 3.0 and above. To get the
> +	 * reference time we must do the following:
> +	 * - READ ReferenceTscSequence
> +	 *   A special '0' value indicates the time source is unreliable and we
> +	 *   need to use something else. The currently published specification
> +	 *   versions (up to 4.0b) contain a mistake and wrongly claim '-1'
> +	 *   instead of '0' as the special value, see commit c35b82ef0294.
> +	 * - ReferenceTime =3D
> +	 *        ((RDTSC() * ReferenceTscScale) >> 64) + ReferenceTscOffset
> +	 * - READ ReferenceTscSequence again. In case its value has changed
> +	 *   since our first reading we need to discard ReferenceTime and repea=
t
> +	 *   the whole sequence as the hypervisor was updating the page in
> +	 *   between.
> +	 */
> +	do {
> +		sequence =3D READ_ONCE(tsc_pg->tsc_sequence);
> +		if (!sequence)
> +			return U64_MAX;
> +		/*
> +		 * Make sure we read sequence before we read other values from
> +		 * TSC page.
> +		 */
> +		smp_rmb();
> +
> +		scale =3D READ_ONCE(tsc_pg->tsc_scale);
> +		offset =3D READ_ONCE(tsc_pg->tsc_offset);
> +		*cur_tsc =3D rdtsc_ordered();
> +
> +		/*
> +		 * Make sure we read sequence after we read all other values
> +		 * from TSC page.
> +		 */
> +		smp_rmb();
> +
> +	} while (READ_ONCE(tsc_pg->tsc_sequence) !=3D sequence);
> +
> +	return mul_u64_u64_shr(*cur_tsc, scale, 64) + offset;
> +}
> +
> +static inline u64 hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_=
pg)
> +{
> +	u64 cur_tsc;
> +
> +	return hv_read_tsc_page_tsc(tsc_pg, &cur_tsc);
> +}
> +
> +#else
> +static inline struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
> +{
> +	return NULL;
> +}
> +
> +static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *=
tsc_pg,
> +				       u64 *cur_tsc)
> +{
> +	BUG();
> +	return U64_MAX;
> +}
> +#endif
> +#endif
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index cc60e617931c..db095a992f3e 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -7,6 +7,7 @@
>  #include <linux/nmi.h>
>  #include <asm/io.h>
>  #include <asm/hyperv-tlfs.h>
> +#include <asm/mshyperv-tsc.h>
>  #include <asm/nospec-branch.h>
>=20
>  #define VP_INVAL	U32_MAX
> @@ -387,73 +388,4 @@ static inline int hyperv_flush_guest_mapping_range(u=
64 as,
>  }
>  #endif /* CONFIG_HYPERV */
>=20
> -#ifdef CONFIG_HYPERV_TSCPAGE
> -struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
> -static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *=
tsc_pg,
> -				       u64 *cur_tsc)
> -{
> -	u64 scale, offset;
> -	u32 sequence;
> -
> -	/*
> -	 * The protocol for reading Hyper-V TSC page is specified in Hypervisor
> -	 * Top-Level Functional Specification ver. 3.0 and above. To get the
> -	 * reference time we must do the following:
> -	 * - READ ReferenceTscSequence
> -	 *   A special '0' value indicates the time source is unreliable and we
> -	 *   need to use something else. The currently published specification
> -	 *   versions (up to 4.0b) contain a mistake and wrongly claim '-1'
> -	 *   instead of '0' as the special value, see commit c35b82ef0294.
> -	 * - ReferenceTime =3D
> -	 *        ((RDTSC() * ReferenceTscScale) >> 64) + ReferenceTscOffset
> -	 * - READ ReferenceTscSequence again. In case its value has changed
> -	 *   since our first reading we need to discard ReferenceTime and repea=
t
> -	 *   the whole sequence as the hypervisor was updating the page in
> -	 *   between.
> -	 */
> -	do {
> -		sequence =3D READ_ONCE(tsc_pg->tsc_sequence);
> -		if (!sequence)
> -			return U64_MAX;
> -		/*
> -		 * Make sure we read sequence before we read other values from
> -		 * TSC page.
> -		 */
> -		smp_rmb();
> -
> -		scale =3D READ_ONCE(tsc_pg->tsc_scale);
> -		offset =3D READ_ONCE(tsc_pg->tsc_offset);
> -		*cur_tsc =3D rdtsc_ordered();
> -
> -		/*
> -		 * Make sure we read sequence after we read all other values
> -		 * from TSC page.
> -		 */
> -		smp_rmb();
> -
> -	} while (READ_ONCE(tsc_pg->tsc_sequence) !=3D sequence);
> -
> -	return mul_u64_u64_shr(*cur_tsc, scale, 64) + offset;
> -}
> -
> -static inline u64 hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_=
pg)
> -{
> -	u64 cur_tsc;
> -
> -	return hv_read_tsc_page_tsc(tsc_pg, &cur_tsc);
> -}
> -
> -#else
> -static inline struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
> -{
> -	return NULL;
> -}
> -
> -static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *=
tsc_pg,
> -				       u64 *cur_tsc)
> -{
> -	BUG();
> -	return U64_MAX;
> -}
> -#endif
>  #endif

Vincenzo -- these changes for Hyper-V are a subset of a larger patch set
I have that moves all of the Hyper-V clock/timer code into a separate
clocksource driver in drivers/clocksource, with an include file in
includes/clocksource.  That new include file should be able to work
instead of your new mshyperv-tsc.h.  It also has the benefit of being
ISA neutral, so it will work with my in-progress patch set to support
Linux on Hyper-V on ARM64.  See https://lkml.org/lkml/2019/5/27/231
for the new clocksource driver patch set.

Michael

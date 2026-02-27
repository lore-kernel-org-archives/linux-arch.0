Received: from sg-1-101.ptr.blmpb.com (sg-1-101.ptr.blmpb.com [118.26.132.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A8A28314B
	for <linux-arch@vger.kernel.org>; Fri, 27 Feb 2026 07:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772178916; cv=none; b=cJCd2Zfc+akmZ6ul/C1sTTSxhE+o6BfoR/g4xRfCwGbZxGS9IRLQyKogeqHOYL0y7IHtbzy18eaVgT+GZZKzXvKqDBXniEsBmIzEHWCsLCcmvn67elmoWXln6epm7QOCFXw1BVLp83ciB16rSER7u5NrulxX/wu+c3ye1hMgtQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772178916; c=relaxed/simple;
	bh=TAvK6L/E8uSJLAv3UtqtVUaNCnqtobpv0bWzsaT5iZA=;
	h=From:In-Reply-To:Cc:Subject:Mime-Version:To:Date:Message-Id:
	 Content-Type:References; b=eVheO9wGmhZrXYM5sE2DS/r0dWSGKvzv8Y9O3b1vlBGGB+m/eHnfmsJ56UewZCAo1m9WCAegNVNOmGlsSCE919z8xWkP3wz1sUYYOVuWT2qP0iRoAQ8v+ZXFUwtbg0jCyhQzyWiKUmhlLxEagTzI1jCfj6r3NkCeg45KZ9Wo5Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jZtlRWzr; arc=none smtp.client-ip=118.26.132.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jZtlRWzr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1772178902; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=N5LaAEByTuPdujJKcmWuvRXt75QyoscOSiTj5esAxzk=;
 b=jZtlRWzrc2lK9DvevGFC7+Qy76nieCtLWyTcJiempkL9O9cAWB+NrMDKHLtH4krAQOZgwl
 1E6rtrukbCkyfgtHaRwQpgnJN8mbYODQcqbJsHtSqFMrep7aB1UO+fZ6pxvJTMn39yWVW0
 Wsqiu2NSHOGYAEvkQHOre52PEBty9p2KB6h9+hw1OlttnyXJ/q62t3dJ1dV5jwCC3AtabY
 VBFmokyHBa+OqSPDhYPDlu2vMjlP+HtdUOwQoPcaIzCjVLW8EYKtSUQyHwmlG60D4Wn3wM
 W0XiS6j0JVgpsBWYlqY1c4m1wq0qiJ5UyXy/nN+sJHrzZLR4YDdaJmRmes2b+Q==
From: "Rui Qi" <qirui.001@bytedance.com>
In-Reply-To: <20260226-comprised-untold-1f2c0d2d48d6@spud>
Cc: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, 
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <cyrilbur@tenstorrent.com>, 
	<tglx@kernel.org>, <peterz@infradead.org>, <debug@rivosinc.com>, 
	<andybnac@gmail.com>, <charlie@rivosinc.com>, <geomatsi@gmail.com>, 
	<thuth@redhat.com>, <bjorn@rivosinc.com>, <songshuaishuai@tinylab.org>, 
	<martin@kaiser.cx>, <masahiroy@kernel.org>, <kees@kernel.org>, 
	<linux-arch@vger.kernel.org>, <linux-riscv@lists.infradead.org>, 
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: add system error interrupt handler support
Content-Transfer-Encoding: quoted-printable
X-Original-From: Rui Qi <qirui.001@bytedance.com>
X-Lms-Return-Path: <lba+269a14dd5+c25fef+vger.kernel.org+qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Conor Dooley" <conor@kernel.org>
Date: Fri, 27 Feb 2026 15:54:39 +0800
Message-Id: <2bc446a4-0082-4525-baab-0ac4c332cfa8@bytedance.com>
Content-Type: text/plain; charset=UTF-8
References: <20260226082735.56108-1-qirui.001@bytedance.com> <20260226-comprised-untold-1f2c0d2d48d6@spud>

On 2/26/26 5:22 PM, Conor Dooley wrote:
> On Thu, Feb 26, 2026 at 04:27:35PM +0800, Rui Qi wrote:
>> Add a system error interrupt handler for RISC-V that panics
>> the system when hardware errors are detected. The implementation include=
s:
>>
>> - Add IRQ_SYS_ERROR (23) interrupt definition to CSR header
>> - Implement sys_error.c module with panic handler
>> - Register per-CPU interrupt handler for system error interrupts
>> - Add module to kernel build system
>>
>> When a system error interrupt occurs, the handler immediately panics
>> the system with a descriptive message to ensure the error is properly
>> captured and the system is halted safely.
>>
>> Signed-off-by: Rui Qi <qirui.001@bytedance.com>
>> ---
>>  arch/riscv/include/asm/csr.h  |  4 +-
>>  arch/riscv/kernel/Makefile    |  1 +
>>  arch/riscv/kernel/sys_error.c | 80 +++++++++++++++++++++++++++++++++++
>>  include/linux/cpuhotplug.h    |  1 +
>>  4 files changed, 85 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/riscv/kernel/sys_error.c
>>
>> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
>> index 31b8988f4488..1f43c25b07ed 100644
>> --- a/arch/riscv/include/asm/csr.h
>> +++ b/arch/riscv/include/asm/csr.h
>> @@ -99,7 +99,8 @@
>>  #define IRQ_M_EXT		11
>>  #define IRQ_S_GEXT		12
>>  #define IRQ_PMU_OVF		13
>> -#define IRQ_LOCAL_MAX		(IRQ_PMU_OVF + 1)
>> +#define IRQ_SYS_ERROR		23
>=20
> Hmmm, two problems I think with this. 23 is one of the interrupts that
> has been reserved for use with AIA. I don't think they use it right now,
> but in the future it might see use there.
>=20
> The first problem is kind of moot though, because reserving 16-23 for
> AIA is a retcon, and previously these interrupts were available custom
> use on any platform (as you have done here), so while it might be a
> system error on your platform, it could be something completely innocuous
> on mine!
>=20
> With that in mind, does having this in arch code make sense at all?
> Can this just be a normal driver, that'll only probe on your specific
> platform?
>=20
> Cheers,
> Conor.
>=20

Thanks for the comment.

I checked the latest RISC-V Interrupt Spec (2025-03-12). In that
version, interrupts 16=E2=80=9323 are defined as architectural local interr=
upts,
and interrupt 23 is tentatively proposed for a =E2=80=9CBus or system error=
=E2=80=9D
type condition. That suggests this interrupt number is no longer just a
free, platform-defined slot =E2=80=94 it now carries architectural intent a=
nd a
potential standardized meaning.

Given this context, my current implementation treats interrupt 23 as a
local condition that matches the spec=E2=80=99s intent for a system-level e=
rror
signal, rather than an arbitrary, custom platform interrupt. This seemed
reasonable as long as it aligns with the architectural semantics for
local interrupts.

That said, I=E2=80=99m open to the concern about placing this handling in
arch/riscv, and I=E2=80=99d like to understand your preference: do you thin=
k
this should be entirely moved into platform-specific code, or would a
conditional, spec-aware arch implementation (e.g., gated on the presence
of the relevant AIA/local interrupt support) be acceptable? Please let
me know what approach you=E2=80=99d suggest.


>> +#define IRQ_LOCAL_MAX		(IRQ_SYS_ERROR + 1)
>>  #define IRQ_LOCAL_MASK		GENMASK((IRQ_LOCAL_MAX - 1), 0)
>> =20
>>  /* Exception causes */
>> @@ -535,6 +536,7 @@
>>  # define RV_IRQ_TIMER	IRQ_S_TIMER
>>  # define RV_IRQ_EXT		IRQ_S_EXT
>>  # define RV_IRQ_PMU	IRQ_PMU_OVF
>> +# define RV_IRQ_SYS_ERROR	IRQ_SYS_ERROR
>>  # define SIP_LCOFIP     (_AC(0x1, UL) << IRQ_PMU_OVF)
>> =20
>>  #endif /* !CONFIG_RISCV_M_MODE */
>> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
>> index cabb99cadfb6..3aaf16c75d6e 100644
>> --- a/arch/riscv/kernel/Makefile
>> +++ b/arch/riscv/kernel/Makefile
>> @@ -72,6 +72,7 @@ obj-y	+=3D vendor_extensions.o
>>  obj-y	+=3D vendor_extensions/
>>  obj-y	+=3D probes/
>>  obj-y	+=3D tests/
>> +obj-y	+=3D sys_error.o
>>  obj-$(CONFIG_MMU) +=3D vdso.o vdso/
>>  obj-$(CONFIG_RISCV_USER_CFI) +=3D vdso_cfi/
>> =20
>> diff --git a/arch/riscv/kernel/sys_error.c b/arch/riscv/kernel/sys_error=
.c
>> new file mode 100644
>> index 000000000000..5b88ff4a0e84
>> --- /dev/null
>> +++ b/arch/riscv/kernel/sys_error.c
>> @@ -0,0 +1,80 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2026 Bytedance, Inc.
>> + */
>> +#define pr_fmt(fmt) "riscv-sys-error: " fmt
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/irq.h>
>> +#include <linux/irqdomain.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/percpu.h>
>> +#include <linux/module.h>
>> +#include <asm/irq.h>
>> +#include <linux/cpuhotplug.h>
>> +#include <asm/csr.h>
>> +
>> +static unsigned int riscv_sys_error_irq;
>> +static DEFINE_PER_CPU_READ_MOSTLY(int, sys_error_dummy_dev);
>> +
>> +static irqreturn_t sys_error_irq_handler(int irq, void *dev)
>> +{
>> +	panic("RISC-V System Error Interrupt - System Error Detected");
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int riscv_serror_starting_cpu(unsigned int cpu)
>> +{
>> +	csr_set(CSR_IE, BIT(RV_IRQ_SYS_ERROR));
>> +	enable_percpu_irq(riscv_sys_error_irq, irq_get_trigger_type(riscv_sys_=
error_irq));
>> +	return 0;
>> +}
>> +
>> +static int riscv_serror_dying_cpu(unsigned int cpu)
>> +{
>> +	csr_clear(CSR_IE, BIT(RV_IRQ_SYS_ERROR));
>> +	disable_percpu_irq(riscv_sys_error_irq);
>> +	return 0;
>> +}
>> +
>> +static int __init sys_error_init(void)
>> +{
>> +	int ret;
>> +	struct irq_domain *domain =3D NULL;
>> +
>> +	domain =3D irq_find_matching_fwnode(riscv_get_intc_hwnode(),
>> +					  DOMAIN_BUS_ANY);
>> +	if (!domain) {
>> +		pr_err("Failed to find INTC IRQ root domain\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	riscv_sys_error_irq =3D irq_create_mapping(domain, RV_IRQ_SYS_ERROR);
>> +	if (!riscv_sys_error_irq) {
>> +		pr_err("Failed to map PMU interrupt for node\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	ret =3D request_percpu_irq(riscv_sys_error_irq, sys_error_irq_handler,
>> +				 "riscv-syserror", &sys_error_dummy_dev);
>> +	if (ret) {
>> +		pr_err("registering percpu irq failed [%d]\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret =3D cpuhp_setup_state(CPUHP_AP_RISCV_SERROR_STARTING,
>> +			 "riscv/sys_error:starting",
>> +			 riscv_serror_starting_cpu, riscv_serror_dying_cpu);
>> +	if (ret) {
>> +		pr_err("cpuhp setup state failed [%d]\n", ret);
>> +		goto fail_free_irq;
>> +	}
>> +
>> +	return 0;
>> +
>> +fail_free_irq:
>> +	free_percpu_irq(riscv_sys_error_irq, &sys_error_dummy_dev);
>> +	return ret;
>> +}
>> +
>> +arch_initcall(sys_error_init)
>> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
>> index 62cd7b35a29c..f6d0c05f72df 100644
>> --- a/include/linux/cpuhotplug.h
>> +++ b/include/linux/cpuhotplug.h
>> @@ -174,6 +174,7 @@ enum cpuhp_state {
>>  	CPUHP_AP_REALTEK_TIMER_STARTING,
>>  	CPUHP_AP_RISCV_TIMER_STARTING,
>>  	CPUHP_AP_CLINT_TIMER_STARTING,
>> +	CPUHP_AP_RISCV_SERROR_STARTING,
>>  	CPUHP_AP_CSKY_TIMER_STARTING,
>>  	CPUHP_AP_TI_GP_TIMER_STARTING,
>>  	CPUHP_AP_HYPERV_TIMER_STARTING,
>> --=20
>> 2.20.1

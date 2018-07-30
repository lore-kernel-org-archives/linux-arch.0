Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp20.cstnet.cn ([159.226.251.20]:51299 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726820AbeG3STU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Jul 2018 14:19:20 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v2 01/17] x86/cpu: create Dhyana init file and register
 new cpu_dev to system
References: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
 <1532352037-7151-2-git-send-email-puwen@hygon.cn>
 <ed090643-09da-cde7-6edd-970d973afd4d@redhat.com>
 <201807290021145963620@hygon.cn>
 <bd73d865-acb3-66e5-a37a-dc4859e5f002@gnu.org>
Message-ID: <fcf29dd2-f7ea-40de-b8db-4327abd0d5f4@hygon.cn>
Date: Tue, 31 Jul 2018 00:42:37 +0800
MIME-Version: 1.0
In-Reply-To: <bd73d865-acb3-66e5-a37a-dc4859e5f002@gnu.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>, tglx <tglx@linutronix.de>, bp <bp@alien8.de>, "thomas.lendacky" <thomas.lendacky@amd.com>, mingo <mingo@redhat.com>, hpa <hpa@zytor.com>, peterz <peterz@infradead.org>, "tony.luck" <tony.luck@intel.com>, rkrcmar <rkrcmar@redhat.com>, "boris.ostrovsky" <boris.ostrovsky@oracle.com>, jgross <jgross@suse.com>, rjw <rjw@rjwysocki.net>, lenb <lenb@kernel.org>, "viresh.kumar" <viresh.kumar@linaro.org>, mchehab <mchehab@kernel.org>, trenn <trenn@suse.com>, shuah <shuah@kernel.org>, x86 <x86@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, kvm <kvm@vger.kernel.org>
Message-ID: <20180730164237.PrX6At8qe8Xnfs6Q1_m7GOWR55EuCzNFQL9wyj930yM@z>

On 2018-07-29 07:42, Paolo Bonzini wrote:
>If the maintainers are okay with X86_FEATURE_HYGON that's certainly
>fine, however I think you can improve the consistency of the patches in
>a few ways.

Thanks for your suggestion.
To improve code consistency , will rework the patches.

>
>Lack of SME/SEV is not an issue, since there are AMD Zen chips without
>SME/SEV too, but potential incompatibility with future AMD fam18h chips
>is important.  Therefore, code like this one in amd_uncore_init
>
>
>-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
>+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
>+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
> return -ENODEV;
>
> if (!boot_cpu_has(X86_FEATURE_TOPOEXT))
> return -ENODEV;
>
>-	if (boot_cpu_data.x86 == 0x17) {
>+	if (boot_cpu_data.x86 == 0x17 || boot_cpu_data.x86 == 0x18) {
>
>should check explicitly for Hygon before checking for family 18h.  The
>same applies to the edac patch that I've just sent an answer to.

For the family number, As a JV company, to keep the consistency usage of
CPU family convention, Hygon will negotiate with AMD to make sure the CPU
family numbers both company used will not overlap. So as Hygon will use
the family 18h for Dhyana, AMD will skip the family 18h and directly use
family 19h for its new product.

Based on this assumption, this patch set direct check the family number
for 18h to see if it is Hygon processor to create a minimal patch set.

For the consistency, will modify the codes as follows:
-       if (boot_cpu_data.x86 == 0x17) {
+       if (boot_cpu_data.x86 == 0x17 ||
+          (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON &&
+           boot_cpu_data.x86 == 0x18)) {

>
>On the other hand, in many cases the AMD code is testing something like
>"AMD && family >= 0x0f".  In this case you have a mix of:
>
>- duplicate code for HYGON, such as modern_apic or mce_is_correctable
>
>- change the condition to (AMD || HYGON) && family >= 0x0f, such as
>k8_check_syscfg_dram_mod_en and amd_special_default_mtrr
>
>- change the condition to (AMD && family >= 0x0f) || (HYGON && family >=
>0x18), such as smp_quirk_init_udelay
>
>I couldn't find any case where you used (AMD && family >= 0x0f) ||
>HYGON, but I think it would be clearer in most cases than all the above
>three alternatives.

Your suggestion is correct, will try to make the code more consistent and
update the next patch set to use (AMD && family >= 0x0f) || HYGON.

>
>In general, I would duplicate code if and only if the AMD code is a maze
>of if/elseif/elseif.  In particular, code like this
>
>	case X86_VENDOR_AMD:
> if (msr >= MSR_F15H_PERF_CTL)
> return (msr - MSR_F15H_PERF_CTL) >> 1;
> return msr - MSR_K7_EVNTSEL0;
>+	case X86_VENDOR_HYGON:
>+	if (msr >= MSR_F15H_PERF_CTL)
>+	return (msr - MSR_F15H_PERF_CTL) >> 1;
>+	return msr - MSR_K7_EVNTSEL0;
>

>or this
>
>	case X86_VENDOR_AMD:
> rdmsr_on_cpu(cpu, MSR_K7_HWCR, &lo, &hi);
> msr = lo | ((u64)hi << 32);
> return !(msr & MSR_K7_HWCR_CPB_DIS);
>+	case X86_VENDOR_HYGON:
>+	rdmsr_on_cpu(cpu, MSR_K7_HWCR, &lo, &hi);
>+	msr = lo | ((u64)hi << 32);
>+	return !(msr & MSR_K7_HWCR_CPB_DIS);
>
>looks a bit silly, and you already have several cases when you are not
>introducing duplication (e.g. __mcheck_cpu_init_early).  On the other
>hand, code like xen_pmu_arch_init can be very simple for Hygon and so it
>may be useful to have a separate branch.

Thanks for the suggestion, will change this by directly reusing condition
check if reused codes are direct:
+	case X86_VENDOR_HYGON:
	case X86_VENDOR_AMD:
		if (msr >= MSR_F15H_PERF_CTR)
			return (msr - MSR_F15H_PERF_CTR) >> 1;
		return msr - MSR_K7_PERFCTR0;

Also will branch codes for Hygon in case of complicated checking condition
such as in xen_pmu_arch_init().

Thanks,
Pu Wen

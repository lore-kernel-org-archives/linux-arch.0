Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51170 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731480AbeG2BLH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 28 Jul 2018 21:11:07 -0400
Subject: Re: [PATCH v2 01/17] x86/cpu: create Dhyana init file and register
 new cpu_dev to system
References: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
 <1532352037-7151-2-git-send-email-puwen@hygon.cn>
 <ed090643-09da-cde7-6edd-970d973afd4d@redhat.com>
 <201807290021145963620@hygon.cn>
From: Paolo Bonzini <bonzini@gnu.org>
Message-ID: <bd73d865-acb3-66e5-a37a-dc4859e5f002@gnu.org>
Date: Sun, 29 Jul 2018 01:42:46 +0200
MIME-Version: 1.0
In-Reply-To: <201807290021145963620@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "puwen@hygon.cn" <puwen@hygon.cn>, tglx <tglx@linutronix.de>, bp <bp@alien8.de>, "thomas.lendacky" <thomas.lendacky@amd.com>, mingo <mingo@redhat.com>, hpa <hpa@zytor.com>, peterz <peterz@infradead.org>, "tony.luck" <tony.luck@intel.com>, rkrcmar <rkrcmar@redhat.com>, "boris.ostrovsky" <boris.ostrovsky@oracle.com>, jgross <jgross@suse.com>, rjw <rjw@rjwysocki.net>, lenb <lenb@kernel.org>, "viresh.kumar" <viresh.kumar@linaro.org>, mchehab <mchehab@kernel.org>, trenn <trenn@suse.com>, shuah <shuah@kernel.org>, x86 <x86@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, kvm <kvm@vger.kernel.org>
Message-ID: <20180728234246.qgLkIvg7ofhoLM6gH3yEOzXBM5SjeA7yMdAoWGPAOTs@z>

On 28/07/2018 18:48, puwen@hygon.cn wrote:
> Hi Paolo,
> 
> Thanks for your feedback.
> 
> As we described in the patch description, current Hygon Family 18h share
> most architecture with AMD Family 17h. But Hygon Family 18h are not the
> same with AMD family 17h, as it removed some features such as SME/SEV in
> Dhyana.

If the maintainers are okay with X86_FEATURE_HYGON that's certainly
fine, however I think you can improve the consistency of the patches in
a few ways.

Lack of SME/SEV is not an issue, since there are AMD Zen chips without
SME/SEV too, but potential incompatibility with future AMD fam18h chips
is important.  Therefore, code like this one in amd_uncore_init


-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return -ENODEV;

 	if (!boot_cpu_has(X86_FEATURE_TOPOEXT))
 		return -ENODEV;

-	if (boot_cpu_data.x86 == 0x17) {
+	if (boot_cpu_data.x86 == 0x17 || boot_cpu_data.x86 == 0x18) {

should check explicitly for Hygon before checking for family 18h.  The
same applies to the edac patch that I've just sent an answer to.

On the other hand, in many cases the AMD code is testing something like
"AMD && family >= 0x0f".  In this case you have a mix of:

- duplicate code for HYGON, such as modern_apic or mce_is_correctable

- change the condition to (AMD || HYGON) && family >= 0x0f, such as
k8_check_syscfg_dram_mod_en and amd_special_default_mtrr

- change the condition to (AMD && family >= 0x0f) || (HYGON && family >=
0x18), such as smp_quirk_init_udelay

I couldn't find any case where you used (AMD && family >= 0x0f) ||
HYGON, but I think it would be clearer in most cases than all the above
three alternatives.

In general, I would duplicate code if and only if the AMD code is a maze
of if/elseif/elseif.  In particular, code like this

	case X86_VENDOR_AMD:
 		if (msr >= MSR_F15H_PERF_CTL)
 			return (msr - MSR_F15H_PERF_CTL) >> 1;
 		return msr - MSR_K7_EVNTSEL0;
+	case X86_VENDOR_HYGON:
+		if (msr >= MSR_F15H_PERF_CTL)
+			return (msr - MSR_F15H_PERF_CTL) >> 1;
+		return msr - MSR_K7_EVNTSEL0;

or this

	case X86_VENDOR_AMD:
 		rdmsr_on_cpu(cpu, MSR_K7_HWCR, &lo, &hi);
 		msr = lo | ((u64)hi << 32);
 		return !(msr & MSR_K7_HWCR_CPB_DIS);
+	case X86_VENDOR_HYGON:
+		rdmsr_on_cpu(cpu, MSR_K7_HWCR, &lo, &hi);
+		msr = lo | ((u64)hi << 32);
+		return !(msr & MSR_K7_HWCR_CPB_DIS);

looks a bit silly, and you already have several cases when you are not
introducing duplication (e.g. __mcheck_cpu_init_early).  On the other
hand, code like xen_pmu_arch_init can be very simple for Hygon and so it
may be useful to have a separate branch.

Thanks,

Paolo

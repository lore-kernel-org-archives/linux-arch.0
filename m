Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36948 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbeHLMdO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Aug 2018 08:33:14 -0400
MIME-Version: 1.0
References: <cover.1533989492.git.puwen@hygon.cn> <36b1edf4bd9e203f8e14fa5b90a5a197fdf13898.1533989493.git.puwen@hygon.cn>
In-Reply-To: <36b1edf4bd9e203f8e14fa5b90a5a197fdf13898.1533989493.git.puwen@hygon.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 12 Aug 2018 11:55:34 +0200
Message-ID: <CAJZ5v0izyq2SoUspLPDRM9U7W+-bZPCcQ4C5Zu1hVFDoUj=w1g@mail.gmail.com>
Subject: Re: [PATCH v3 15/17] driver/cpufreq: enable Hygon support to cpufreq driver
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: puwen@hygon.cn
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, thomas.lendacky@amd.com, Borislav Petkov <bp@alien8.de>, Paolo Bonzini <pbonzini@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Message-ID: <20180812095534.Yj9BSggv8bqThXnggkOFLfkq7-1cnGeVo953fexQgLk@z>

On Sat, Aug 11, 2018 at 3:36 PM Pu Wen <puwen@hygon.cn> wrote:
>
> Enable ACPI cpufreq driver support for Hygon by adding family ID check
> along with AMD.
>
> As Hygon platforms have SMBus device(PCI device ID 0x790b), enable Hygon
> support to function amd_freq_sensitivity_init().
>
> Signed-off-by: Pu Wen <puwen@hygon.cn>

Is there any technical difference between HYGON and AMD?

You seem to be mechanically adding X86_VENDOR_HYGON wherever
X86_VENDOR_AMD is used.

> ---
>  drivers/cpufreq/acpi-cpufreq.c         | 5 +++++
>  drivers/cpufreq/amd_freq_sensitivity.c | 9 +++++++--
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index b61f4ec..d62fd37 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -61,6 +61,7 @@ enum {
>
>  #define INTEL_MSR_RANGE                (0xffff)
>  #define AMD_MSR_RANGE          (0x7)
> +#define HYGON_MSR_RANGE                (0x7)
>
>  #define MSR_K7_HWCR_CPB_DIS    (1ULL << 25)
>
> @@ -95,6 +96,7 @@ static bool boost_state(unsigned int cpu)
>                 rdmsr_on_cpu(cpu, MSR_IA32_MISC_ENABLE, &lo, &hi);
>                 msr = lo | ((u64)hi << 32);
>                 return !(msr & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
> +       case X86_VENDOR_HYGON:
>         case X86_VENDOR_AMD:
>                 rdmsr_on_cpu(cpu, MSR_K7_HWCR, &lo, &hi);
>                 msr = lo | ((u64)hi << 32);
> @@ -113,6 +115,7 @@ static int boost_set_msr(bool enable)
>                 msr_addr = MSR_IA32_MISC_ENABLE;
>                 msr_mask = MSR_IA32_MISC_ENABLE_TURBO_DISABLE;
>                 break;
> +       case X86_VENDOR_HYGON:
>         case X86_VENDOR_AMD:
>                 msr_addr = MSR_K7_HWCR;
>                 msr_mask = MSR_K7_HWCR_CPB_DIS;
> @@ -225,6 +228,8 @@ static unsigned extract_msr(struct cpufreq_policy *policy, u32 msr)
>
>         if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
>                 msr &= AMD_MSR_RANGE;
> +       else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
> +               msr &= HYGON_MSR_RANGE;
>         else
>                 msr &= INTEL_MSR_RANGE;
>
> diff --git a/drivers/cpufreq/amd_freq_sensitivity.c b/drivers/cpufreq/amd_freq_sensitivity.c
> index be926d9..4ac7c3c 100644
> --- a/drivers/cpufreq/amd_freq_sensitivity.c
> +++ b/drivers/cpufreq/amd_freq_sensitivity.c
> @@ -111,11 +111,16 @@ static int __init amd_freq_sensitivity_init(void)
>  {
>         u64 val;
>         struct pci_dev *pcidev;
> +       unsigned int pci_vendor;
>
> -       if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
> +       if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
> +               pci_vendor = PCI_VENDOR_ID_AMD;
> +       else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
> +               pci_vendor = PCI_VENDOR_ID_HYGON;
> +       else
>                 return -ENODEV;
>
> -       pcidev = pci_get_device(PCI_VENDOR_ID_AMD,
> +       pcidev = pci_get_device(pci_vendor,
>                         PCI_DEVICE_ID_AMD_KERNCZ_SMBUS, NULL);
>
>         if (!pcidev) {
> --
> 2.7.4
>

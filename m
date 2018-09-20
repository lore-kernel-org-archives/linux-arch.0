Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp17.cstnet.cn ([159.226.251.17]:37088 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbeITNrs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Sep 2018 09:47:48 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v6 07/16] x86/pci: Add Hygon Dhyana support to PCI and
 north bridge
References: <cover.1536550549.git.puwen@hygon.cn>
 <035e5d0a4f2a0edf68ca0f1019e47b878eaa5da6.1536550550.git.puwen@hygon.cn>
 <d05c7aa5-05ba-5ac2-c70f-414d9539925f@amd.com>
Message-ID: <b44e0656-7d57-3f9e-03fb-1dcf04091cdc@hygon.cn>
Date: Thu, 20 Sep 2018 16:05:07 +0800
MIME-Version: 1.0
In-Reply-To: <d05c7aa5-05ba-5ac2-c70f-414d9539925f@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "tglx@linutronix.de" <tglx@linutronix.de>
Cc: "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "helgaas@kernel.org" <helgaas@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Message-ID: <20180920080507.JZXT--DMjsMoRC5PjObSqdJwyMAXEDlmXdsUt6Jbqhk@z>

On 2018/9/20 1:20, Lendacky, Thomas wrote:
>> @@ -197,12 +212,25 @@ int amd_cache_northbridges(void)
>>   	u16 i = 0;
>>   	struct amd_northbridge *nb;
>>   	struct pci_dev *root, *misc, *link;
>> +	const struct pci_device_id *root_ids = NULL;
>> +	const struct pci_device_id *misc_ids = NULL;
>> +	const struct pci_device_id *link_ids = NULL;
>> +
>> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
>> +		root_ids = amd_root_ids;
>> +		misc_ids = amd_nb_misc_ids;
>> +		link_ids = amd_nb_link_ids;
>> +	} else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
>> +		root_ids = hygon_root_ids;
>> +		misc_ids = hygon_nb_misc_ids;
>> +		link_ids = hygon_nb_link_ids;
>> +	}
>
> To be compatible with "before this patch" you should probably do:
>
> 	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
> 		root_ids = hygon_root_ids;
> 		misc_ids = hygon_nb_misc_ids;
> 		link_ids = hygon_nb_link_ids;
> 	} else {
> 		root_ids = amd_root_ids;
> 		misc_ids = amd_nb_misc_ids;
> 		link_ids = amd_nb_link_ids;
> 	}
>
> That way they are always the AMD values if not your chip.
>
...
>> @@ -263,9 +291,15 @@ bool __init early_is_amd_nb(u32 device)
>>   {
>>   	const struct pci_device_id *id;
>>   	u32 vendor = device & 0xffff;
>> +	const struct pci_device_id *misc_ids = NULL;
>> +
>> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
>> +		misc_ids = amd_nb_misc_ids;
>> +	else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
>> +		misc_ids = hygon_nb_misc_ids;
>
> Same comment as above.  This will probably eliminate the PANIC that
> that was reported by LKP.

Yes, it's this modification that caused the PANIC reported by LKP.
Because the misc_ids will be NULL if running on Intel chip.

If change the vendor checking like this:

+	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+		misc_ids = hygon_nb_misc_ids;
+	else
+		misc_ids = amd_nb_misc_ids;

The PANIC will be eliminated.

The PANIC will also be eliminated by adding AMD vendor checking in
amd_gart_present:

+	if(boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+		return false;

To prevent the function return true on non AMD platform.

Thanks,
Pu Wen

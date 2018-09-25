From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v8 07/16] x86/pci: Add Hygon Dhyana support to PCI and
 north bridge
Date: Tue, 25 Sep 2018 20:27:15 +0800
Message-ID: <8ed72e5f-c85c-67f6-67e9-460ef99ab372@hygon.cn>
References: <cover.1537533368.git.puwen@hygon.cn>
 <580dc519d37ad9257520fe8c533f2c61d3e0cd83.1537533369.git.puwen@hygon.cn>
 <20180924152448.GE20187@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924152448.GE20187@zn.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, helgaas@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 2018/9/24 23:24, Borislav Petkov wrote:
>> diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
>> index fddb6d2..1ae4e57 100644
>> --- a/arch/x86/include/asm/amd_nb.h
>> +++ b/arch/x86/include/asm/amd_nb.h
>> @@ -103,6 +103,9 @@ static inline u16 amd_pci_dev_to_node_id(struct pci_dev *pdev)
>>   
>>   static inline bool amd_gart_present(void)
>>   {
>> +	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
>> +		return false;
>> +
> 
> What is that for?
> 
> Hygon doesn't have F15h so that function will return false there too...

This modification is used to solve the 0day PANIC occurred on Intel
platform. The function will always return false when running on Hygon
Dhyana platform, but will return true on Intel platform with CPU family
0xf/0x10/0x15.
Then the Intel CPU will run through early_gart_iommu_check and call
early_is_amd_nb, but misc_ids for Intel in patch v7 Is NULL so there
will be a PANIC:
[    0.839894] RIP: 0010:early_is_amd_nb+0x30/0x4b
...
[    0.976358] Call Trace:
[    0.980238]  ? early_gart_iommu_check+0xef/0x2c5
[    0.987493]  ? setup_arch+0x4fa/0xc67
[    0.993231]  ? printk+0x52/0x6e
[    0.998157]  ? start_kernel+0x6e/0x4dc
[    1.004044]  ? load_ucode_bsp+0x42/0x12e
[    1.010145]  ? secondary_startup_64+0xa4/0xb0

> ... or is that because the qemu script you got from the 0day bot guys
> uses -cpu kvm64 which is family 0xf:
> 
> [    0.214353] smpboot: CPU0: AMD Common KVM processor (family: 0xf, model: 0x6, stepping: 0x1)
> 
> ?
> 
> and that makes amd_gart_present() say yes.
> In that case, please make a *prepatch* which adds the vendor check to
> both amd_gart_present() and early_is_amd_nb() and send it as a reply to
> this message.

OK, I'll make a separate prepatch for this change.

> 
> *Then*, do this patch ontop and also as a reply.

Do you mean do the follow change on top of the prepatch?

>> @@ -197,12 +212,25 @@ int amd_cache_northbridges(void)
>>   	u16 i = 0;
>>   	struct amd_northbridge *nb;
>>   	struct pci_dev *root, *misc, *link;
>> +	const struct pci_device_id *root_ids = NULL;
>> +	const struct pci_device_id *misc_ids = NULL;
>> +	const struct pci_device_id *link_ids = NULL;
>> +
>> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
>> +		root_ids = hygon_root_ids;
>> +		misc_ids = hygon_nb_misc_ids;
>> +		link_ids = hygon_nb_link_ids;
>> +	} else {
>> +		root_ids = amd_root_ids;
>> +		misc_ids = amd_nb_misc_ids;
>> +		link_ids = amd_nb_link_ids;
>> +	}
> 
> Also, you can make this assignment differently:
> 
> 	const struct pci_device_id *root_ids = amd_root_ids;
> 	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
> 	const struct pci_device_id *link_ids = amd_nb_link_ids;
> 
> 
> 	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
> 		root_ids = hygon_root_ids;
> 		misc_ids = hygon_nb_misc_ids;
> 		link_ids = hygon_nb_link_ids;
> 	}
> 
> This way the change is obvious and it is only for Hygon without
> affecting the other vendors.
> 
> Ditto for the other assignment.

All right, I will change these in the next version patch set.

Thanks,
Pu Wen

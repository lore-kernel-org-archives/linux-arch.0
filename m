From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v3 13/17] x86/xen: enable Hygon support to Xen
Date: Thu, 16 Aug 2018 21:29:13 +0800
Message-ID: <16c21c53-2a03-d5fe-9232-8c0e377566a7@hygon.cn>
References: <cover.1533989492.git.puwen@hygon.cn>
 <2747ad959f07459000f2693a98d237e2b3149ca1.1533989493.git.puwen@hygon.cn>
 <b32887e0-df6e-fb31-d9cd-6b31961c9c2b@oracle.com>
 <0aa44410-47ec-27e2-10d9-c0dc5d2e457a@suse.com>
 <150f6a8d-33e8-a84d-f34b-17bdb7264ebe@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <150f6a8d-33e8-a84d-f34b-17bdb7264ebe@oracle.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de, pbonzini@redhat.com, JBeulich@suse.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, xen-devel@lists.xenproject.org
List-Id: linux-arch.vger.kernel.org

On 2018/8/12 21:26, Boris Ostrovsky wrote:
> On 08/12/2018 04:55 AM, Juergen Gross wrote:
>> On 11/08/18 16:34, Boris Ostrovsky wrote:
>>> On 08/11/2018 09:29 AM, Pu Wen wrote:
>>>>   bool pmu_msr_read(unsigned int msr, uint64_t *val, int *err)
>>>>   {
>>>> -	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
>>>> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
>>>> +	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
>>>
>>> 'if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)' please.
>> Really? Xen supports Centaur, too.
> 
> VPMU doesn't --- hypervisor will not initialize it. Besides, the
> existing code will steer non-AMD execution to Intel, which is not right
> either.
> 
> I'll add a check to bail if VPMU is not initialized properly, we seem to
> ignore xen_pmu_init() failures. Which, BTW, makes this patch rather
> pointless until there is support for Hygon Xen.

So should it still need to test vendor Hygon here or wait for your check
done?

Thanks,
Pu Wen

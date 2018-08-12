Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:47252 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbeHLQFS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Aug 2018 12:05:18 -0400
Subject: Re: [PATCH v3 13/17] x86/xen: enable Hygon support to Xen
References: <cover.1533989492.git.puwen@hygon.cn>
 <2747ad959f07459000f2693a98d237e2b3149ca1.1533989493.git.puwen@hygon.cn>
 <b32887e0-df6e-fb31-d9cd-6b31961c9c2b@oracle.com>
 <0aa44410-47ec-27e2-10d9-c0dc5d2e457a@suse.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <150f6a8d-33e8-a84d-f34b-17bdb7264ebe@oracle.com>
Date: Sun, 12 Aug 2018 09:26:58 -0400
MIME-Version: 1.0
In-Reply-To: <0aa44410-47ec-27e2-10d9-c0dc5d2e457a@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Juergen Gross <jgross@suse.com>, Pu Wen <puwen@hygon.cn>, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de, pbonzini@redhat.com, JBeulich@suse.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, xen-devel@lists.xenproject.org
Message-ID: <20180812132658.-4Elorgo68vHipQiiFG2sMDFxqRJnhHE_63it4s5jtc@z>

On 08/12/2018 04:55 AM, Juergen Gross wrote:
> On 11/08/18 16:34, Boris Ostrovsky wrote:
>> On 08/11/2018 09:29 AM, Pu Wen wrote:
>>
>>>  
>>>  bool pmu_msr_read(unsigned int msr, uint64_t *val, int *err)
>>>  {
>>> -	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
>>> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
>>> +	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
>>
>> 'if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)' please.
> Really? Xen supports Centaur, too.

VPMU doesn't --- hypervisor will not initialize it. Besides, the
existing code will steer non-AMD execution to Intel, which is not right
either.

I'll add a check to bail if VPMU is not initialized properly, we seem to
ignore xen_pmu_init() failures. Which, BTW, makes this patch rather
pointless until there is support for Hygon Xen.

-boris

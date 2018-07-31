Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34889 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeGaJRs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Jul 2018 05:17:48 -0400
Received: by mail-wm0-f68.google.com with SMTP id o18-v6so2014076wmc.0
        for <linux-arch@vger.kernel.org>; Tue, 31 Jul 2018 00:38:47 -0700 (PDT)
Subject: Re: [PATCH v2 16/17] driver/edac: enable Hygon support to AMD64 EDAC
 driver
References: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
 <1532352037-7151-17-git-send-email-puwen@hygon.cn>
 <b24739e8-0833-8509-0850-815758accaee@redhat.com>
 <c8f53708-bd57-fb41-8300-115ac5083094@hygon.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1360de2a-5aae-bfd7-ced1-f707b29e7b1f@redhat.com>
Date: Tue, 31 Jul 2018 09:38:43 +0200
MIME-Version: 1.0
In-Reply-To: <c8f53708-bd57-fb41-8300-115ac5083094@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pu Wen <puwen@hygon.cn>, tglx@linutronix.de, bp@alien8.de, thomas.lendacky@amd.com, mingo@redhat.com, hpa@zytor.com, peterz@infradead.org, tony.luck@intel.com, rkrcmar@redhat.com, boris.ostrovsky@oracle.com, jgross@suse.com, rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org, mchehab@kernel.org, trenn@suse.com, shuah@kernel.org, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org
Message-ID: <20180731073843.SrXLHeeEWYwoU8_Ir3Kb8FkDRXXh7REFSHF1YD99Qfk@z>

On 30/07/2018 18:43, Pu Wen wrote:
> On 2018-07-29 07:42, Paolo Bonzini wrote:
>> On 23/07/2018 15:20, Pu Wen wrote:
>>>  scrubval = scrubrates[i].scrubval;
>>>
>>> -    if (pvt->fam == 0x17) {
>>> +    if (pvt->fam == 0x17 || pvt->fam == 0x18) {
>>>  __f17h_set_scrubval(pvt, scrubval);
>>>  } else if (pvt->fam == 0x15 && pvt->model == 0x60) {
>>>  f15h_select_dct(pvt, 0);
>>
>> This, and many other occurrences in this file, should in my opinion
>> avoid testing family 18h without also checking for Hygon as a vendor.
>> You probably need to add a vendor field to struct amd64_pvt and
>> initialize it in per_family_init.
> 
> Thanks for the suggestion.
> 
> As AMD and Hygon will negotiate the usage of CPU family number
> to make sure the unique of family numbers in both company's processors.
> As Hygon will use family 18h for Dhyana, AMD will not use family 18h
> and jump to family 19h for new product. So if family number if 18h,
> processor should be Hygon Dhyana. Based on this assumption, we created
> this patch set.

But if that's the case, it doesn't make sense to have a new vendor!  If
AMD's 17h and Hygon's 18h ever diverge, you could always choose the
right behavior based on the family, without checking the vendor.

However, if the x86 maintainers prefer to have a new X86_VENDOR_*
constant, I'd just ignore the fact that AMD will skip family 18h, and
introduce vendor checks along the lines below.  This has the advantage
that it's not an issue if AMD ends up _not_ skipping family 18h.

> If the vendor field is added to amd64_pvt, and check the vendor in 0x18
> codes, then the codes may like:
> -    if (pvt->fam == 0x17) {
> +    if (pvt->fam == 0x17 || pvt->vendor == X86_VENDOR_HYGON) {
> 
> switch cases will be modified similar to:
> +    case 0x18:
> +        if(pvt->vendor == X86_VENDOR_HYGON) {
> +            fam_type    = &family_types[HYGON_F18_CPUS];
> +            pvt->ops    = &family_types[HYGON_F18_CPUS].ops;
> +            break;
> +        }
> +

Either that, or

	if (pvt->vendor == X86_VENDOR_AMD) {
		...
	} else {
		fam_type = &family_types[HYGON_F18_CPUS];
		pvt->ops = &family_types[HYGON_F18_CPUS].ops;
		break;
	}

Paolo

Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp20.cstnet.cn ([159.226.251.20]:56687 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726355AbeIDR6J (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 4 Sep 2018 13:58:09 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v5 05/16] x86/pmu: enable Hygon support to PMU
 infrastructure
References: <cover.1535459012.git.puwen@hygon.cn>
 <dcd5b900e26e3175e4cafded91ec28e53c79adf8.1535459013.git.puwen@hygon.cn>
 <20180904104812.GF32615@zn.tnic>
Message-ID: <f97a0b69-3117-3f59-257e-3aa837f54444@hygon.cn>
Date: Tue, 4 Sep 2018 21:32:41 +0800
MIME-Version: 1.0
In-Reply-To: <20180904104812.GF32615@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20180904133241.zmuhR1baXLpc4Elqz_oNnwl83oLNBurscQ8wny86Jsg@z>

On 2018/9/4 18:48, Borislav Petkov wrote:
> On Wed, Aug 29, 2018 at 08:43:54PM +0800, Pu Wen wrote:
>> Hygon PMU arch is similar to AMD Family 17h. To support Hygon PMU, the
>> initialization flow for it just call amd_pmu_init() and change PMU name
>
> That sentence reads funny.

Will rewrite this sentence to make it more understandable. :)

> In general, you seem to be explaining *what* your patches do and not
> *why*. This is the wrong. Always explain the *why* - the *what* is
> visible from the diff.
>
> You probably need to brush up on
> Documentation/process/submitting-patches.rst, section 2.

All right, will relearn the document and rework the patch descriptions.

>> +	case 0x18:
>> +		if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
>> +			pr_cont("Fam18h ");
>
> Didn't we agree that you'll verify whether family 0x18 is going to be
> Hygon only?
>
> What happened to that checking?
...
> Same here.
>
> What's up?

Will remove all the remaining unneeded Hygon vendor checking through
the whole patch set to minimize the code modification.

Thanks,
Pu Wen

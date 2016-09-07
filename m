Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2nam01on0048.outbound.protection.outlook.com ([104.47.34.48]:48544
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756625AbcIGOEC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Sep 2016 10:04:02 -0400
Subject: Re: [RFC PATCH v2 03/20] x86: Secure Memory Encryption (SME) build
 enablement
References: <20160822223529.29880.50884.stgit@tlendack-t1.amdoffice.net>
 <20160822223559.29880.1502.stgit@tlendack-t1.amdoffice.net>
 <20160902110351.GA22559@nazgul.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <5a8e2455-ef08-9e3f-2847-082fd3e01e67@amd.com>
Date: Wed, 7 Sep 2016 09:03:46 -0500
MIME-Version: 1.0
In-Reply-To: <20160902110351.GA22559@nazgul.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20160907140346.k5byFfcR57veTL3rGD-SHEOi6ORnBWI0lhHk-rlqF_A@z>

On 09/02/2016 06:03 AM, Borislav Petkov wrote:
> On Mon, Aug 22, 2016 at 05:35:59PM -0500, Tom Lendacky wrote:
>> Provide the Kconfig support to build the SME support in the kernel.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>  arch/x86/Kconfig |    9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index c580d8c..131f329 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -1357,6 +1357,15 @@ config X86_DIRECT_GBPAGES
>>  	  supports them), so don't confuse the user by printing
>>  	  that we have them enabled.
>>  
>> +config AMD_MEM_ENCRYPT
>> +	bool "Secure Memory Encryption support for AMD"
> 
> 	     "AMD Secure Memory Encryption support"

Ok.

Thanks,
Tom

> 
>> +	depends on X86_64 && CPU_SUP_AMD
>> +	---help---
>> +	  Say yes to enable the encryption of system memory. This requires
>> +	  an AMD processor that supports Secure Memory Encryption (SME).
>> +	  The encryption of system memory is disabled by default but can be
>> +	  enabled with the mem_encrypt=on command line option.
>> +
>>  # Common NUMA Features
>>  config NUMA
>>  	bool "Numa Memory Allocation and Scheduler Support"
> 

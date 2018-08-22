Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp20.cstnet.cn ([159.226.251.20]:39689 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728886AbeHVQny (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Aug 2018 12:43:54 -0400
Subject: Re: [PATCH v4 15/16] driver/edac: enable Hygon support to AMD64 EDAC
 driver
References: <cover.1534599097.git.puwen@hygon.cn>
 <6275a5a0a0cfbd2c1abc09a5bb41caabecd02e27.1534599097.git.puwen@hygon.cn>
 <20180821081331.GC24940@nazgul.tnic>
 <ccbc6572-c16f-7a9b-ab27-54fffac1ba0d@hygon.cn>
 <20180821112020.GB29972@nazgul.tnic>
 <6e17958a-6cd8-4c6c-c890-f5f48b084d6f@redhat.com>
 <20180821130430.GB30528@nazgul.tnic>
 <20180821180743.GA14431@atrey.karlin.mff.cuni.cz>
From: Pu Wen <puwen@hygon.cn>
Message-ID: <3be72c3c-1177-886f-8cbc-dec49905ca95@hygon.cn>
Date: Wed, 22 Aug 2018 21:18:40 +0800
MIME-Version: 1.0
In-Reply-To: <20180821180743.GA14431@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pavel Machek <pavel@ucw.cz>, Borislav Petkov <bp@alien8.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, mchehab@kernel.org, mikhail.jin@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-edac@vger.kernel.org
Message-ID: <20180822131840.OmM_hYuKlPpEgskyycWChOqkkVxvfTpb84onmdDZon4@z>

On 2018/8/22 2:07, Pavel Machek wrote>> But for right now I think we 
should strive to keep the changes as small
>> as possible and only do real splitting when they start adding new
>> functionality. Which would mean having a hygon_edac.c too, for example.
>>
>> All, IMHO, of course. Sharing code between vendors is always yucky.
> 
> Dunno, people do not know that 0x18 is reserved on AMD, so resulting
> code is quite confusing.
> 
> Explicit vendor check is way to go, long term.
> 									Pavel

Hi Pavel,

For amd64_edac_init() entry, there will be a x86_match_cpu(amd64_cpuids)
which checking whether amd64_edac module fit current CPU. Only Hygon has
registered X86_VENDOR_HYGON with family 0x18h in amd64_cpuids[] to use
AMD edac codes.

Also with the assumption that Hygon will negotiate with AMD that only
Hygon will use Family 18h. So we assume in later codes vendor checking
can be omitted.

You are right, for short term, we are trying to keep the tight change and
enable Dhyana with minimal effort. For long term, agreed with that.

So based on the assumption that only Hygon will use family 0x18, we will
rework the patch, make the assumption clear and try to keep it small.
If that's ok, we will rework this patch.

Thanks for all the suggestions.

Regards,
Pu Wen

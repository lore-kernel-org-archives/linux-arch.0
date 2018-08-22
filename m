From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v4 15/16] driver/edac: enable Hygon support to AMD64 EDAC
 driver
Date: Wed, 22 Aug 2018 21:07:20 +0800
Message-ID: <36de11c7-8448-2967-2032-ef31d8e8a979@hygon.cn>
References: <cover.1534599097.git.puwen@hygon.cn>
 <6275a5a0a0cfbd2c1abc09a5bb41caabecd02e27.1534599097.git.puwen@hygon.cn>
 <20180821081331.GC24940@nazgul.tnic>
 <ccbc6572-c16f-7a9b-ab27-54fffac1ba0d@hygon.cn>
 <20180821112020.GB29972@nazgul.tnic>
 <6e17958a-6cd8-4c6c-c890-f5f48b084d6f@redhat.com>
 <20180821130430.GB30528@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180821130430.GB30528@nazgul.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Paolo Bonzini <pbonzini@redhat.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, mchehab@kernel.org, mikhail.jin@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-edac@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 2018/8/21 21:04, Borislav Petkov wrote:
> On Tue, Aug 21, 2018 at 01:26:13PM +0200, Paolo Bonzini wrote:
>> But then I don't see the point of adding the Hygon vendor, since any
>> check can be simplified:
> 
> I think Hygon wanted to superficially show it is not really an AMD. For
> example, the Hygon thing doesn't do SME/SEV. AFAIK.
> 
> So we can just as well check only family but I'd say the vendor thing is
> laying the grounds for the future where reportedly it will differ more
> from an AMD. And then we can start splitting code more based on vendor
> and not look at family at all.
> 
> But for right now I think we should strive to keep the changes as small
> as possible and only do real splitting when they start adding new
> functionality. Which would mean having a hygon_edac.c too, for example.
> 
> All, IMHO, of course. Sharing code between vendors is always yucky.

Thanks for Boris's clarification.

It's hard to find the balance between short term(sharing codes) and long
term(splitting codes).
Current I think we'd better try to follow the following way:
For current version, we will try to minimize the modification and share
codes,
For later big modification, will try to split codes to make code path
more clear.

Regards
Pu Wen

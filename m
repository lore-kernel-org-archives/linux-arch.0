Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45476 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726590AbeHUOqH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Aug 2018 10:46:07 -0400
Subject: Re: [PATCH v4 15/16] driver/edac: enable Hygon support to AMD64 EDAC
 driver
References: <cover.1534599097.git.puwen@hygon.cn>
 <6275a5a0a0cfbd2c1abc09a5bb41caabecd02e27.1534599097.git.puwen@hygon.cn>
 <20180821081331.GC24940@nazgul.tnic>
 <ccbc6572-c16f-7a9b-ab27-54fffac1ba0d@hygon.cn>
 <20180821112020.GB29972@nazgul.tnic>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6e17958a-6cd8-4c6c-c890-f5f48b084d6f@redhat.com>
Date: Tue, 21 Aug 2018 13:26:13 +0200
MIME-Version: 1.0
In-Reply-To: <20180821112020.GB29972@nazgul.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>, Pu Wen <puwen@hygon.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, mchehab@kernel.org, mikhail.jin@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-edac@vger.kernel.org
Message-ID: <20180821112613.-0fWS1fqbrvPwFve0YSQvzeo1aW6tecgH9oE5ZxIU3A@z>

On 21/08/2018 13:20, Borislav Petkov wrote:
> On Tue, Aug 21, 2018 at 07:04:23PM +0800, Pu Wen wrote:
>> Sure, JV will negotiate with AMD and make sure only JV use family 18h and
>> AMD won't use family 0x18h, which will make the patch tight and clear.
>>
>> What's the best way to adapt for EDAC driver?
>> * To simplify the code based on AMD won't do family 0x18 and remove
>>   vendor checking.
> 
> That, provided AMD won't use family 0x18.
> 

But then I don't see the point of adding the Hygon vendor, since any
check can be simplified:

	(AMD || HYGON) -->
		AMD

	(AMD && fam = 17h) || (HYGON && fam = 18h) -->
		AMD && (fam = 17h || fam = 18h)

	(AMD && fam = 17h) || HYGON -->
		AMD && (fam = 17h || fam = 18h)

etc.  Anyway, I don't care much either way.

Paolo

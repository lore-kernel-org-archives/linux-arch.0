From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] frv: fix build failure
Date: Mon, 27 Nov 2017 10:25:16 -0800
Message-ID: <3a6fe86e-7a66-56df-3b1d-e2e8cd3e6eae@synopsys.com>
References: <1511302233-5008-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1511457437.32422.6.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:34070 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752566AbdK0S0S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Nov 2017 13:26:18 -0500
In-Reply-To: <1511457437.32422.6.camel@synopsys.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>

+CC linux-arch, Arnd

On 11/23/2017 09:17 AM, Alexey Brodkin wrote:
> Hi Sudip,
> 
> On Tue, 2017-11-21 at 22:10 +0000, Sudip Mukherjee wrote:
>> The frv defconfig build is failing with the error:
>> lib/mpi/mpih-div.o: In function `mpihelp_divrem':
>> mpih-div.c:(.text+0x30c): undefined reference to `abort'
>>
>> The function 'abort' was never defined for the frv architecture.
>> Create 'abort' as is done in other arch like 'arm' and 'unicore32'.
>>
>> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
>> ---
> 
> I'm seeing the same issue building for ARC from today's Linus' tree.

With which compiler ? Claudiu implemented __builtin_trap recently so ARC builds 
should not get abort() but a trap 5 instruction instead.

> Maybe it worth implementing abort() as a weak function for every arch/platform
> that doesn't have it explicitly defined? Otherwise we'll end-up with
> useless code duplication.

I understand the case/need for adding a weak/common abort() as a quick fix for 
handling such cases, but perhaps we should not and instead fix the rootcause. In 
this specific case, Claudiu mentioned that gcc was generating abort due to 
something like this (flagging a possible divide by zero due to 
-fno-isolate-erroneous-paths-dereference.

a;

fn1() {
   switch (a)
   case 0:
   return 1 / a;
}

Sudeep can you confirm that removing this hacking FRV build to not have this 
toggle fixes the abort issue.

So the offending code needs to be fixed as in the end when that code path is taken 
system is hosed.

-Vineet

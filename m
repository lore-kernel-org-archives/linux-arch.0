Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58080 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730306AbfLLS32 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Dec 2019 13:29:28 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBCIMBqs078598
        for <linux-arch@vger.kernel.org>; Thu, 12 Dec 2019 13:29:26 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wujxrj7w2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 12 Dec 2019 13:29:26 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 12 Dec 2019 18:29:24 -0000
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
References: <87blslei5o.fsf@mpe.ellerman.id.au>
 <20191206131650.GM2827@hirez.programming.kicks-ass.net>
 <875zimp0ay.fsf@mpe.ellerman.id.au>
 <20191212080105.GV2844@hirez.programming.kicks-ass.net>
 <20191212100756.GA11317@willie-the-truck>
 <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 12 Dec 2019 19:29:18 +0100
MIME-Version: 1.0
In-Reply-To: <20191212180634.GA19020@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-ID: <b37ce52d-89cc-5f2e-827d-c260e63152da@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, dja@axtens.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, Christophe Leroy <christophe.leroy@c-s.fr>, linux-arch <linux-arch@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Segher Boessenkool <segher@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20191212182918.sQotCPCaViFEIRcx24Wn60Q-a7p0HD4Suftfzx9Xk4I@z>



On 12.12.19 19:06, Will Deacon wrote:
> On Thu, Dec 12, 2019 at 09:41:32AM -0800, Linus Torvalds wrote:
>> On Thu, Dec 12, 2019 at 2:46 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>>
>>> +#ifdef GCC_VERSION < 40800
>>
>> Where does that 4.8 version check come from, and why?
>>
>> Yeah, I know, but this really wants a comment. Sadly it looks like gcc
>> bugzilla is down, so
>>
>>    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
>>
>> currently gives an "Internal Server Error" for me.
>>
>> [ Delete the horrid code we have because of gcc bugs ]
>>
>>> +#else /* GCC_VERSION < 40800 */
>>> +
>>> +#define READ_ONCE_NOCHECK(x)                                           \
>>> +({                                                                     \
>>> +       typeof(x) __x = *(volatile typeof(x))&(x);                      \
>>
>> I think we can/should just do this unconditionally if it helps th eissue.
> 
> I'm currently trying to solve the issue by removing volatile from the bitop
> function signatures, but it's grotty because there are quite a few callers
> to fix up. I'm still trying to do it, because removing volatile fields from
> structurs is generally a "good thing", but I'd be keen to simplify
> READ_ONCE() as you suggest regardless.

As I am the one who added the foundation of READ_ONCEs uglyness, I am now in
favour of re-simplifying it again. I was first a bit scared about re-introducing
bugs, but the gcc testsuite has this particular case covered, so hopefully we
should not see the issue with volatile and aggregate types again.

Christian

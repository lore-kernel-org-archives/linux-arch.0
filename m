From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
Date: Thu, 12 Dec 2019 19:29:18 +0100
Message-ID: <b37ce52d-89cc-5f2e-827d-c260e63152da@de.ibm.com>
References: <87blslei5o.fsf@mpe.ellerman.id.au>
 <20191206131650.GM2827@hirez.programming.kicks-ass.net>
 <875zimp0ay.fsf@mpe.ellerman.id.au>
 <20191212080105.GV2844@hirez.programming.kicks-ass.net>
 <20191212100756.GA11317@willie-the-truck>
 <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191212180634.GA19020@willie-the-truck>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, dja@axtens.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, Christophe Leroy <christophe.leroy@c-s.fr>, linux-arch <linux-arch@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Segher Boessenkool <segher@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org



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

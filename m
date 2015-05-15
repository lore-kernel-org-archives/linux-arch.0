From: Chris Metcalf <cmetcalf@ezchip.com>
Subject: Re: [PATCH 0/3] add new strscpy() API for string copy
Date: Fri, 15 May 2015 11:15:27 -0400
Message-ID: <55560D8F.60704@ezchip.com>
References: <1430409677-13284-1-git-send-email-cmetcalf@ezchip.com> <1431645018.2981.3.camel@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-am1on0067.outbound.protection.outlook.com ([157.56.112.67]:31264
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754101AbbEOPPn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 15 May 2015 11:15:43 -0400
In-Reply-To: <1431645018.2981.3.camel@ellerman.id.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Fabian Frederick <fabf@skynet.be>, Randy Dunlap <rdunlap@infradead.org>, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, gregkh@linuxfoundation.org, Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, Frederic Weisbecker <fweisbec@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Theodore Ts'o <tytso@mit.edu>, Grant Likely <grant.likely@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org

On 05/14/2015 07:10 PM, Michael Ellerman wrote:
> On Thu, 2015-04-30 at 12:01 -0400, Chris Metcalf wrote:
>> This patch series addresses limitations in strncpy() and strlcpy();
>> both the old APIs are unpleasant, as Linus nicely summarized here
>> a couple of days ago:
>>
>>    https://lkml.org/lkml/2015/4/28/570
>>
>> and of course as other folks (Greg K-H and Linus again) said last year:
>>
>>    https://plus.google.com/+gregkroahhartman/posts/1amLbuhWbh5
>>
>> The proposed new API (strscpy(), for "s"afe string copy) has an
>> easy-to-use API for detecting buffer overflow, avoids unsafe truncation
>> by default, and isn't subject to thread-safety attacks like the current
>> strlcpy implementation.  See patch 2/3 for more on why strscpy() is a
>> good thing.
> +1 on the concept.

Thanks.

>> To make strscpy() work more efficiently I did the minimum tweaking
>> necessary to allow <asm/word-at-a-time.h> to work on all architectures,
>> though of course individual maintainers can still make their versions
>> more efficient as needed.
>>
>> It's likely not necessary for per-architecture implementations of
>> strscpy() to be written, but I stuck with the standard __HAVE_ARCH_XXX
>> model just for consistency with the rest of <linux/string.h>.
>>
>> I tested the implementation with a simple user-space harness, so I
>> believe it is correct for the corner cases I could think of.  In
>> particular I pairwise-tested all the unaligned values of source and
>> dest, and tested the restriction on src page-crossing at all
>> unaligned offsets approaching the page boundary.
> Can you please put that in tools/testing/selftests and merge it as part of the
> series? That way I can run the tests and be confident it works on powerpc.

Unfortunately, the strscpy patch series only changes the one previous
user of the API, which is a tile-architecture-only driver piece, not
particularly useful for anyone else for testing.

The testing I did pulled strscpy() and word-at-a-time out into a
separate, standalone userspace implementation, and tested it there,
rather than doing tests through the syscall API like 
tools/testing/selftests.
So I don't really see a way of committing my test framework, other
than as a real Kconfig-enabled boot-time self-test or some such;
I can certainly do that but I don't know how excited people are to
have that additional level of source-code and Kconfig bloat.

-- 
Chris Metcalf, EZChip Semiconductor
http://www.ezchip.com

From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: + x86-avoid-constant_test_bit-misoptimization-due-to-cast-to-non-volatile.patch
 added to -mm tree
Date: Thu, 23 Sep 2010 17:23:50 -0700
Message-ID: <4C9BEF96.50800@zytor.com>
References: <201009232351.o8NNpsxB026809@imap1.linux-foundation.org> <AANLkTi=QOC22E2WCc7MW+FST2edA5KJ7iOrTSqPeE+A+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:41584 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753032Ab0IXAZF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 23 Sep 2010 20:25:05 -0400
In-Reply-To: <AANLkTi=QOC22E2WCc7MW+FST2edA5KJ7iOrTSqPeE+A+@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: akpm@linux-foundation.org, mm-commits@vger.kernel.org, led@altlinux.ru, gcosta@redhat.com, ledest@gmail.com, mike@osdn.org.ua, mingo@elte.hu, tglx@linutronix.de, volodymyrgl@gmail.com, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On 09/23/2010 05:08 PM, Linus Torvalds wrote:
> On Thu, Sep 23, 2010 at 4:51 PM,  <akpm@linux-foundation.org> wrote:
>>
>> Subject: x86: avoid 'constant_test_bit()' misoptimization due to cast to non-volatile
>> From: Led <led@altlinux.ru>
>>
>> While debugging bit_spin_lock() hang, it was tracked down to gcc-4.4
>> misoptimization of constant_test_bit() when 'const volatile unsigned long *addr'
>> cast to 'unsigned long *' with subsequent unconditional jump to pause
>> (and not to the test) leading to hang.
> 
> Ack on the patch, however I think the commit message shouldn't make
> this sound so much like a compiler bug. I think the cast to "unsigned
> long *" is simply wrong, exactly because it makes it valid for the
> compiler to merge multiple bit tests. And like it or not, our historic
> semantics for our bitops are that they are valid on volatile data.
> 
> That said, it's really sad how this will make 'test_bit()' potentially
> suck horribly and cause reloads when not necessary. We should probably
> (re-)introduce a __test_bit() operation that - like __set_bit and
> __clear_bit() works on things that are otherwise locked and can avoid
> reloading the value.
> 
> I dunno. Maybe we don't have a lot of users of 'test_bit()' that would
> actually care. How much does it cost us to have that volatile access?
> 

Somewhat offtopic...

On the general subject of bit operators, I'm wondering if we should
change the bit index to "unsigned long" like it already is on sparc64;
most other architectures have it as "int".  This already causes failures
if we have more than 16 TiB bytes of RAM in a single node -- not exactly
urgent stuff but something that might be an issue long term, especially
for a gigantic all-interleaved-memory machine.  I did try this on x86 a
while ago and found that it did added less than a kilobyte to the size
of the allyesconfig x86-64 kernel (unless my memory fails me.)

	-hpa

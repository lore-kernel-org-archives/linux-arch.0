From: Chris Metcalf <cmetcalf@ezchip.com>
Subject: Re: [RFC][PATCH 23/24] atomic: Collapse all atomic_{set,clear}_mask
 definitions
Date: Fri, 10 Jul 2015 15:45:46 -0400
Message-ID: <55A020EA.9060000@ezchip.com>
References: <20150709172855.564686637@infradead.org> <20150709175310.229218215@infradead.org> <CAMuHMdXePQF9BL7OfTz+=FN5Hg9C=E6hAO8MFQ9Eu_tiK_Q8OA@mail.gmail.com> <20150710103945.GH19282@twins.programming.kicks-ass.net> <559FC9CC.6000400@ezchip.com> <20150710134256.GS7557@n2100.arm.linux.org.uk> <20150710162739.GN19282@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-db3on0053.outbound.protection.outlook.com ([157.55.234.53]:49472
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932290AbbGJTqD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 10 Jul 2015 15:46:03 -0400
In-Reply-To: <20150710162739.GN19282@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Vineet Gupta <vgupta@synopsys.com>, Will Deacon <will.deacon@arm.com>, =?windows-1252?Q?H=E5vard_Skinnemoen?= <hskinnemoen@gmail.com>, Miao Steven <realmz6@gmail.com>, David Howells <dhowells@redhat.com>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@kernel.org>

On 07/10/2015 12:27 PM, Peter Zijlstra wrote:
> On Fri, Jul 10, 2015 at 02:42:56PM +0100, Russell King - ARM Linux wrote:
>> The obvious question though is whether we have an established name for this
>> operation elsewhere in the kernel, and whether we should have consistency.
> Consistency is good.
>
>> In include/linux, we already have (grepping for 'and_*not'):
>>
>> include/linux/nodemask.h:#define nodes_andnot(dst, src1, src2) \
>> include/linux/bitmap.h:extern int __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
>> include/linux/cpumask.h:static inline int cpumask_andnot(struct cpumask *dstp,
>>
>> We also have:
>>
>> include/linux/signal.h:#define _sig_andn(x,y)       ((x) & ~(y))
>>
>> which seems to be the only instance of "andn" in include/.
> How about I rename the _sig_andn one to _sig_andnot, and go with
> atomic_andnot, to match the *mask functions.

On further examination, there is also FUTEX_OP_ANDN, which is originally 
what
inspired me to use the name atomic_andn().  So I think churning the 
nomenclature
around for tilepro isn't really particularly helpful, and I won't bother.

In any case I think "andn" and "andnot" are both fine names for 
atomic_xxx :-)

-- 
Chris Metcalf, EZChip Semiconductor
http://www.ezchip.com

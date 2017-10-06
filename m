From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH v3] membarrier: provide core serialization
Date: Fri, 6 Oct 2017 20:57:56 +0000 (UTC)
Message-ID: <2063294388.33291.1507323476486.JavaMail.zimbra@efficios.com>
References: <20170901161007.2661-1-mathieu.desnoyers@efficios.com> <20170901162547.GA20313@arm.com> <1051991998.1330.1504285238477.JavaMail.zimbra@efficios.com> <20170901171048.GA20817@arm.com> <238182999.1493.1504291547065.JavaMail.zimbra@efficios.com> <CAMOCf+jjy2hjqdmrqFuVvnS8p-i+3Z3ZLubk4ymnRfsdT_F8PA@mail.gmail.com> <20170918170129.GF11343@arm.com> <CAMOCf+gqMFmw9WCYqE_dXG3J+K=qBVT3Pv=z6CyrbppU6Y5qig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.efficios.com ([167.114.142.141]:41617 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752458AbdJFU4a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Oct 2017 16:56:30 -0400
In-Reply-To: <CAMOCf+gqMFmw9WCYqE_dXG3J+K=qBVT3Pv=z6CyrbppU6Y5qig@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hans Boehm <hboehm@google.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>, maged michael <maged.michael@gmail.com>, gromer <gromer@google.com>, Avi Kivity <avi@scylladb.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave Watson <davejwatson@fb.com>, Andy Lutomirski <luto@kernel.org>, "Russell King, ARM Linux" <linux@armlinux.org.uk>, Greg Hackmann <ghackmann@google.com>, Will Deacon <will.deacon@arm.com>, David Sehr <sehr@google.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>



----- On Oct 6, 2017, at 4:14 PM, Hans Boehm hboehm@google.com wrote:

> What's the status of MEMBARRIER_FLAG_SYNC_CORE? The discussion I saw left it
> unclear whether this would be a separate flag, or included by default. Did I
> miss something? I think we're fine with either, but we do have s strong
> interest in getting this in in some form...
> I also believe we're fine with MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED. And
> that seems to me like a reasonable way to deal with the added overhead.

[ re-sending with lkml and linux-arch in CC, making sure to send in plain text. ] 

Hi Hans, 

I'm currently making sure the MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED 
command makes its way into the 4.14 kernel before the end of the release candidates. 
Once that is done, I plan to post a patch adding a new MEMBARRIER_FLAG_SYNC_CORE 
flag for the 4.15 merge window. 

I have done a bit of research on the various architecture requirements for core serialization. 
Here are my findings so far about instructions providing core serialization on the main 
architectures supported by Linux. 

There are two places where we need it: in the interrupt handler for the membarrier IPI, and 
between scheduler execution (which can change the current "mm") and return to user-space. 

Please let me know if I missed anything. 

x86: iret, cpuid, wbinvd 
-> iret currently provides core serialization when going back to userspace and at the end of 
the IPI. There are plans to implement a return path without iret in the future, in which case 
I would need to issue an explicit "cpuid" instruction (sync_core()) in switch_mm() if the 
process is registered with MEMBARRIER_FLAG_SYNC_CORE. 

powerpc: rfi 
-> "rfi" instruction provides core serialization when going back to user-space. I believe this 
is used at the end of the membarrier IPI as well. (to be confirmed) 

arm32: returning to user-space provides core serialization. Same at the end of membarrier 
IPI (to be confirmed). 
aarch64: ERET instruction used when returning to user-space provides core sync. Same 
at the end of membarrier IPI (to be confirmed). 

s390/s390x: lpswe provides core sync. when returning to user-space. Not sure about end of IPI. 

ia64: rfi instruction provides core sync when returning to user-space. Probably the same at the 
end of IPI (to be confirmed). 
[ http://refspecs.linuxbase.org/IA64-softdevman-vol2 | http://refspecs.linuxbase.org/IA64-softdevman-vol2 ] 4.4.6.2 

parisc: core serialization is ensured by issuing at least 7 instructions. We should have 
at least that when going back to user-space (to be confirmed). Similar for IPI. 
[ https://parisc.wiki.kernel.org/images-parisc/6/68/Pa11_acd.pdf | https://parisc.wiki.kernel.org/images-parisc/6/68/Pa11_acd.pdf ] 5-152 

mips: eret instruction used when going back to user-space provides core sync on all 
SMP architectures. Probably same for IPI (to be confirmed). 
[ https://www.cs.cornell.edu/courses/cs3410/2008fa/MIPS_Vol2.pdf | https://www.cs.cornell.edu/courses/cs3410/2008fa/MIPS_Vol2.pdf ] p. 121 
on R3k and TX39XX, rfe is used instead, but those are uniprocessor, so they 
do not matter. 
[ http://os161.eecs.harvard.edu/documentation/sys161/mips.html | http://os161.eecs.harvard.edu/documentation/sys161/mips.html ] 

alpha: an explicit "imb" instruction seems to be required to perform core sync. 
Not sure if this is implicit by returning to user-space in any way. 
[ https://www2.cs.arizona.edu/projects/alto/Doc/local/alphahb2.pdf | https://www2.cs.arizona.edu/projects/alto/Doc/local/alphahb2.pdf ] 5-23 

sparc: seems to require an explicit "flush" instruction followed by at most 5 instructions 
to perform core serialization. Not sure if implied by return to user-space in any 
way. 

Based on my current understanding, only three architectures would require 
special flag test in switch_mm(): 

x86, when it implements an iret-free resume to userspace in the future, 
alpha: seems to require an explicit "imb" instruction, 
sparc: seems to require an explicit "flush" + 5 instructions. 

Those three cases would benefit from having an explicit registration of 
processes which want to use the private expedited core serializing membarrier, 
so we don't slow down unrelated context switching. It's also a good reason for 
making the core serializing behavior separate from the basic private expedited 
membarrier: some processes may only care about load/store ordering, so 
they should not have to take the performance hit of core serialization at context 
switch. 

It would be appreciated if architecture experts can fill-in on the missing 
architecture-specific details, or any misinterpretation of the documentation 
from my part. 

Thanks, 

Mathieu 

> Thanks!

> On Mon, Sep 18, 2017 at 10:01 AM, Will Deacon < [ mailto:will.deacon@arm.com |
> will.deacon@arm.com ] > wrote:

>> On Thu, Sep 07, 2017 at 05:03:49PM -0700, Hans Boehm wrote:
>> > > [Mathieu: ]

>> > > Assuming we don't need a sync core before updating the old code, an
>> > > aggressive approach would be:

>> > > reclaim and re-use (aggressive):

>> > > 1- userspace unpublish all reference to old code,
>> > > 2- userspace ensure no thread use the old code anymore (e.g. URCU),
>> > > 3- userspace updates old code -> new code
>> > > 4- issue data cache flush for the modified range (if needed)
>> > > 5- sys_membarrier
>> > > - for each executing threads
>> > > - issue core serializing barrier
>> > > 6- issue instruction cache flush for the modified range (if needed)
>> > > (may be required on all active threads on some architectures)
>> > > 7- userspace publish reference to new code

>> > My assumption was that right sequence here, at least on Aarch64, is to
>> > do 5 and 6 in the opposite order; flush the icache,which I believe can
>> > be done from the thread that wrote the code, and then issue a sys_membarrier
>> > for the core serializing barrier.

>> > It would be useful to get that clarified.

>> FWIW, Mathieu and I spent a while talking about this during LPC last week
>> and ended up agreeing that the ISB (core serialisation) is required *after*
>> the cache-maintenance to publish the new code has completed.

>> Will

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

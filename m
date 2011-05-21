From: Michael Cree <mcree@orcon.net.nz>
Subject: Re: Software prefetching considered harmful
Date: Sat, 21 May 2011 15:37:40 +1200
Message-ID: <4DD73384.6080407@orcon.net.nz>
References: <BANLkTim5MaJBYSuTnXfmOjgPNVOyZSgQuQ@mail.gmail.com> <BANLkTi=428+KWmDcHoFYs5gO_C9wyhxJnQ@mail.gmail.com> <20110519192842.GA7421@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx4.orcon.net.nz ([219.88.242.54]:36116 "EHLO mx4.orcon.net.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926Ab1EUE1b (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 21 May 2011 00:27:31 -0400
Received: from Debian-exim by mx4.orcon.net.nz with local (Exim 4.69)
	(envelope-from <mcree@orcon.net.nz>)
	id 1QNd0X-0002Ep-3q
	for linux-arch@vger.kernel.org; Sat, 21 May 2011 15:37:41 +1200
In-Reply-To: <20110519192842.GA7421@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Russell King <rmk@arm.linux.org.uk>

On 20/05/11 07:28, Ingo Molnar wrote:
> 
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
>> On Thu, May 19, 2011 at 10:12 AM, Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>>
>>> Now, notice that right now I'm *only* talking about removing it for
>>> the "hlist" cases (patch attached). I suspect we should do the same
>>> thing for all the list helpers.
>>
>> Actually, it's the "rcu" versions of the hlist helpers that need this
>> most, since those are the performance-critical ones and the ones used
>> in avc traversal. So the previous patch did nothing.
>>
>> So here's the actual patch I think I should commit.
>>
>> Added davem, benh and rmk explicitly - I think you're on linux-arch,
>> but still..  You may have machines that like prefetch more,

OK, I tested this on an Alpha since the Alpha Arch. Manual and Alpha
Compiler Writers' Guide gives examples of software prefetching and says
it's a good thing to do in certain situations.

I ran a 2.6.39 kernel and then a kernel with Linus' patch to remove the
prefetches. I also ran the tests on a pretty quiescent system.  The
Alpha (with EV67 cpu) can only count four types of hardware events (the
raw event 4 below is the Mbox Replay Trap --- when the CPU during
reordering instruction execution realises it has cocked up and lost
track of data relationships with memory so has to completely toss the
pipeline and restart it).  I also did a 'make -j2' since I have far
fewer CPUs.

With prefetching in the hlist:

 Performance counter stats for 'make -j2' (100 runs):

    24,410,837,606 cycles                     ( +-   0.042% )  (scaled
from 50.45%)
    23,667,556,717 instructions             #      0.970 IPC     ( +-
0.021% )  (scaled from 50.48%)
       108,215,598 cache-misses               ( +-   1.300% )  (scaled
from 50.46%)
       115,401,247 raw 0x4                    ( +-   0.099% )  (scaled
from 25.66%)

       38.221901985  seconds time elapsed   ( +-   0.676% )


Without prefetching:

 Performance counter stats for 'make -j2' (100 runs):

    24,344,492,146 cycles                     ( +-   0.051% )  (scaled
from 50.45%)
    23,669,009,135 instructions             #      0.972 IPC     ( +-
0.023% )  (scaled from 50.46%)
       106,124,519 cache-misses               ( +-   1.233% )  (scaled
from 50.46%)
       115,385,694 raw 0x4                    ( +-   0.105% )  (scaled
from 25.67%)

       38.232319169  seconds time elapsed   ( +-   0.956% )

The execution time and number of instructions executed are the same to
within measurement uncertainty.   The number of cycles is increased by
prefetching by 0.27% which is statistically significant but smaller than
that reported for the x86.  The differences in cache misses and mbox
replay traps are not statistically significant.

Thus there is no harm to the Alpha architecture in removing the
prefetches and possibly a very small advantage.

I also ran the user space test of Ingo's:

> #include <stdlib.h>
> #include <stdio.h>
> #include <time.h>
> 
> static inline void prefetch(const void *x)
> {
> 	asm volatile ("prefetchnta (%0)":: "r" (x));

Well, replaced that line with:
       __builtin_prefetch(x, 0, 3);

> }
> 
> #define BILLION (1000*1000*1000)
> 
> int main (void)
> {
> 	int i;
> 
> 	for (i = 0; i < BILLION; i++) {
> 		prefetch(NULL);
> 		prefetch(&i);
> 	}
> 
> 	return 0;
> }

and I measured the following:

 Performance counter stats for './prefetch_1b' (3 runs):

   181,838,732,972 cycles                     ( +-   0.251% )  (scaled
from 50.01%)
    74,235,333,145 instructions             #      0.408 IPC     ( +-
0.282% )  (scaled from 50.01%)
     5,137,103,532 cache-misses               ( +-  94.820% )  (scaled
from 49.99%)
     1,003,419,087 raw 0x4                    ( +-   0.018% )  (scaled
from 25.01%)

      292.441356154  seconds time elapsed   ( +-   2.925% )

What a shocker---only 0.4 IPC and an apparent 74 instructions per loop
iteration!

Running it again with the prefetch(NULL) changed to prefetch(&i):

 Performance counter stats for './prefetch_1a' (3 runs):

     2,013,886,830 cycles                     ( +-   0.054% )  (scaled
from 49.97%)
     5,999,675,015 instructions             #      2.979 IPC     ( +-
0.037% )  (scaled from 50.02%)
         4,902,846 cache-misses               ( +-  14.257% )  (scaled
from 50.04%)
            54,498 raw 0x4                    ( +-   2.503% )  (scaled
from 24.98%)

        3.080415963  seconds time elapsed   ( +-   0.560% )


Ah nice; an obvious 6 instructions per loop iteration that are taking 2
cycles to run for almost exactly 3 IPC.

I think the problem prefetching NULL (it is relevant that I have the
kernel config option CONFIG_DEFAULT_MMAP_MIN_ADDR=8192) is that the
Alpha hardware does not necessarily dismiss a prefetch to an unmapped
memory address, but may cause a CPU trap through to the PALcode which is
then required to dismiss the prefetch without passing control to the
kernel.  The user space prefetch example is therefore illustrating the
quite substantial damage of CPU traps through to PALcode.

While this is not a concern to the kernel (it obviously has access to
location 0) I can imagine some neophyte thinking (as I have done myself)
"I'll look to see how the kernel implements lists and use that because
it will be both clever and well tested code" without realising that the
prefetch of a NULL is very inefficient for userspace!

Cheers
Michael.

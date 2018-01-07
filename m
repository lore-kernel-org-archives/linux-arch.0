From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed access_ok
Date: Sat, 6 Jan 2018 19:38:14 -0800
Message-ID: <20180107033812.awq3vz4gdkps7tix@ast-mbp>
References: <CA+55aFzeCHgAtz4vCR9YaUxkuesCNEht56dKJmpytx2A-JmJkg@mail.gmail.com>
 <20180106123242.77f4d860@alans-desktop>
 <20180106181331.mmrqwwbu2jcjj2si@ast-mbp>
 <20180106183859.1ad9ae37@alans-desktop>
 <20180106185134.dzn2en4vw2hj3p6h@ast-mbp>
 <20180106195551.3207f75d@alans-desktop>
 <20180106200912.zhzdt4qmfrojeeqe@ast-mbp>
 <20180106202213.23e553fb@alans-desktop>
 <20180106211729.cp5oet3at3hyce4o@ast-mbp>
 <20180106230507.3547c9a0@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:38320 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbeAGDiU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 6 Jan 2018 22:38:20 -0500
Content-Disposition: inline
In-Reply-To: <20180106230507.3547c9a0@alans-desktop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

On Sat, Jan 06, 2018 at 11:05:07PM +0000, Alan Cox wrote:
> > Even if it would be practical the speed probably going to be in bytes per second,
> > so to read anything meaningful an attack detection techniques (that people
> > are actively working on) will be able to catch it.
> > At the end security cannot be absolute.
> > The current level of paranoia shouldn't force us to make hastily decisions.
> 
> I think there are at least three overlapping problem spaces here
> 
> 1.	This is a new field. That could mean that it turns out to be
> really hard and everyone discovers that eBPF was pretty much the only
> interesting attack. It could also mean we are going to see several years
> or refinement by evil geniuses all over the world and what we see now is
> tip of iceberg in cleverness.

yep. plenty of unknowns and what's happening now is an overreaction.

> 2.	It is very very complicated to answer a question like "is
> sequence x safe on all of vendor's microprocessors" even for the vendor

so far "is sequence x safe" was viewed by cpu vendors as
"is sequence x going to stop speculative execution".
The AND approach wasn't even considered and I suspect there may be
other ways to avoid the side channel attack, but vendors are too
focused on stopping speculation. Why? The vulnerability already
disclosed in detail. Public clouds already patched their kernels.
What is the rush to push half baked patches into upstream
that don't even address the variant 1 ?

> Intel's current position is 'lfence'.

Let's look at the facts. From GPZ blog:
"In simplified terms, this program is used to determine the address
of prog_map by guessing the offset from prog_map to a userspace
address and tail-calling through prog_map at the guessed offsets."

which clearly states that bpf_tail_call() was used in the attack.
Yet none of the intel nor arm patches address speculation in
this bpf helper!
It means that:
- gpz didn't share neither exploit nor the detailed description
  of the POC with cpu vendors until now
- coverity rules used to find all these places in the kernel
  failed to find bpf_tail_call
- cpu vendors were speculating what variant 1 can actually do

Now the attack is well described, yet cpu vendors still pushing
for lfence patches that don't make sense. Why?

Furthermore GPZ blog states:
"To cause the branch prediction to predict that the offset is below
the length of prog_map, tail calls to an in-bounds index are
performed in between."

which means that attack is 'in-bound * largeN + out-of-bound * 1'.
Going back to our discussion few emails ago about 'mask' as a variable
it means that value predictor when speculating this last out of
bound access will correctly predict exact 'mask', so 'index & mask'
fix will certainly defeat this poc.

More from the blog:
"To increase the mis-speculation window, the cache line containing
the length of prog_map is bounced to another core."

and in the kernel we have:
struct bpf_map {
   atomic_t refcnt;
   enum bpf_map_type map_type;
   u32 key_size;
   u32 value_size;
   u32 max_entries;
   ...
note that only 'refcnt' could be used for bouncing,
so if we place max_entries and refcnt into different cache
lines this poc will likely fail as well.

More from the blog:
"At this point, a second eBPF program can be used to actually leak data.
In pseudocode, this program looks as follows:
uint64_t progmap_index = (((secret_data & bitmask) >> bitshift_selector) << 7) + prog_array_base_offset;
bpf_tail_call(prog_map, progmap_index);
"
which means that POC is relying 64-bit address speculation.
In the places coverity found the user supplied value is 32-bit,
so none of them are suitable for this POC.
We cannot rule out that the attack cannot be crafted to work
with 32-bit, but it means there is no urgency to lfence everything.

> The important thing is that there is something clean, all architecture
> that can be used today that doesn't keep forcing everyone to change
> drivers when new/better ways to do the speculation management appear.

What I think is important is to understand vulnerability first.
I don't think it was done.

> The differences involved on the "lfence" versus "and" versus before are
> not likely to be anywhere in that order of magnitude.

we clearly disagree here. Both intel and arm patches proposed
to add lfence in bpf_map_lookup() which is the hottest function
we have and we do run it at 40+Gbps speeds where every nanosecond
counts, so no, lfence is not a solution.

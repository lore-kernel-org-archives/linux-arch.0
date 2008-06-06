From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [patch 00/41] cpu alloc / cpu ops v3: Optimize per cpu access
Date: Fri, 06 Jun 2008 07:33:22 +0200
Message-ID: <4848CC22.6090109@cosmosbay.com>
References: <20080530035620.587204923@sgi.com> <20080529215827.b659d032.akpm@linux-foundation.org> <4846AFCF.30500@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from neuf-infra-smtp-out-sp604006av.neufgp.fr ([84.96.92.121]:44395
	"EHLO neuf-infra-smtp-out-sp604006av.neufgp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752584AbYFFFjM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 6 Jun 2008 01:39:12 -0400
In-Reply-To: <4846AFCF.30500@sgi.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Travis <travis@sgi.com>, Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>

Mike Travis a =E9crit :
> Andrew Morton wrote:
>> On Thu, 29 May 2008 20:56:20 -0700 Christoph Lameter <clameter@sgi.c=
om> wrote:
>>
>>> In various places the kernel maintains arrays of pointers indexed b=
y
>>> processor numbers. These are used to locate objects that need to be=
 used
>>> when executing on a specirfic processor. Both the slab allocator
>>> and the page allocator use these arrays and there the arrays are us=
ed in
>>> performance critical code. The allocpercpu functionality is a simpl=
e
>>> allocator to provide these arrays.
>> All seems reasonable to me.  The obvious question is "how do we size
>> the arena".  We either waste memory or, much worse, run out.
>>
>> And running out is a real possibility, I think.  Most people will on=
ly
>> mount a handful of XFS filesystems.  But some customer will come alo=
ng
>> who wants to mount 5,000, and distributors will need to cater for th=
at,
>> but how can they?
>>
>> I wonder if we can arrange for the default to be overridden via a
>> kernel boot option?
>>
>>
>> Another obvious question is "how much of a problem will we have with
>> internal fragmentation"?  This might be a drop-dead showstopper.

Christoph & Mike,

Please forgive me if I beat a dead horse, but this percpu stuff
should find its way.

I wonder why you absolutely want to have only one chunk holding
all percpu variables, static(vmlinux) & static(modules)
& dynamically allocated.

Its *not* possible to put an arbitrary limit to this global zone.
You'll allways find somebody to break this limit. This is the point
we must solve, before coding anything.

Have you considered using a list of fixed size chunks, each chunk
having its own bitmap ?

We only want fix offsets between CPU locations. For a given variable,
we MUST find addresses for all CPUS looking at the same offset table.
(Then we can optimize things on x86, using %gs/%fs register, instead
of a table lookup)

We could chose chunk size at compile time, depending on various
parameters (32/64 bit arches, or hugepage sizes on NUMA),
and a minimum value (ABI guarantee)

On x86_64 && NUMA we could use 2 Mbytes chunks, while
on x86_32 or non NUMA we should probably use 64 Kbytes.

At boot time, we setup the first chunk (chunk 0) and copy=20
=2Edata.percpu on this chunk, for each possible cpu, and we
build the bitmap for future dynamic/module percpu allocations.
So we still have the restriction that sizeofsection(.data.percpu)
should fit in the chunk 0. Not a problem in practice.

Then if we need to expand percpu zone for heavy duty machine,
and chunk 0 is already filled, we can add as many 2 M/ 64K=20
chunks we need.

This would limit the dynamic percpu allocation to 64 kbytes for
a given variable, so huge users should probably still use a
different allocator (like oprofile alloc_cpu_buffers() function)
But at least we dont anymore limit the total size of percpu area.

I understand you want to offset percpu data to 0, but for
static percpu data. (pda being included in, to share %gs)

=46or dynamically allocated percpu variables (including modules
".data.percpu"), nothing forces you to have low offsets,
relative to %gs/%fs register. Access to these variables
will be register indirect based anyway (eg %gs:(%rax) )


1) NUMA case

=46or a 64 bit NUMA arch, chunk size of 2Mbytes

Allocates 2Mb for each possible processor (on its preferred memory
node), and compute values to setup offset_of_cpu[NR_CPUS] array.

Chunk 0
CPU 0 : virtual address XXXXXX       =20
CPU 1 : virtual address XXXXXX + offset_of_cpu[1]
=2E..
CPU n : virtual address XXXXXX + offset_of_cpu[n]
+ a shared bitmap


=46or next chunks, we could use vmalloc() zone to find=20
nr_possible_cpus virtual addresses ranges where you can map
a 2Mb page per possible cpu, as long as we respect the relative
delta between each cpu block, that was computed when
chunk 0 was setup.

Chunk 1..n
CPU 0 : virtual address YYYYYYYYYYYYYY  =20
CPU 1 : virtual address YYYYYYYYYYYYYY + offset_of_cpu[1]
=2E..
CPU n : virtual address YYYYYYYYYYYYYY + offset_of_cpu[n]
+ a shared bitmap (32Kbytes if 8 bytes granularity in allocator)

=46or a variable located in chunk 0, its 'address' relative to current
cpu %gs will be some number between [0 and 2^20-1]

=46or a variable located in chunk 1, its 'address' relative to current
cpu %gs will be some number between
[YYYYYYYYYYYYYY - XXXXXX  and YYYYYYYYYYYYYY - XXXXXX + 2^20 - 1],
not necessarly [2^20 to 2^21 - 1]


Chunk 0 would use normal memory (no vmap TLB cost), only next ones need=
 vmalloc().

So the extra TLB cost would only be taken for very special NUMA setups
(only if using a lot of percpu allocations)

Also, using a 2Mb page granularity probably wastes about 2Mb per cpu, b=
ut
this is nothing for NUMA machines :)

2) SMP && !NUMA

On non NUMA machines, we dont need vmalloc games, since we can allocate
chunk space using contiguous memory, (size =3D nr_possible_cpus*64Kbyte=
s)

offset_of_cpu[N] =3D N * CHUNK_SIZE

(On a 4 CPU x86_32 machine, allocate a 256 Kbyte bloc then divide it in
64 kb blocs)
If this order-6 allocation fails, then fallback to vmalloc(), but most
percpu allocations happens at boot time, when memory is not yet fragmen=
ted...


3) UP case : fallback to standard allocators. No need for bitmaps.


NUMA special casing can be implemented later of course...

Thanks for reading

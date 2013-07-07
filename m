From: Colin Cross <ccross@android.com>
Subject: Re: [PATCH] mm: add sys_madvise2 and MADV_NAME to name vmas
Date: Sun, 7 Jul 2013 11:35:02 -0700
Message-ID: <CAMbhsRRDOW-6NVyX8LT-AFM4PDTk+=+Oc-2cz20QW3-dY9MC-A@mail.gmail.com>
References: <1372901537-31033-1-git-send-email-ccross@android.com>
	<87txkaq600.fsf@xmission.com>
	<51D7BA21.4030105@kernel.org>
	<87ip0nlx9w.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <87ip0nlx9w.fsf@xmission.com>
Sender: owner-linux-mm@kvack.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Pekka Enberg <penberg@kernel.org>, lkml <linux-kernel@vger.kernel.org>, Kyungmin Park <kmpark@infradead.org>, Christoph Hellwig <hch@infradead.org>, John Stultz <john.stultz@linaro.org>, Rob Landley <rob@landley.net>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Cyrill Gorcunov <gorcunov@openvz.org>, David Rientjes <rientjes@google.com>, Davidlohr Bueso <dave@gnu.org>, Kees Cook <keescook@chromium.org>, Al Viro <viro@zeniv.linux.org.uk>, Hugh Dickins <hughd@google.com>, Mel Gorman <mgorman@suse.de>, Michel Lespinasse <walken@google.com>, Rik van Riel <riel@redhat.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Rusty Russell <rusty@rustcorp.com.au>, Oleg Nesterov <oleg@redhat.com>, Srikar Dronamraju <srikar@linux.vnet.ibm.com>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Michal
List-Id: linux-arch.vger.kernel.org

On Sat, Jul 6, 2013 at 4:53 AM, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Pekka Enberg <penberg@kernel.org> writes:
>
>> On 7/4/13 7:54 AM, Eric W. Biederman wrote:
>>> How can adding glittler to /proc/<pid>/maps and /proc/<pid>/smaps
>>> justify putting a hand break on the linux kernel?
>>
>> It's not just glitter, it's potentially very useful for making
>> perf work nicely with JVM, for example, to know about JIT
>> codegen regions and GC regions.
>
> Ah yes.  The old let's make it possible to understand the performance
> and behavior by making the bottleneck case even slower.  At least for
> variants of GC that use occasionally make have use of mprotect that
> seems to be exactly what this patch proposes.
>
>> The implementation seems very heavy-weight though and I'm not
>> convinced a new syscall makes sense.
>
> Strongly agreed.  Oleg's idea of a simple integer (that can be though of
> as a 4 or 8 byte string) seems much more practical.

If I can avoid the per-vma refcounting, storing a string is the same
as storing an integer from the vma's perspective, and far more useful
because I don't have to worry about having some tool with global
knowledge of what integer ids each layer uses.  I'm not opposed to an
integer id as an alternative, I just don't think it will be as useful.

> What puzzles me is what is the point?  What is gained by putting this
> knowledge in the kernel that can not be determend from looking at how
> user space has allocated the memory?  The entire concept feels like a
> layering violation.  Instead of modifying the malloc in glibc or the jvm
> or whatever it is propsed to modify the kernel.

It is easy to track how much memory has been allocated at each layer
through userspace, but that is not the problem.  It is impossible for
userspace to determine how much physical memory is used by an
allocation, accounting for zero pages, Kernel Samepage Merging, COW,
etc., unless userspace tracks the virtual address of every allocation,
which is what the kernel is already doing.

> Even after all of the discussion I am still seeing glitter and hand breaks.

Can you clarify which paths you think are too heavyweight?

My goal was to keep the impact on existing mm code paths tiny.  The
only places I added extra costs:
1.  Naming a vma can be fairly expensive, I tried to consolidate all
the cost here
2.  Splitting, merging or duplicating a named vma requires a refcount
update, but I don't expect this to be an extremely hot path.  The cost
is the same as for a file backed vma.
3.  Unmapping a vma requires a refcount update, and may delete the
vma_name structure.  I could make this just another refcount update,
and then use a shrinker or some other event to delete names from the
name cache.

BTW, your replies are corrupting email addresses in the CC list by
inserting a linefeed in the middle of an email address, as well as
screwing up some of the lists.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>

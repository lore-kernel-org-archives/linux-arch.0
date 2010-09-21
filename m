From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Proposal: (u)intptr_t replaces (unsigned) long as opaque type
Date: Tue, 21 Sep 2010 08:32:15 +0200
Message-ID: <201009210832.15398.arnd@arndb.de>
References: <4C95324B.2030707@mcgary.org> <201009201130.57834.arnd@arndb.de> <4C97C3E4.2080105@mcgary.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:58976 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008Ab0IUGc3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Sep 2010 02:32:29 -0400
In-Reply-To: <4C97C3E4.2080105@mcgary.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg McGary <greg@mcgary.org>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-arch@vger.kernel.org

On Monday 20 September 2010 22:28:20 Greg McGary wrote:
> On 09/20/10 02:30, Arnd Bergmann wrote:

> 2) generic pointer: ioctl args account for approx 30% of all cases for type
>    improvement.  Here, the best choice to replace (unsigned long) is (void *).

Not sure about this one, maybe it should be uintptr_t as well. The problem
is that a significant number of ioctls also directly operate on the argument
as a scalar, even though the majority clearly needs to convert to a pointer.
 
> 3) generic pointer-or-integer: We should probably invent a new typedef here:
>    e.g., opaque_t or long_or_ptr_t.  For my port, sizeof(void*) > sizeof(long),
>    but sometimes APIs have sizeof (void*) < sizeof(long).  With the
>    indirection of a new type name, we could define it as the larger of
>    (uintptr_t) or (unsigned long).

No, I really wouldn't go that far without a need. If we can come up with
a good solution to cover the sizeof(void*) > sizeof(long) case but
not the sizeof (void*) < sizeof(long) case, I don't think it's worth
thinking about the more complex cases.

> If I were to submit some patches for cases #1 and #2, would I be wasting my
> time? 8^)  I'll leave-off for case #3 until there's consensus.

Case #1 looks worthwhile from a code cleanup perspective, I see that as
a useful step independent of your architecture, so if you're willing
to do the work, there shouldn't be anything holding you up.

For the specific case of ioctl, we actually have a cleanup pending in
that area anyway. The prototype is a bit weird for historic reasons
and should just be cleaned up now. We currently have

struct file_operations {
	...
	unsigned long unlocked_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
	unsigned long compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
	...
};

There are now three things wrong with this:
- the return type should be 'int'
- the name of the first function should be 'ioctl', not unlocked_ioctl
- you want the third argument to be uintptr_t.

If you can come up with a semantic patch that can be applied treewide to clean
this all up, I think that would be excellent.

> > Another possible alternative might be to add a kernel mode to your compiler
> > that defines long as 64 bits, but with only 48 significant bits, like you
> > have for your pointers. Does that work with your hardware?
> > It seems that this would be fast and means fewer changes to the kernel,
> > but opens a completely different can of worms in that it breaks code assuming
> > that "ULONG_MAX == (1ul << (sizeof (unsigned long) * 8)) - 1", and might
> > require many more changes to gcc.
> 
> The address space is not linear.  The upper 16 bits of pointers have segment
> info so I can't just confine the address space to 2^32 and truncate pointers
> to 32 bits.  I could implement a toolchain mode where long is 64 bits at the
> cost of some performance to do 64-bit ALU ops as two 32-bit subops.  I will
> keep that in mind as an option.  However, the work involved in implementing
> and validating the 64-bit API/ABI mode toolchain is at least as much and maybe
> more than fixing the kernel types.  I prefer to spend my time on the approach
> that will yield the best performing product, even if I must maintain all these
> type changes in my own git repo.

It would probably be helpful to know more about the segment info, maybe
there is yet another way to do it. This sounds similar to the s390
architecture, where we never used the segments (access registers) in Linux.

So your GPRs are all 32 bits, and a pointer consists of a GPR plus a segment
register, right? Do you always use more than one segment, both in kernel
and in user space? If they are just for user space, it would be a lot
simpler because you can get away with simply extending the __user pointers
in the kernel (which still includes all ioctl functions).

There has also been some work on having gcc support for multiple address
spaces recently. Maybe you can use that to describe each segment as
an C address space, but keep one segment as the default address space
for regular pointers.

	Arnd

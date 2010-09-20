From: Greg McGary <greg@mcgary.org>
Subject: Re: Proposal: (u)intptr_t replaces (unsigned) long as opaque type
Date: Mon, 20 Sep 2010 13:28:20 -0700
Message-ID: <4C97C3E4.2080105@mcgary.org>
References: <4C95324B.2030707@mcgary.org> <20100919040635.GE25139@parisc-linux.org> <4C964014.4090005@mcgary.org> <201009201130.57834.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mpls-qmqp-02.inet.qwest.net ([63.231.195.113]:52043 "EHLO
	mpls-qmqp-02.inet.qwest.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754275Ab0ITU23 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 20 Sep 2010 16:28:29 -0400
In-Reply-To: <201009201130.57834.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-arch@vger.kernel.org

On 09/20/10 02:30, Arnd Bergmann wrote:

> Having proper types for opaque scalars that can be used for both pointer
> and long values is a reasonable thing to do in general, and seems to fit
> that requirement. Right now, we use 'unsigned long' to mean a number of
> different things and from reading code it's not clear which one you want.
> Not sure of intptr_t is the best name, so we might come up with something
> better for this purpose, but it's a standard C99 type and the meaning
> is pretty much what we want anyway


Some common cases where kernel type choices can improve:

1) byte-address arithmetic (add, subtract, mask, align, low-order bit-flag
   manipulation): The C99 types (u)intptr_t are the best fit for this use
   case. (void*) and (char*) are not so good--they are serviceable for
   add/subtract on addresses, but don't work for masking and other bitops.

2) generic pointer: ioctl args account for approx 30% of all cases for type
   improvement.  Here, the best choice to replace (unsigned long) is (void *).

3) generic pointer-or-integer: We should probably invent a new typedef here:
   e.g., opaque_t or long_or_ptr_t.  For my port, sizeof(void*) > sizeof(long),
   but sometimes APIs have sizeof (void*) < sizeof(long).  With the
   indirection of a new type name, we could define it as the larger of
   (uintptr_t) or (unsigned long).

Of these three cases, #1 and #2 are straightforward and should not involve any
controversy.  The only issue with #3 is whether to invent a new type name, and
if so, what that name should be.

If I were to submit some patches for cases #1 and #2, would I be wasting my
time? 8^)  I'll leave-off for case #3 until there's consensus.

> Another possible alternative might be to add a kernel mode to your compiler
> that defines long as 64 bits, but with only 48 significant bits, like you
> have for your pointers. Does that work with your hardware?
> It seems that this would be fast and means fewer changes to the kernel,
> but opens a completely different can of worms in that it breaks code assuming
> that "ULONG_MAX == (1ul << (sizeof (unsigned long) * 8)) - 1", and might
> require many more changes to gcc.
>
> 	Arnd


The address space is not linear.  The upper 16 bits of pointers have segment
info so I can't just confine the address space to 2^32 and truncate pointers
to 32 bits.  I could implement a toolchain mode where long is 64 bits at the
cost of some performance to do 64-bit ALU ops as two 32-bit subops.  I will
keep that in mind as an option.  However, the work involved in implementing
and validating the 64-bit API/ABI mode toolchain is at least as much and maybe
more than fixing the kernel types.  I prefer to spend my time on the approach
that will yield the best performing product, even if I must maintain all these
type changes in my own git repo.

G

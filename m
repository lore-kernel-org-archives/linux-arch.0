From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [opensuse-factory] Re: [opensuse-kernel] libsigsegv build fail
 with kernel 3.18.3
Date: Sun, 1 Feb 2015 17:09:15 -0800
Message-ID: <CA+55aFw9sg7pu9-2RbMGyPv5yUtcH54QowoH+5RhWqpPYg4YGQ@mail.gmail.com>
References: <1422361485.6648.71.camel@opensuse.org>
	<54C78756.9090605@suse.cz>
	<alpine.LSU.2.11.1501271347440.30227@nerf60.vanv.qr>
	<1422364084.6648.82.camel@opensuse.org>
	<s5h7fw8hvdp.wl-tiwai@suse.de>
	<CA+55aFyzy_wYHHnr2gDcYr7qcgOKM2557bRdg6RBa=cxrynd+Q@mail.gmail.com>
	<CA+55aFxRnj97rpSQvvzLJhpo7C8TQ-F=eB1Ry2n53AV1rN8mwA@mail.gmail.com>
	<CAMo8BfLsKCV_2NfgMH4k9jGOHs_-3=NKjCD3o3KK1uH23-6RRg@mail.gmail.com>
	<CA+55aFzQ5QEZ1AYauWviq1gp5j=mqByAtt4fpteeK7amuxcyjw@mail.gmail.com>
	<1422836637.17302.9.camel@au1.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:54075 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbbBBBJR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 1 Feb 2015 20:09:17 -0500
Received: by mail-ig0-f175.google.com with SMTP id hn18so14798347igb.2
        for <linux-arch@vger.kernel.org>; Sun, 01 Feb 2015 17:09:16 -0800 (PST)
In-Reply-To: <1422836637.17302.9.camel@au1.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Takashi Iwai <tiwai@suse.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, opensuse-factory@opensuse.org, OpenSUSE Kernel Team <opensuse-kernel@opensuse.org>

On Sun, Feb 1, 2015 at 4:23 PM, Benjamin Herrenschmidt <benh@au1.ibm.com> wrote:
>
> I prefer having the test inside mm_fault_error(), even if that makes the
> patch a bit bigger, it keeps the logic in a single place. Untested
> patch:

I'm certainly ok with that, but I wanted to make the code that I
wasn't going to compile (much less test) for various architectures be
as simple and straightforward as possible.

So feel free to send a patch that fixes it up to do it in a single
place after testing it.

Of course, what I *really* want would be to make a new
"generic_mm_fault()" helper that would do all the normal stuff:

 - find_vma()
 - check permissions and ranges
 - call 'handle_mm_fault()'
 - do the proper error, retry and minor/major fault handling

and then most architectures could just call that.

Everybody has their own thing that they do *before* they get the mmap
semaphore (x86 has at least kprobe, mmio tracing, vmalloc-fault,
spurious prefetch faults due to AMD CPU bugs, in-atomic debugging irq
re-enablement, etc etc). Those aren't even worth it trying to make
into generic things. But just looking at the original patch, a _lot_
of the stuff around the actual handle_mm_fault() call is very very
generic indeed, and I think it could be made into a generic helper
function.

For example, I not that long ago fixed the x86 handling of
VM_FAULT_RETRY when there was a fatal signal pending and we were
returning to kernel mode. The code would just return, "knowing" that
the fatal signal would mean that rather than faulting again, the
process would be killed. Except if the fault happened from kernel
space, that wouldn't happen, and it really would just fault forever.

I would not be surprised if somebody copied the old incorrect x86 case
for VM_FAULT_RETRY and fatal signals, and it just never got fixed
anywhere else.

Doing all that in a generic helper routine (that then just returns a
value saying "SIGBUS", "SIGSEGV" - we'd probably have to split it up
into "SIGSEGV due to access error" vs "SIGSEGV due to map error" to
make everybody happy, "out of memory" or "success" would have made it
trivial to add the whole VM_FAULT_SIGSEGV, but it would also mean that
everybody got fixes to the retry handling etc. Because right now
there's a *lot* of basically duplicated code (although powerpc and
s390 in particular have made some changes of their own).

Anybody willing to see if they could encapsulate that part of the x86
code, and make it more widely useful? I say "x86 code", because that's
the most tested one, and I think it gets the odd retry and error cases
right (and minor/major fault counting etc), unlike some.

                           Linus

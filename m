From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Generic page fault (Was: libsigsegv ....)
Date: Sat, 28 Feb 2015 11:56:25 -0800
Message-ID: <CA+55aFy5UvzSgOMKq09u4psz5twtC4aowuK6tofGKDEu-KFMJQ@mail.gmail.com>
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
	<CA+55aFw9sg7pu9-2RbMGyPv5yUtcH54QowoH+5RhWqpPYg4YGQ@mail.gmail.com>
	<1425107567.4645.108.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:40888 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbbB1T40 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 28 Feb 2015 14:56:26 -0500
In-Reply-To: <1425107567.4645.108.camel@kernel.crashing.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>

On Fri, Feb 27, 2015 at 11:12 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> Let me know what you think of the approach.

Hmm. I'm not happy with just how many of those arch wrapper/helper
functions there are, and some of it looks a bit unportable.

For example, the code "knows" that "err_code" and "address" are the
only two architecture-specific pieces of information (in addition to
"struct pt_regs", of course.

And the fault_is_user/write() stuff seems unnecessary - we have the
generic FAULT_FLAG_USER/WRITE flags for that, but instead of passing
in the generic version to the generic function, we pass in the
arch-specific ones.

The same goes for "access_error()". Right now it's an arch-specific
helper function, but it actually does some generic tests (like
checking the vma protections), and I think it could/should be entirely
generic if we just added the necessary FAULT_FLAG_READ/EXEC/NOTPRESENT
information to the "flags" register. Just looking at the ppc version,
my gut feel is that "access_error()" is just horribly error-prone
as-is even from an architecture standpoint.

Yes, the "read/exec/notpresent" bits are a bit weird, but old x86
isn't the only architecture that doesn't necessarily know the
difference between read and exec.

So I'd like a bit more encapsulation. The generic code should never
really need to look at the arch-specific details, although it is true
that then the error handling cases will likely need it (in order to
put it on the arch-specific stack info or similar).

So my *gut* feel is that the generic code should be passed

 - address and the generic flags (ie FAULT_FLAG_USER/WRITE filled in
by the caller)

   These are the only things the generic code should need to use itself

 - I guess we do need to pass in "struct pt_regs", because things like
generic tracing actually want it.

 - an opaque "arch specific fault information structure pointer". Not
used for anything but passing back to the error functions (ie very
much *not* for helper functions for the normal case, like the current
"access_error()" - if it's actually needed for those kinds of things,
then I'm wrong about the model)

   This would (for x86) contain "error_code", but I have the feeling
that other architectures might need/want more than one word of
information.

But I don't know. Maybe I'm wrong. I don't hate the patch as-is, I
just have this feeling that it coudl be more "generic", and less
"random small arch helpers".

                              Linus

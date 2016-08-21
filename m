From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] ARC: uaccess: get_user to zero out dest in cause of fault
Date: Sun, 21 Aug 2016 01:11:44 +0100
Message-ID: <20160821001141.GV2356@ZenIV.linux.org.uk>
References: <1471633802-2936-1-git-send-email-vgupta@synopsys.com>
 <20160819212428.GR2356@ZenIV.linux.org.uk>
 <CA+55aFyvBd+sMTC-NsEG4QzVApmy0UhSfpoVOP58m-Zg2wumPQ@mail.gmail.com>
 <CA+55aFyB_r5KMJrYMygdkFw-UdxFUCExQJDL-d2Cd+Sk2+xLrw@mail.gmail.com>
 <CA+55aFx9ih9WX-8iUM95fvbuFJ8hf-dK6vwKsVZPh=fdcSB8Cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:56482 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751222AbcHUAMK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 Aug 2016 20:12:10 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFx9ih9WX-8iUM95fvbuFJ8hf-dK6vwKsVZPh=fdcSB8Cg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>

On Sat, Aug 20, 2016 at 04:32:57PM -0700, Linus Torvalds wrote:

> Anyway, the asm coming out of gcc looks nasty, because it has all the
> ugly section stuiff and fixups for SMAP not existing on some CPU's
> etc. So the resulting fs/readdir.s file is hard to read. But if you
> look at the disassembly at the object file that hides all that (and
> shows what the end result actually is), the actual filldir user
> accesses end up looking beautiful, with no extra code anywhere. An
> exception just goes to the EFAULT handling directly.
> 
> Sadly, unsafe_get_user() looking as good does require gcc improvements
> that aren't imminent.
> 
> This patch is untested, although the earlier original pre-rebased
> version of it actually got a fair amount of testing on my machine
> (including the filldir use)

Interesting...  BTW, how's this in the "really vile tricks" department?

	if (!uaccess_begin())
		goto fail;
	unsafe_...
	...
	uacess_end();

with uaccess_begin() along the lines of
	p = &current_thread_info()->foo;
	asm
		.text:
			STAC
			*p = 1f
			res = true;
			2:;
		.fixups:
			1:res = false;
			CLAC
			jmp 2;
	if (unlikely(res))
		asm
			clobber everything
	res;
and exception handlers in unsafe_... jumping to the address found
in current_thread_info()->foo.  AFAICS, it should avoid the problems
with asm goto, right?  The branch target is tied to the entry into the
damn series, so it's not as if it could disappear; and path to a branch
cc(1) doesn't see passes through the chunk produced by that asm block
in uaccess_begin(), so if it looks unreachable without taking those branches
into account, it _is_ unreachable.

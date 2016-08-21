From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] ARC: uaccess: get_user to zero out dest in cause of fault
Date: Sun, 21 Aug 2016 07:42:34 +0100
Message-ID: <20160821064229.GX2356@ZenIV.linux.org.uk>
References: <1471633802-2936-1-git-send-email-vgupta@synopsys.com>
 <20160819212428.GR2356@ZenIV.linux.org.uk>
 <CA+55aFyvBd+sMTC-NsEG4QzVApmy0UhSfpoVOP58m-Zg2wumPQ@mail.gmail.com>
 <CA+55aFyB_r5KMJrYMygdkFw-UdxFUCExQJDL-d2Cd+Sk2+xLrw@mail.gmail.com>
 <CA+55aFx9ih9WX-8iUM95fvbuFJ8hf-dK6vwKsVZPh=fdcSB8Cg@mail.gmail.com>
 <20160821001141.GV2356@ZenIV.linux.org.uk>
 <CA+55aFyYOZ2U=Fb=oGrVzqvKUprFOAdL8Ra7sTw5KhgibvN0pA@mail.gmail.com>
 <20160821045402.GC14857@tucnak.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160821045402.GC14857@tucnak.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jakub Jelinek <jakub@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-arch.vger.kernel.org

On Sun, Aug 21, 2016 at 06:54:02AM +0200, Jakub Jelinek wrote:
> On Sat, Aug 20, 2016 at 05:45:00PM -0700, Linus Torvalds wrote:

> If you plan to use setjmp/longjmp a lot, then it is certainly a major
> performance and compile time/memory problem.
> Older versions don't model it properly, and newer gccs emit abnormal edges
> from every longjmp or call that might longjmp to an artificial basic block
> and from there to every setjmp.
> Also note that gcc has/supports two setjmp kind of APIs, normal setjmp and
> slightly more lightweight __builtin_setjmp which saves fewer registers, and
> on some targets is/used to be used for EH instead of DWARF based ones.

It's not exactly setjmp/longjmp; what I had in mind was along the lines of

static inline bool start(void)
{
	asm(
		save enough state into current_thread_info()->something, with
			1f for saved %rip
		stac
		res = true
	2:
	.section .text.fixup
	1:	res = false
		clac
		jmp 2b
	.previous
	)
	if (unlikely(!res))
		asm clobber everything
	return res;
}

and in unsafe_get_user() exception fixup (again, in .text.fixup section,
and invisible to gcc) jumping to common code that would pick saved state
from current_thread_info() and jump to saved location.

	The uses would be along the lines of
	if (!start())
		goto fail;
	unsafe_get_user(foo, &p1->foo);
	unsafe_get_user(bar, &p1->bar);
	...
	asm clac

IOW, a bunch of branches hidden from gcc, with destination (in the same
function) dominating the source of each (via visible branches as well).

Originally I hoped to get away with saving just the %rip; Linus has pointed
out that stack pointer is also needed.  It's obviously much less generic
than setjmp/longjmp is.  Single per-thread jmp_buf rudiment, all "longjmp"
calls in the same function as "setjmp" one, pretty much not giving a damn
about any local variables we might've changed if the "longjmp" is taken,
etc.

The point of the exercise is to have the normal execution path containing
no error checks - just the data copying, with all exception handling happening
out-of-line...

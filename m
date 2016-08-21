From: Jakub Jelinek <jakub@redhat.com>
Subject: Re: [PATCH] ARC: uaccess: get_user to zero out dest in cause of fault
Date: Sun, 21 Aug 2016 06:54:02 +0200
Message-ID: <20160821045402.GC14857@tucnak.redhat.com>
References: <1471633802-2936-1-git-send-email-vgupta@synopsys.com>
 <20160819212428.GR2356@ZenIV.linux.org.uk>
 <CA+55aFyvBd+sMTC-NsEG4QzVApmy0UhSfpoVOP58m-Zg2wumPQ@mail.gmail.com>
 <CA+55aFyB_r5KMJrYMygdkFw-UdxFUCExQJDL-d2Cd+Sk2+xLrw@mail.gmail.com>
 <CA+55aFx9ih9WX-8iUM95fvbuFJ8hf-dK6vwKsVZPh=fdcSB8Cg@mail.gmail.com>
 <20160821001141.GV2356@ZenIV.linux.org.uk>
 <CA+55aFyYOZ2U=Fb=oGrVzqvKUprFOAdL8Ra7sTw5KhgibvN0pA@mail.gmail.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750871AbcHUEyK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 21 Aug 2016 00:54:10 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFyYOZ2U=Fb=oGrVzqvKUprFOAdL8Ra7sTw5KhgibvN0pA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>

On Sat, Aug 20, 2016 at 05:45:00PM -0700, Linus Torvalds wrote:
> You have to save the stack pointer at the setjmp point too. And there
> might be other architecture-specific ABI rules for that. But you're
> right, it might be worth it.
> 
> I *would* be a bit worried about code generation issues.
> setjmp/longjmp is so seldom used that it's one of those things where
> it might be best to verify with some gcc person that it doesn't cause
> huge code-gen problems.
> 
> Adding Jakub just to check: Jakub, would a setjump/longjump kind of
> interface for exception handling going to cause us problems
> (performance or correctness) with gcc?

If you plan to use setjmp/longjmp a lot, then it is certainly a major
performance and compile time/memory problem.
Older versions don't model it properly, and newer gccs emit abnormal edges
from every longjmp or call that might longjmp to an artificial basic block
and from there to every setjmp.
Also note that gcc has/supports two setjmp kind of APIs, normal setjmp and
slightly more lightweight __builtin_setjmp which saves fewer registers, and
on some targets is/used to be used for EH instead of DWARF based ones.

	Jakub

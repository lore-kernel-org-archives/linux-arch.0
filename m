From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: PMD update corruption (sync question)
Date: Mon, 2 Mar 2015 13:31:49 +0100
Message-ID: <20150302123149.GK21418@twins.programming.kicks-ass.net>
References: <1411740233-28038-1-git-send-email-steve.capper@linaro.org>
 <54F06636.6080905@redhat.com>
 <54F3C6AD.50300@redhat.com>
 <938476184.27970130.1425275915893.JavaMail.zimbra@zmail15.collab.prod.int.phx2.redhat.com>
 <20150302105011.GD22541@e104818-lin.cambridge.arm.com>
 <1172437505.28092883.1425294374323.JavaMail.zimbra@zmail15.collab.prod.int.phx2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1172437505.28092883.1425294374323.JavaMail.zimbra@zmail15.collab.prod.int.phx2.redhat.com>
Sender: owner-linux-mm@kvack.org
To: Jon Masters <jcm@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, gary.robertson@linaro.org, Steve Capper <steve.capper@linaro.org>, mark.rutland@arm.com, hughd@google.com, christoffer.dall@linaro.org, akpm@linux-foundation.org, mgorman@suse.de, linux@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, will.deacon@arm.com, dann.frazier@canonical.com, anders.roxell@linaro.org
List-Id: linux-arch.vger.kernel.org

On Mon, Mar 02, 2015 at 06:06:14AM -0500, Jon Masters wrote:

> 64-bit writes are /usually/ atomic but alignment or compiler emiting
> 32-bit opcodes could also do it. I agree there are a few other pieces
> to this we will chat about separately and come back to this thread.

Looking at the asm will quickly tell you if its emitting 32bit stores or
not. If it is, use WRITE_ONCE() (you should anyway I suppose) and see if
that cures it, if not file a compiler bug, volatile stores should never
be split.

As to alignment, you can simply put a BUG_ON((unsigned long)ptep & 7);
in there.

Also:

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>

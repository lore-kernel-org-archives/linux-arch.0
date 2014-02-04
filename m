From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mips octeon memory model questions
Date: Tue, 4 Feb 2014 10:58:40 -0800
Message-ID: <CA+55aFz9+AtK_OnUhH0gspUsXLxZN-MRwKVR5zVPsVGmGpBqxg@mail.gmail.com>
References: <20140204184150.GB5002@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vb0-f45.google.com ([209.85.212.45]:52738 "EHLO
	mail-vb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828AbaBDS6l (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 Feb 2014 13:58:41 -0500
In-Reply-To: <20140204184150.GB5002@laptop.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Daney <ddaney@caviumnetworks.com>, Ralf Baechle <ralf@linux-mips.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mips <linux-mips@linux-mips.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>

On Tue, Feb 4, 2014 at 10:41 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Still doesn't make sense, because if we need the first sync to stop
> writes from being re-ordered with the ll-sc, we also need the second
> sync to avoid the same.

Presumably octeon doesn't do speculative writes, only *buffered* writes.

So writes move down, not up.

But it looks like Cavium is one of those clown companies that have a
"contact us" button for technical documentation rather than actually
making it available.

Christ, why would anybody do business with a tech company that hides
technical details? Seriously, that just stinks of "we have so many
bugs that we cannot make the documentation available".

                  Linus

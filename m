Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:36779 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755379AbXLTNCY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 20 Dec 2007 08:02:24 -0500
Date: Thu, 20 Dec 2007 14:00:42 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH -mm 00/43] user_regset framework -- arch maintainers
	take note!
Message-ID: <20071220130042.GA28770@elte.hu>
References: <20071220115200.C767E26F98A@magilla.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071220115200.C767E26F98A@magilla.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Roland McGrath <roland@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org


* Roland McGrath <roland@redhat.com> wrote:

> This is a large series of patches, but there are only a couple that 
> you need to read in detail to know how to get started on cleaning up 
> your arch code (1, 4, 6).
> 
> user_regset is a new kernel-internal interface into the arch code for 
> accessing the user-space view of machine-specific state (registers et 
> al--everything machine-specific that is visible via ptrace and the 
> like, or should be).  The idea is that arch code will have just one 
> place it has to support fetching and changing the user-visible machine 
> state of a user thread.  This same interface can be used for writing 
> core dumps, to underlie the implementation of PTRACE_GETREGS, 
> PTRACE_SETREGS, and the like, and by any new set of debugging 
> facilities that might come along.
[...]
> Patches 26 through 43 affect only arch/x86 code.  I have not CC'd 
> these ones to linux-arch.  They include a bunch of cleanup that is 
> specific to the idiosyncracies of the x86 code and isn't interesting 
> as an example for what another arch would do.

thanks Roland - this is a really impressive set of cleanups 
generalizations!

Testing feedback: i've put the x86 and core bits into x86.git and your 
regset series has so far successfully passed a couple of hundred 
iterations of random-qa on 32-bit and 64-bit x86 as well. (with a few 
ptrace tests added to the mix as well) So it's all green as far as 
arch/x86 and core goes :-)

	Ingo

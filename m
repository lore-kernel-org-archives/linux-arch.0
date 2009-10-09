From: jim owens <jowens@hp.com>
Subject: Re: [RFC][PATCH] kmap_atomic_push
Date: Fri, 09 Oct 2009 08:15:42 -0400
Message-ID: <4ACF296E.3000000@hp.com>
References: <1255016123.17055.17.camel@laptop>	 <20091008155344.GA11727@elte.hu> <1255019362.26976.311.camel@twins>	 <alpine.LFD.2.01.0910080945230.3432@localhost.localdomain>	 <Pine.LNX.4.64.0910081850270.4553@sister.anvils>  <4ACE674E.30403@hp.com> <1255042636.17055.33.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760741AbZJIMRR@vger.kernel.org>
In-Reply-To: <1255042636.17055.33.camel@laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Hugh Dickins <hugh.dickins@tiscali.co.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Avi Kivity <avi@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Peter Zijlstra wrote:
> 
> The double unmap gives a preemption point, which sounds like a good
> thing to have, because your scheme could run for a long while without
> enabling preemption, which is badness.

Thanks, optimizing my loop, I forgot all about
the old long code path not preempting problem.

Now I have to love the patch for making it harder to be stupid :)

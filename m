Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 14 Dec 2005 09:31:33 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051214083133.GA17532@elte.hu>
References: <439EDC3D.5040808@nortel.com> <1134479118.11732.14.camel@localhost.localdomain> <dhowells1134431145@warthog.cambridge.redhat.com> <3874.1134480759@warthog.cambridge.redhat.com> <15167.1134488373@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15167.1134488373@warthog.cambridge.redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Christopher Friesen <cfriesen@nortel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


* David Howells <dhowells@redhat.com> wrote:

>  (3) Some people want mutexes to be:
> 
>      (a) only releasable in the same context as they were taken
> 
>      (b) not accessible in interrupt context, or that (a) applies here also
> 
>      (c) not initialisable to the locked state
> 
>      But this means that the current usages all have to be carefully audited,
>      and sometimes that unobvious.

(a) and (c) is not a big problem, are they are essentially the 
constraints of -rt mutexes. As long as there's good debugging code, it's 
very much doable. We dont want to change semantics _yet again_, later 
down the line.

	Ingo

From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/7] Add assertion support with annotated oopsing
Date: Wed, 12 Oct 2011 18:23:09 +0100
Message-ID: <1362.1318440189@redhat.com>
References: <20111012165719.GA18407@elte.hu> <20111012164717.539.44368.stgit@warthog.procyon.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111012165719.GA18407@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:

> Looks useful, but i'd suggest to make this a variant of the standard 
> BUG_ON()/WARN_ON() checks we already have, not an explicit assert().
> 
> BUG_ON_VERBOSE() or such.

I personally prefer the positive check (ASSERT() saying that this expression
must be true) as opposed to the negative check (BUG_ON() saying that this must
be false).  I find it easier to think about the logic (I expect value X to be
like this, value Y to be like that, etc.).

That said, I could make the base bit BUG_VERBOSE(FMT, ...) and wrap ASSERT*()
around that.

However, I'd _much_ rather make it so that I can post the "cut here" message
early - but, IIRC, Linus hated that idea.

> I find assert()'s inversion confusing when mixed with WARN_ON()/BUG_ON().

Why did we do it this way originally, rather than using assert, I wonder?
Especially since the concept of assert already exists in userspace.

> Likewise, the message of:
> 
>        	ASSERTION FAILED at fs/dcache.c:863!
> 
> is rather confusing to me (i never know how the condition printed is 
> to be interpreted) - why not use the usual 'BUG: ...' message 
> convention?

I don't see why it should be confusing.  Something bad happened at file:line.

I could make it print "BUG" instead.  That's a minor matter.  The ASSERT
macros in patch 2 could then generate a report that looks like this:

	------------[ cut here ]------------
	kernel BUG at fs/fscache/main.c:109!
	Assertion failed: 2 > c is false
	invalid opcode: 0000 [#1] SMP

David

From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: cmpxchg and x86 flags output
Date: Tue, 21 Jun 2016 10:00:11 -0700
Message-ID: <F800D95C-A84C-4F54-9620-F28465AC4A16@zytor.com>
References: <5e5b99d7-c739-9743-b3e0-fbe0636d6dee@zytor.com> <40fd5f74-190e-b805-fbaa-f84899190fbc@zytor.com> <20160615085002.GC30935@twins.programming.kicks-ass.net> <4467.1466499980@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4467.1466499980@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On June 21, 2016 2:06:20 AM PDT, David Howells <dhowells@redhat.com> wrote:
>H. Peter Anvin <hpa@zytor.com> wrote:
>
>> Well, that sounds promising.  I wonder how David's model, using
>> intrinsics (do we have enough intrinsics to actually be able to do
>this
>> "correctly"?), compare to using the flags output from assembly.
>
>There is an advantage to using the intriniscs on arches with explicit
>barriers.  On powerpc64, for example, the compiler can move the release
>memory
>barrier earlier to push register-only instructions between the barrier
>and the
>lwarx.  This would allow the memory barrier to be executed concurrently
>with
>those instructions.
>
>The compiler could also move the acquire memory barrier later, pulling
>register-only instructions between the stwcx and that barrier, though I
>don't
>see any advantage to doing so.
>
>Whereas if the release barrier is in the same asm block as the lwarx,
>the
>compiler cannot do anything with it.
>
>
>Another advantage is that the compiler can switch between instruction
>variants
>automatically, allowing us to get rid of the size-based switch
>statements for
>things like cmpxchg().
>
>
>However, there's probably not a great deal of difference to be had if
>the
>inline asm codes the appropriate instruction in each case for something
>like
>x86*.  The emitted code ought to look the same.  The second biggest win
>for
>the intriniscs, I think, is the ability to ask the CMPXCHG instruction
>whether
>it actually did anything rather than comparing the result.  I added two
>variants, one that only returned the yes/no and one that passed back
>the value
>as well as the yes/no.
>
>David

The question for me is for things like lock patching that we do on x86...
-- 
Sent from my Android device with K-9 Mail. Please excuse brevity and formatting.

From: Nick Piggin <npiggin@gmail.com>
Subject: Re: Big git diff speedup by avoiding x86 "fast string" memcmp
Date: Mon, 13 Dec 2010 19:25:05 +1100
Message-ID: <AANLkTimeWSEUU6EYa4yWY11OyAVQqNu5eoBZc5ddqHQL@mail.gmail.com>
References: <20101209070938.GA3949@amd>
	<19324.1291990997@jrobl>
	<20101213014553.GA6522@amd>
	<9580.1292225351@jrobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <9580.1292225351@jrobl>
Sender: linux-fsdevel-owner@vger.kernel.org
To: "J. R. Okajima" <hooanon05@yahoo.co.jp>
Cc: Nick Piggin <npiggin@kernel.dk>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Dec 13, 2010 at 6:29 PM, J. R. Okajima <hooanon05@yahoo.co.jp> wrote:
>
> Nick Piggin:
>> It's not scaling but just single threaded performance. gcc turns memcmp
>> into rep cmp, which has quite a long latency, so it's not appripriate
>> for short strings.
>
> Honestly speaking I doubt how this 'long *' approach is effective
> (Of course it never means that your result (by 'char *') is doubtful).

Well, let's see what turns up. We certainly can try the long *
approach. I suspect on architectures where byte loads are
very slow, gcc will block the loop into larger loads, so it should
be no worse than a normal memcmp call, but if we do explicit
padding we can avoid all the problems associated with tail
handling.

Doing name padding and long * comparison will be practically
free (because slab allocator will align out to sizeof(long long)
anyway), so if any architecture prefers to do the long loads, I'd
be interested to hear and we could whip up a patch.

> But is the "rep cmp has quite a long latency" issue generic for all x86
> architecture, or Westmere system specific?

I don't believe it is Westmere specific. Intel and AMD have
been improving these instructions in the past few years, so
Westmere is probably as good or better than any.

That said, rep cmp may not be as heavily optimized as the
set and copy string instructions.

In short, I think the change should be suitable for all x86 CPUs,
but I would like to hear more opinions or see numbers for other
cores.

Thanks,
Nick

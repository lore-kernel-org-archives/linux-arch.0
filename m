From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Subject: Re: Big git diff speedup by avoiding x86 "fast string" memcmp
Date: Wed, 15 Dec 2010 12:38:40 +0800
Message-ID: <20101215043840.GA7692@cr0.nay.redhat.com>
References: <20101209070938.GA3949@amd>
 <19324.1291990997@jrobl>
 <20101213014553.GA6522@amd>
 <9580.1292225351@jrobl>
 <AANLkTimeWSEUU6EYa4yWY11OyAVQqNu5eoBZc5ddqHQL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTimeWSEUU6EYa4yWY11OyAVQqNu5eoBZc5ddqHQL@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Nick Piggin <npiggin@gmail.com>
Cc: "J. R. Okajima" <hooanon05@yahoo.co.jp>, Nick Piggin <npiggin@kernel.dk>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Dec 13, 2010 at 07:25:05PM +1100, Nick Piggin wrote:
>On Mon, Dec 13, 2010 at 6:29 PM, J. R. Okajima <hooanon05@yahoo.co.jp> wrote:
>> But is the "rep cmp has quite a long latency" issue generic for all x86
>> architecture, or Westmere system specific?
>
>I don't believe it is Westmere specific. Intel and AMD have
>been improving these instructions in the past few years, so
>Westmere is probably as good or better than any.
>
>That said, rep cmp may not be as heavily optimized as the
>set and copy string instructions.
>
>In short, I think the change should be suitable for all x86 CPUs,
>but I would like to hear more opinions or see numbers for other
>cores.
>

How about other arch? If this is only for x86, shouldn't it be
protected by CONFIG_X86?

Thanks.

Return-Path: <wli@holomorphy.com>
Received: from holomorphy.com ([207.189.100.168]:12454 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261794AbUCaINx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Mar 2004 03:13:53 -0500
Date: Wed, 31 Mar 2004 00:13:49 -0800
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: generalize/fix wchan calculation via ELF sections
Message-ID: <20040331081349.GY791@holomorphy.com>
References: <20040331073539.GX791@holomorphy.com> <20040331100310.5afcde15.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040331100310.5afcde15.ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 30 Mar 2004 23:35:39 -0800 William Lee Irwin III <wli@holomorphy.com> wrote:
>> The following patch generalizes/fixes wchan calculations via ELF sections.
>> I've tried to sweep all arches, which is where arch ppl come in.
>> Basically, I'm looking to see if I flubbed the patch and may not have
>> swept all arches properly, or whether arch maintainers dislike whatever
>> aspects of it since it goes poking around their code. Whatever kind of
>> feedback may be relevant wrt. methods/cleanliness/etc. is also good.

On Wed, Mar 31, 2004 at 10:03:10AM +0200, Andi Kleen wrote:
> Looks good to me. Thanks for doing this work.
> -Andi

Good to get an ack there. One fear that I had was that the "cleanup" of
the semaphore functions being integrated (at Anton's request) may have
been too invasive for people, especially when I only have about 4 or 5
arches to do testing on. It's where the majority of the arch impact lies.

Can I get at least one more ack before pushing things out to lkml?
That's where someone might snarf this for some tree or other and
generate bugreports if I flubbed something, so I'm keeping a lid on it
until it's had time to "cook" or otherwise pass at least minimalistic
arch maintainer review. Hey, this is a stable series -- I think I'm
doing the right thing here.

I realize it's off-hours on .us west coast and/or that $TZ may vary.
I'll be conservative and hold out at least for the clock to roll over
worldwide before spraying it out for general consumption.

Thanks.


-- wli

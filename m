Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266509AbUHOGiK@vger.kernel.org>
Received: from holomorphy.com ([207.189.100.168]:10398 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266508AbUHOGiK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 15 Aug 2004 02:38:10 -0400
Date: Sat, 14 Aug 2004 23:38:01 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: clear_user_highpage()
Message-ID: <20040815063801.GY11200@holomorphy.com>
References: <20040811161537.5e24c2b6.davem@redhat.com> <Pine.LNX.4.58.0408111635160.1839@ppc970.osdl.org> <20040812004654.GX11200@holomorphy.com> <Pine.LNX.4.58.0408111905210.1839@ppc970.osdl.org> <20040811194317.0acf4ae3.davem@redhat.com> <Pine.LNX.4.58.0408112113310.1839@ppc970.osdl.org> <20040812044634.GF11200@holomorphy.com> <20040814232223.5e1aea52.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040814232223.5e1aea52.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, davem@redhat.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

William Lee Irwin III <wli@holomorphy.com> wrote:
>>  For lock amortization it's extremely effective. Its effects on caching
>>  have never been properly instrumented that I know of.

On Sat, Aug 14, 2004 at 11:22:23PM -0700, Andrew Morton wrote:
> No, we (me, mbligh) instrumented the crap out of it.  It turned out that
> the cache affinity was of very marginal benefit, if any.
> I cooked up an artificial benchmark which consisted of writing 32k to a
> file, then truncating it back to zero, then repeating.  Four instances of
> that, against four separate files on 4-way showed a large speedup - 2x or
> 3x, from memory.  But for real-world workloads you really needed to squint
> to see anything at all.
> Which is why I dithered without sending it to Linus for a couple of months.
> Ended up merging it anyway because of some lock contention benefits, and
> because someone mught have a workload which involves repeated
> write/truncate looping ;)

I had more in mind that it had never been explained why the cache
affinity was ineffective, which would seem to require getting some
instrumentation of how often the lists were being turned over, how many
remote frees are going on, how "out of order" frees are, etc. etc. What
I heard at the time was that none of those were instrumented.

-- wli

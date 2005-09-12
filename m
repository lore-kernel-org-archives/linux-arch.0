Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 12 Sep 2005 17:11:51 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/3][RFC] atomic_cmpxchg, atomic_inc_not_zero
Message-ID: <20050912161151.GB3458@linux-mips.org>
References: <432595D5.1090502@yahoo.com.au> <20050912153053.GA4778@in.ibm.com> <4325A1D7.103@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4325A1D7.103@yahoo.com.au>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: dipankar@in.ibm.com, linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, Sep 13, 2005 at 01:42:15AM +1000, Nick Piggin wrote:

> OK, once I run it past the arch maintainers I will post a new set to
> lkml (and cc you). If you are feeling brave, the atomic_cmpxchg on
> ppc64 is working with my lockless pagecache patches, but I simply
> haven't tested 3/3.
> 
> Anyway, please, arch maintainers: speak now if there is something
> really nasty about doing this on your arch. Otherwise, if you can
> cook up optimised versions then please send them to me. If not, I'll
> try to do the dumb implementations as best I can.

MIPS bits look ok.

  Ralf

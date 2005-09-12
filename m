Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 12 Sep 2005 13:46:46 -0700 (PDT)
Message-Id: <20050912.134646.120176324.davem@davemloft.net>
Subject: Re: [PATCH 1/3][RFC] atomic_cmpxchg, atomic_inc_not_zero
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <4325A1D7.103@yahoo.com.au>
References: <432595D5.1090502@yahoo.com.au>
	<20050912153053.GA4778@in.ibm.com>
	<4325A1D7.103@yahoo.com.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: nickpiggin@yahoo.com.au
Cc: dipankar@in.ibm.com, linux-arch@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
List-ID: <linux-arch.vger.kernel.org>

From: Nick Piggin <nickpiggin@yahoo.com.au>
Date: Tue, 13 Sep 2005 01:42:15 +1000

> Anyway, please, arch maintainers: speak now if there is something
> really nasty about doing this on your arch. Otherwise, if you can
> cook up optimised versions then please send them to me. If not, I'll
> try to do the dumb implementations as best I can.

I'm fine with the Sparc bits.

Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sun, 29 May 2005 13:41:25 -0700 (PDT)
Message-Id: <20050529.134125.107682485.davem@davemloft.net>
Subject: Re: Lots of possible arch breakage in cpu_idle!!
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050529165557.GA19922@twiddle.net>
References: <4299523F.90502@yahoo.com.au>
	<20050529165557.GA19922@twiddle.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: rth@twiddle.net
Cc: nickpiggin@yahoo.com.au, linux-arch@vger.kernel.org, akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>

From: Richard Henderson <rth@twiddle.net>
Date: Sun, 29 May 2005 09:55:57 -0700

> Do not add the substring "preempt" to the alpha subtree.

Have you decided not to implement preemption support
at all on Alpha?

I put a mostly working implementation into sparc64 purely so that I
don't have to tell people not to put preempt calls into the sparc64
arch code (as you are now) when making tree-wide changes like this.

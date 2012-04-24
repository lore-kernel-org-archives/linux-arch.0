From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [RFC][PATCH 3/3] math128, x86_64: Implement {mult,add}_u128 in
 64bit asm
Date: Tue, 24 Apr 2012 18:36:35 +0200
Message-ID: <1335285395.28150.204.camel@twins>
References: <20120424161039.293018424@chello.nl>
	 <20120424162224.588822231@chello.nl> <4F96D604.5050709@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:47906 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755481Ab2DXQgr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 Apr 2012 12:36:47 -0400
In-Reply-To: <4F96D604.5050709@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Juri Lelli <juri.lelli@gmail.com>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On Tue, 2012-04-24 at 09:34 -0700, H. Peter Anvin wrote:
> On 04/24/2012 09:10 AM, Peter Zijlstra wrote:
> 
> Are you sure that gcc won't simply generate this code already if given
> "unsigned __int128"?

It might, but I've been told some GCC versions had issues, also lots of
archs fall back to libgcc functions.

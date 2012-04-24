From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC][PATCH 3/3] math128, x86_64: Implement {mult,add}_u128 in
 64bit asm
Date: Tue, 24 Apr 2012 09:34:12 -0700
Message-ID: <4F96D604.5050709@zytor.com>
References: <20120424161039.293018424@chello.nl> <20120424162224.588822231@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:35547 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755323Ab2DXQei (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 24 Apr 2012 12:34:38 -0400
In-Reply-To: <20120424162224.588822231@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Juri Lelli <juri.lelli@gmail.com>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On 04/24/2012 09:10 AM, Peter Zijlstra wrote:

Are you sure that gcc won't simply generate this code already if given
"unsigned __int128"?

	-hpa

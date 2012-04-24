Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:45415 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757346Ab2DXTnP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 Apr 2012 15:43:15 -0400
Message-ID: <1335296582.28150.227.camel@twins>
Subject: Re: [RFC][PATCH 2/3] math128: Introduce {mult,add,cmp}_u128
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Tue, 24 Apr 2012 21:43:02 +0200
In-Reply-To: <CA+55aFyvBTDh_DkXs6Z6zFmjyYxvWaAEm9-rJDXhvPx8CpDiKA@mail.gmail.com>
References: <20120424161039.293018424@chello.nl>
	 <20120424162224.526249106@chello.nl>
	 <CA+55aFyvBTDh_DkXs6Z6zFmjyYxvWaAEm9-rJDXhvPx8CpDiKA@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Mime-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Juri Lelli <juri.lelli@gmail.com>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20120424194302.HpROv34I9-Kfn9hRA0QOnF02djQc8XUm8X3NoOy6dZY@z>

On Tue, 2012-04-24 at 12:37 -0700, Linus Torvalds wrote:
> Or at least stupid.
> 
I'll take stupid.. this bit-fiddling isn't something I've done lots of.

I'll go stare at gcc output now.. ;-)

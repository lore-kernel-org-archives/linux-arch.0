From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [RFC][PATCH 2/3] math128: Introduce {mult,add,cmp}_u128
Date: Wed, 25 Apr 2012 12:13:29 +0200
Message-ID: <1335348809.28150.251.camel@twins>
References: <20120424161039.293018424@chello.nl>
	 <20120424162224.526249106@chello.nl>
	 <CA+55aFyvBTDh_DkXs6Z6zFmjyYxvWaAEm9-rJDXhvPx8CpDiKA@mail.gmail.com>
	 <1335304497.28150.243.camel@twins>
	 <CA+55aFx_efN7A2H2VuRGZiyh2xcV=p6uoDLcVAW2JOqmJJNd1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:60258 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757857Ab2DYKNl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Apr 2012 06:13:41 -0400
In-Reply-To: <CA+55aFx_efN7A2H2VuRGZiyh2xcV=p6uoDLcVAW2JOqmJJNd1Q@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Juri Lelli <juri.lelli@gmail.com>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On Tue, 2012-04-24 at 18:46 -0700, Linus Torvalds wrote:
> Can you please make a gcc bug-report?
> 
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=53110

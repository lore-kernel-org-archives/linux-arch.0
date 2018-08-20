Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:45662 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbeHTTm7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Aug 2018 15:42:59 -0400
Date: Mon, 20 Aug 2018 09:26:39 -0700
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] locking: Remove an insn from spin and write locks
Message-ID: <20180820162639.GC25153@bombadil.infradead.org>
References: <20180820150652.29482-1-willy@infradead.org>
 <f24a32be-6a4f-0df8-4289-14adc1046f50@redhat.com>
 <20180820155002.GB25153@bombadil.infradead.org>
 <20180820155650.GG24082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820155650.GG24082@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20180820162639.Rpxg6ePcQrAepXubtFLf5YMPoedzyXRrxctD9saGwuM@z>

On Mon, Aug 20, 2018 at 05:56:50PM +0200, Peter Zijlstra wrote:
> Yeah, _acquire should be retained; sorry about loosing that. I'm neck
> deep into tlb invalidate stuff and wrote this without much thinking
> involved.

NP.  Here's the current version I've got, with some updated likely()
hints.

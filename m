From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [RFC][PATCH] irq: remove IRQF_DISABLED
Date: Mon, 2 Mar 2009 09:32:16 -0700
Message-ID: <20090302163215.GD14217@parisc-linux.org>
References: <1235996477.5330.174.camel@laptop> <20090302144303.GA30136@elte.hu> <20090302154748.GB14217@parisc-linux.org> <1236009588.5330.729.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:53681 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482AbZCBQcd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2009 11:32:33 -0500
Content-Disposition: inline
In-Reply-To: <1236009588.5330.729.camel@laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Mon, Mar 02, 2009 at 04:59:48PM +0100, Peter Zijlstra wrote:
> The idea is to mandate IRQF_DISABLED for everybody, and since it doesn't
> do any good to have it a flag if you have it always enabled, remove
> it ;-)

I don't have a problem with that.

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."

Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:60128 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932688AbeGIPpl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jul 2018 11:45:41 -0400
Date: Mon, 9 Jul 2018 17:45:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] devres: Explicitly align datai[] to 64-bit
Message-ID: <20180709154521.GS2512@hirez.programming.kicks-ass.net>
References: <20180709134550.29541-1-abrodkin@synopsys.com>
 <20180709140717.GR2476@hirez.programming.kicks-ass.net>
 <20180709141056.GR2512@hirez.programming.kicks-ass.net>
 <44727d3cebda7bee5b68fb388bd2fecfc6dc7b89.camel@synopsys.com>
 <20180709144925.GU2476@hirez.programming.kicks-ass.net>
 <20180709152958.565weccfaktqauef@lakrids.cambridge.arm.com>
 <20180709153427.GY2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709153427.GY2476@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "greg@kroah.com" <greg@kroah.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>
Message-ID: <20180709154521.XNfMK0Q1twAT4nZvDiKepS_bOl3dsa6A2MfBVOWkjEE@z>

On Mon, Jul 09, 2018 at 05:34:27PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 09, 2018 at 04:29:58PM +0100, Mark Rutland wrote:
> > Shouldn't that be 8? AFAICT, __alignof__(unsigned long long) is 8 on
> > x86_32:
> 
> Curious, I wonder why we put that align in atomic64_32 then.

Shiny, look at this: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=54188

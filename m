Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:55522 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751916AbeCPR7A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Mar 2018 13:59:00 -0400
Date: Fri, 16 Mar 2018 18:58:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: arc_usr_cmpxchg and preemption
Message-ID: <20180316175856.GD4043@hirez.programming.kicks-ass.net>
References: <1521045375.11552.27.camel@synopsys.com>
 <fdf30e76-f75d-9dda-26ca-ac011c41ee64@synopsys.com>
 <20180314175352.GP4064@hirez.programming.kicks-ass.net>
 <1521221606.4805.16.camel@synopsys.com>
 <b0283507-5ab7-e40b-74a7-3ddebafb076d@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0283507-5ab7-e40b-74a7-3ddebafb076d@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Message-ID: <20180316175856.-dbptipk2JlVHwRta2jNsdEy9CeH2wNA1KKrMqgkEQM@z>

On Fri, Mar 16, 2018 at 10:54:52AM -0700, Vineet Gupta wrote:
> I'd say just bite the bullet, write the patch and we can refine it there !

Just be glad its not futex.c proper ;-) I'll try and have a look later..

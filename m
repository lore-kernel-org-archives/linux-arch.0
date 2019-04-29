Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33941 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfD2OUx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Apr 2019 10:20:53 -0400
Date: Mon, 29 Apr 2019 19:50:36 +0530
From: Nishad Kamdar <nishadkamdar@gmail.com>
Subject: Re: [PATCH v3 2/5] nds32: Use the correct style for SPDX License
 Identifier
Message-ID: <20190429142013.GA12127@nishad>
References: <cover.1555427418.git.nishadkamdar@gmail.com>
 <f6a7c31f4e8b743a2877875ac3fc49ecb8b9eb0c.1555427419.git.nishadkamdar@gmail.com>
 <alpine.DEB.2.21.1904162034260.1780@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904162034260.1780@nanos.tec.linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Will Deacon <will.deacon@arm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Message-ID: <20190429142036.B2Kw_M3GZoO-lwIXNOF0ZbtkfajRVFYOYGOd74QRTtk@z>

On Tue, Apr 16, 2019 at 08:35:38PM +0200, Thomas Gleixner wrote:
> On Tue, 16 Apr 2019, Nishad Kamdar wrote:
> 
> > This patch corrects the SPDX License Identifier style
> > in the nds32 Hardware Architecture related files.
> > 
> > Suggested-by: Joe Perches <joe@perches.com>
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> 
> Actually instead of doing that we should fix the documentation. The
> requirement came from older binutils because they barfed on // style
> comments in ASM files. That's history as we upped the minimal binutil
> requirement.
> 
> Thanks,
> 
> 	tglx

Ok.

So according to license-rules.rst,
which says

"This has been fixed by now, but there are still older assembler
tools which cannot handle C++ style comments."

Now there are no assembler tools which cannot handle C++ comments ?
and the document should be changed accordingly ?

Thanks for the review.

Regards,
Nishad

From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 2/5] nds32: Use the correct style for SPDX License
 Identifier
Date: Tue, 16 Apr 2019 20:35:38 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1904162034260.1780@nanos.tec.linutronix.de>
References: <cover.1555427418.git.nishadkamdar@gmail.com> <f6a7c31f4e8b743a2877875ac3fc49ecb8b9eb0c.1555427419.git.nishadkamdar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f6a7c31f4e8b743a2877875ac3fc49ecb8b9eb0c.1555427419.git.nishadkamdar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishad Kamdar <nishadkamdar@gmail.com>
Cc: Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Will Deacon <will.deacon@arm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>, =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

On Tue, 16 Apr 2019, Nishad Kamdar wrote:

> This patch corrects the SPDX License Identifier style
> in the nds32 Hardware Architecture related files.
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>

Actually instead of doing that we should fix the documentation. The
requirement came from older binutils because they barfed on // style
comments in ASM files. That's history as we upped the minimal binutil
requirement.

Thanks,

	tglx

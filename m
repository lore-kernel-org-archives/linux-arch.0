Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46934 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751324AbdKANQu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 1 Nov 2017 09:16:50 -0400
Date: Wed, 1 Nov 2017 13:16:44 +0000
From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v5 01/30] regset: Add support for dynamically sized
 regsets
Message-ID: <20171101131644.GL19485@e103592.cambridge.arm.com>
References: <1509465082-30427-1-git-send-email-Dave.Martin@arm.com>
 <1509465082-30427-2-git-send-email-Dave.Martin@arm.com>
 <20171101114228.jm53aj7jx6j4mxhn@armageddon.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171101114228.jm53aj7jx6j4mxhn@armageddon.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, "H. J. Lu" <hjl.tools@gmail.com>, Okamoto Takayuki <tokamoto@jp.fujitsu.com>, libc-alpha@sourceware.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, Will Deacon <will.deacon@arm.com>, Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Message-ID: <20171101131644.EjdJ9sAA4_opgC9IMzVlWuU019BDWbeO9dgHUwWbptg@z>

On Wed, Nov 01, 2017 at 11:42:29AM +0000, Catalin Marinas wrote:
> On Tue, Oct 31, 2017 at 03:50:53PM +0000, Dave P Martin wrote:
> > Currently the regset API doesn't allow for the possibility that
> > regsets (or at least, the amount of meaningful data in a regset)
> > may change in size.
> > 
> > In particular, this results in useless padding being added to
> > coredumps if a regset's current size is smaller than its
> > theoretical maximum size.
> > 
> > This patch adds a get_size() function to struct user_regset.
> > Individual regset implementations can implement this function to
> > return the current size of the regset data.  A regset_size()
> > function is added to provide callers with an abstract interface for
> > determining the size of a regset without needing to know whether
> > the regset is dynamically sized or not.
> > 
> > The only affected user of this interface is the ELF coredump code:
> > This patch ports ELF coredump to dump regsets with their actual
> > size in the coredump.  This has no effect except for new regsets
> > that are dynamically sized and provide a get_size() implementation.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Dmitry Safonov <dsafonov@virtuozzo.com>
> > Cc: H. J. Lu <hjl.tools@gmail.com>
> > 
> > ---
> > 
> > **Dropped** Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> > **Dropped** Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > (due to bug fix applied against v4 of this patch.)
> 
> It seems that the Reviewed-by tags are still there ;). Anyway, on the

Oops, looks like that only happened on this patch.  I've removed
Alex's R-b from my own version in case of repost -- can you also
do the same?

> new patch:
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Cheers
---Dave

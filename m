From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [RFC PATCH 07/10] arm64/sve: Add vector length inheritance
 control
Date: Mon, 16 Jan 2017 13:34:44 +0000
Message-ID: <20170116133443.GP3699@e103592.cambridge.arm.com>
References: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
 <1484220369-23970-8-git-send-email-Dave.Martin@arm.com>
 <20170116122755.GH28060@E107787-LIN>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53578 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751358AbdAPNet (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Jan 2017 08:34:49 -0500
Content-Disposition: inline
In-Reply-To: <20170116122755.GH28060@E107787-LIN>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yao Qi <qiyaoltc@gmail.com>
Cc: linux-arch@vger.kernel.org, Florian Weimer <fweimer@redhat.com>, libc-alpha@sourceware.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, gdb@sourceware.org, Joseph Myers <joseph@codesourcery.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, linux-arm-kernel@lists.infradead.org, Alan Hayward <alan.hayward@arm.com>, Torvald Riegel <triegel@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>

On Mon, Jan 16, 2017 at 12:27:55PM +0000, Yao Qi wrote:
> On 17-01-12 11:26:06, Dave Martin wrote:
> > Currently the vector length is inherited across both fork() and
> > exec().
> > 
> > Inheritance across fork() is desirable both for creating a copy of
> > a process (traditional fork) or creating a thread (where we want
> > all threads to share the same VL by default).
> > 
> > Inheritance across exec() is less desirable, because of the ABI
> > impact of large vector lengths on the size of the signal frame --
> > when running a new binary, there is no guarantee that the new
> > binary is compatible with these ABI changes.
> > 
> > This flag makes the vector length non-inherited by default.
> 
> Can we make vector length inherited across fork but non-inherited
> across exec by default?

That is the behaviour: I always inherit across fork/clone, since
you are still running the same binary after those.

I could word the commit message a bit more clearly here.

Cheers
---Dave 

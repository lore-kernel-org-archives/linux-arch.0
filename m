From: Dave P Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH 1/5] arm64: signal: split frame link record from
 sigcontext structure
Date: Fri, 16 Jun 2017 10:30:50 +0100
Message-ID: <20170616093050.GH9227@e103592.cambridge.arm.com>
References: <1497535442-11586-1-git-send-email-Dave.Martin@arm.com>
 <1497535442-11586-2-git-send-email-Dave.Martin@arm.com>
 <20170615163747.GA17424@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ve1eur01on0080.outbound.protection.outlook.com ([104.47.1.80]:10351
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752360AbdFPJa5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 16 Jun 2017 05:30:57 -0400
Content-Disposition: inline
In-Reply-To: <20170615163747.GA17424@e104818-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>

On Thu, Jun 15, 2017 at 05:37:47PM +0100, Catalin Marinas wrote:
> On Thu, Jun 15, 2017 at 03:03:38PM +0100, Dave P Martin wrote:
> > In order to be able to increase the amount of the data currently
> > written to the __reserved[] array in the signal frame, it is
> > necessary to overwrite the locations currently occupied by the
> > {fp,lr} frame link record pushed at the top of the signal stack.
> >
> > In order for this to work, this patch detaches the frame link
> > record from struct rt_sigframe and places it separately at the top
> > of the signal stack.  This will allow subsequent patches to insert
> > data between it and __reserved[].
> >
> > This change relies on the non-ABI status of the placement of the
> > frame record with respect to struct sigframe: this status is
> > undocumented, but the placement is not declared or described in the
> > user headers, and known unwinder implementations (libgcc,
> > libunwind, gdb) appear not to rely on it.
> >
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
>
> I'm fine with this approach:
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks for the review.
Final testing should be complete early next week.

Cheers
---Dave
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

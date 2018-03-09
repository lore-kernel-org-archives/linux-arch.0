Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52666 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751096AbeCIOVJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Mar 2018 09:21:09 -0500
Date: Fri, 9 Mar 2018 14:21:05 +0000
From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v3] arm64: signal: Ensure si_code is valid for all fault
 signalsy
Message-ID: <20180309142105.GS32331@e103592.cambridge.arm.com>
References: <1520530865-26554-1-git-send-email-Dave.Martin@arm.com>
 <20180309134818.GE15537@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309134818.GE15537@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Catalin Marinas <catalin.marinas@arm.com>, James Morse <james.morse@arm.com>
Message-ID: <20180309142105.QjsWW7WSW6KVK5H66Q1DyUvkyAECFn3hpvYMrIvjk2U@z>

On Fri, Mar 09, 2018 at 01:48:19PM +0000, Will Deacon wrote:
> Hi Dave,
> 
> Thanks for resending this one separately -- I'll pick it up for 4.17.
> Just a minor thing:
> 
> On Thu, Mar 08, 2018 at 05:41:05PM +0000, Dave Martin wrote:
> > Changes since v2:
> > 
> >  * Rebased to v4.16-rc4.
> > 
> >  * Split out the SIGFPE related changes (which impact core/x86 code)
> >    into a separate series.
> > 
> > Original blurb:
> 
> In future, please put this sort of stuff ^^ after the '---', otherwise I
> have to manually remove it from the commit message when committing and
> one day I'll end up forgetting.

Oops, yes, just trim that off.  I'd moved that changelog from the
tearoff to the top of the "cover letter" for reviewer convenience,
but guess what, there's no cover letter now I've split this patch by
itself.

[removes face from palm]

Cheers
---Dave

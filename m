Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51974 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932133AbeCINsO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Mar 2018 08:48:14 -0500
Date: Fri, 9 Mar 2018 13:48:19 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3] arm64: signal: Ensure si_code is valid for all fault
 signals
Message-ID: <20180309134818.GE15537@arm.com>
References: <1520530865-26554-1-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520530865-26554-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Catalin Marinas <catalin.marinas@arm.com>, James Morse <james.morse@arm.com>
Message-ID: <20180309134819.MFaySv355lav8Q460dvi_4gtUP1ojntwv_N_crSKJ58@z>

Hi Dave,

Thanks for resending this one separately -- I'll pick it up for 4.17.
Just a minor thing:

On Thu, Mar 08, 2018 at 05:41:05PM +0000, Dave Martin wrote:
> Changes since v2:
> 
>  * Rebased to v4.16-rc4.
> 
>  * Split out the SIGFPE related changes (which impact core/x86 code)
>    into a separate series.
> 
> Original blurb:

In future, please put this sort of stuff ^^ after the '---', otherwise I
have to manually remove it from the commit message when committing and
one day I'll end up forgetting.

Cheers,

Will

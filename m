Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40388 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752052AbeCHQhK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Mar 2018 11:37:10 -0500
Date: Thu, 8 Mar 2018 16:37:14 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 3/3] arm64: signal: Ensure si_code is valid for all
 fault signals
Message-ID: <20180308163713.GD9573@arm.com>
References: <1519926248-12591-1-git-send-email-Dave.Martin@arm.com>
 <1519926248-12591-4-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519926248-12591-4-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Catalin Marinas <catalin.marinas@arm.com>, James Morse <james.morse@arm.com>
Message-ID: <20180308163714.kjO51iKpj8TXhhjE9QBnoMqZ3Df-OcoFt6M03ihXx4g@z>

Hi Dave,

On Thu, Mar 01, 2018 at 05:44:08PM +0000, Dave Martin wrote:
> Currently, as reported by Eric, an invalid si_code value 0 is
> passed in many signals delivered to userspace in response to faults
> and other kernel errors.  Typically 0 is passed when the fault is
> insufficiently diagnosable or when there does not appear to be any
> sensible alternative value to choose.

This looks good to me. Please could you rebase it on top of for-next/core,
so that I can apply it for 4.17? The other two patches in the series need
an Ack for the core changes, so it would be worth dealing with those
separately imo.

Cheers,

Will

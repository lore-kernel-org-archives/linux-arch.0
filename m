Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34106 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751587AbdKBQcq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Nov 2017 12:32:46 -0400
Date: Thu, 2 Nov 2017 16:32:49 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v5 00/30] ARM Scalable Vector Extension (SVE)
Message-ID: <20171102163248.GB595@arm.com>
References: <1509465082-30427-1-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1509465082-30427-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Okamoto Takayuki <tokamoto@jp.fujitsu.com>, kvmarm@lists.cs.columbia.edu, libc-alpha@sourceware.org, linux-arch@vger.kernel.org, Alan Hayward <alan.hayward@arm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christoffer Dall <christoffer.dall@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Oleg Nesterov <oleg@redhat.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, "H . J . Lu" <hjl.tools@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Michael Kerrisk <mtk.manpages@gmail.com>, linux-api@vger.kernel.org
Message-ID: <20171102163249.1l4uY48OMHOp3NU-lWBYbcSd4M0-UsjCX9aeWLg18OQ@z>

On Tue, Oct 31, 2017 at 03:50:52PM +0000, Dave Martin wrote:
> This series implements Linux kernel support for the ARM Scalable Vector
> Extension (SVE). [1]  It supersedes the previous v3: see [3] for link
> and full cover letter.
> 
> This is a minor update to v4, but does contain a couple of important
> fixes.

I've pushed a version of this series out to the arm64 devel branch, with
a view to putting it into next.

git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git devel

Please kick the tyres and let me know of any issues ASAP.

Will

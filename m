Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40242 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932079AbdK2PVi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Nov 2017 10:21:38 -0500
Date: Wed, 29 Nov 2017 15:21:40 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v5 00/30] ARM Scalable Vector Extension (SVE)
Message-ID: <20171129152140.GD10650@arm.com>
References: <1509465082-30427-1-git-send-email-Dave.Martin@arm.com>
 <877eu9dt3n.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877eu9dt3n.fsf@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Okamoto Takayuki <tokamoto@jp.fujitsu.com>, kvmarm@lists.cs.columbia.edu, libc-alpha@sourceware.org, linux-arch@vger.kernel.org, Alan Hayward <alan.hayward@arm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christoffer Dall <christoffer.dall@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Oleg Nesterov <oleg@redhat.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, "H . J . Lu" <hjl.tools@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Michael Kerrisk <mtk.manpages@gmail.com>, linux-api@vger.kernel.org
Message-ID: <20171129152140.NMvJeAtpCIHZ1auwm5p-tLOhNAS_iC2i8xo2R5OoTxM@z>

On Wed, Nov 29, 2017 at 03:04:12PM +0000, Alex Bennée wrote:
> 
> Dave Martin <Dave.Martin@arm.com> writes:
> 
> > This series implements Linux kernel support for the ARM Scalable Vector
> > Extension (SVE). [1]  It supersedes the previous v3: see [3] for link
> > and full cover letter.
> >
> > This is a minor update to v4, but does contain a couple of important
> > fixes.
> <snip>
> 
> I seem to have run into a regression with normal non-SVE sigcontexts
> while trying to run consecutive RISU runs in the Foundation Model. I'm
> failing to get repeatable results playing back a previous --master run.
> It works OK with the default Debian kernel.
> 
> What is the current status of the tree? I'd like to try an narrow it
> down but I seem to recall it was now in a next tree somewhere?

This is in mainline now, so please give a 4.15-rc1 build a spin. If there's
a user-visible regression then we need to get to the bottom of it ASAP.

Will

Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr00058.outbound.protection.outlook.com ([40.107.0.58]:42352
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754198AbdKBREp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Nov 2017 13:04:45 -0400
Date: Thu, 2 Nov 2017 17:04:34 +0000
From: Dave P Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v5 00/30] ARM Scalable Vector Extension (SVE)
Message-ID: <20171102170434.GD32200@e103592.cambridge.arm.com>
References: <1509465082-30427-1-git-send-email-Dave.Martin@arm.com>
 <20171102163248.GB595@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171102163248.GB595@arm.com>
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, "tokamoto@jp.fujitsu.com" <tokamoto@jp.fujitsu.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Alan Hayward <Alan.Hayward@arm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christoffer Dall <christoffer.dall@linaro.org>, Mark Rutland <Mark.Rutland@arm.com>, Oleg Nesterov <oleg@redhat.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, "H . J . Lu" <hjl.tools@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Michael Kerrisk <mtk.manpages@gmail.com>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Message-ID: <20171102170434.hdylPFdoK6iHvID7_Bb8aK2S7CnG7JlqmGwpTAhaxR0@z>

On Thu, Nov 02, 2017 at 04:32:49PM +0000, Will Deacon wrote:
> On Tue, Oct 31, 2017 at 03:50:52PM +0000, Dave Martin wrote:
> > This series implements Linux kernel support for the ARM Scalable Vector
> > Extension (SVE). [1]  It supersedes the previous v3: see [3] for link
> > and full cover letter.
> >
> > This is a minor update to v4, but does contain a couple of important
> > fixes.
>
> I've pushed a version of this series out to the arm64 devel branch, with
> a view to putting it into next.
>
> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git devel
>
> Please kick the tyres and let me know of any issues ASAP.

No obvious problems so far.

Cheers
---Dave
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

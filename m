Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35090 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753Ab3F2T5W (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 29 Jun 2013 15:57:22 -0400
Date: Sat, 29 Jun 2013 20:55:49 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] WIP: HACK: LPAE, BOOTMEM and NO_BOOTMEM
Message-ID: <20130629195549.GE3353@n2100.arm.linux.org.uk>
References: <1372467663-31425-1-git-send-email-santosh.shilimkar@ti.com> <20130629152959.GB31339@mtj.dyndns.org> <20130629172123.GA3353@n2100.arm.linux.org.uk> <20130629175743.GA382@mtj.dyndns.org> <CAE9FiQXHuP-n0eZ9wN73V4nSvE+XEExDsx1t50_=YaW+V=LGLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE9FiQXHuP-n0eZ9wN73V4nSvE+XEExDsx1t50_=YaW+V=LGLg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "David S. Miller" <davem@davemloft.net>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, linux-arch@vger.kernel.org
Message-ID: <20130629195549.VLEVykF6TV2WgcUjW4-81gsO4oH5VrUkkjjmm7rBlRE@z>

On Sat, Jun 29, 2013 at 12:29:55PM -0700, Yinghai Lu wrote:
> On Sat, Jun 29, 2013 at 10:57 AM, Tejun Heo <tj@kernel.org> wrote:
> > ( Expanding cc list, original thread is at
> >   http://thread.gmane.org/gmane.linux.kernel/1518046 )
> >
> > Hello,
> >
> > On Sat, Jun 29, 2013 at 06:21:24PM +0100, Russell King - ARM Linux wrote:
> >> Unfortunately, that has not been true on ARM - it's very common for
> >> there to be an offset on physical memory, sometimes of the order of
> >> 3GB or more.  This is because on reset, ARMs start executing the code
> >> at physical address zero, which therefore can't be RAM - and there's
> >> a desire to avoid complex switching games in hardware to temporarily
> >> map ROM there instead of RAM.
> >>
> >> On these SoCs which Santosh is working on, the main physical memory
> >> mapping is above 4GB, with just a small alias below 4GB to allow the
> >> system to boot without the MMU being on, as they may have more than
> >> 4GB of RAM.  As I understand it, the small alias below 4GB is not
> >> suitable for use as a "lowmem" mapping.
> 
> is that 32bit ARM or 64bit ARM?

Only 32-bit has LPAE.  Such things don't make sense on 64-bit CPUs.

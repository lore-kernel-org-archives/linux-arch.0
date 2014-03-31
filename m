From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] asm-generic: allow generic unaligned access if the
	arch supports it
Date: Mon, 31 Mar 2014 19:36:18 +0100
Message-ID: <20140331183618.GY7528@n2100.arm.linux.org.uk>
References: <1395942387-14177-1-git-send-email-ard.biesheuvel@linaro.org> <201403281914.20201.arnd@arndb.de> <CAKv+Gu_9yD1jWhxkPxSUbwjJk4QxPNXBR=EXfmfCgzD1Pdig2g@mail.gmail.com> <20140331095941.GA29871@arm.com> <CAKv+Gu_05nmZrQxwELXae4tiK=-MpjUjmEKrULdg+6YuC-DW8Q@mail.gmail.com> <20140331172436.GL29871@arm.com> <CAKv+Gu9RATUkhya0zytS8FbSM8=49xwNg0m24Xp1LtCWoarDRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:44351 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752442AbaCaSgp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 31 Mar 2014 14:36:45 -0400
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9RATUkhya0zytS8FbSM8=49xwNg0m24Xp1LtCWoarDRQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Rob Herring <robherring2@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Mar 31, 2014 at 08:22:43PM +0200, Ard Biesheuvel wrote:
> On 31 March 2014 19:24, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > It actually affects arch/arm as well which selects
> > HAVE_EFFICIENT_UNALIGNED_ACCESS for v6/v7 and uses the generic
> > unaligned.h
> >
> 
> Oops, my bad. I did a quick 'find -name unaligned.h' but misread 'arc'
> for 'arm'.
> 
> @Russell: ARM is a user of asm-generic/unaligned.h, and I proposed a
> patch to asm-generic that switches to unaligned accesses if
> HAVE_EFFICIENT_UNALIGNED_ACCESS is set by the arch. This should affect
> a fair amount of code living under net/ and drivers/ that don't test
> for the Kconfig symbol but expect get_unaligned_xx/put_unaligned_xx to
> turn into something suitable depending on the arch. Any objections?

I'm not sure what you're talking about here, or what change you're
proposing.  Without any kind of frame of reference, I can't comment.
Sorry.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.

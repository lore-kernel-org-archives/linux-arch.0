From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/2] arm/arm64: localise objcopy flags
Date: Tue, 19 Jul 2016 11:29:26 +0100
Message-ID: <20160719102925.GB27022@leverpostej>
References: <1468337282-14527-1-git-send-email-mark.rutland@arm.com>
 <a1441405-5a3a-731c-2693-b66cd42edc99@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34638 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752348AbcGSK3b (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 19 Jul 2016 06:29:31 -0400
Content-Disposition: inline
In-Reply-To: <a1441405-5a3a-731c-2693-b66cd42edc99@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Laura Abbott <labbott@redhat.com>, catalin.marinas@arm.com, will.deacon@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, keescook@chromium.org, linux@armlinux.org.uk

On Mon, Jul 18, 2016 at 04:16:34PM -0700, Laura Abbott wrote:
> On 07/12/2016 08:28 AM, Mark Rutland wrote:
> >Hi,
> >
> >Typically, architectures (including arm and arm64) define OBJCOPYFLAGS in their
> >top-level makefile, for the purpose of generating a raw binaries suitable for
> >booting, including Image, zImage, vmlinux.bin, etc.
> >
> >As this top-level arch makefile is included by the top-level kernel makefile,
> >these flags are passed to other invocations of objcopy tree-wide. This can
> >result in unexpected and inconsistent behaviour across architectures (e.g.
> >generation of a raw binary rather than an ELF [1]).
> >
> >Rather than force each new user of objcopy to specially clear OBJCOPYFLAGS,
> >this patch moves the existing OBJCOPYFLAGS variable definitions such that they
> >only affects the cases we require them for today, leaving the global namespace
> >clear.
> >
> >Other architectures will likely need similar treatment.
> >
> >Thanks,
> >Mark.
> >
> >[1] http://www.openwall.com/lists/kernel-hardening/2016/06/08/2
> >
> >Mark Rutland (2):
> >  arm64: localise Image objcopy flags
> >  arm: localise objcopy flags
> >
> > arch/arm/Makefile        | 1 -
> > arch/arm/boot/Makefile   | 2 ++
> > arch/arm64/Makefile      | 1 -
> > arch/arm64/boot/Makefile | 2 ++
> > 4 files changed, 4 insertions(+), 2 deletions(-)
> >
> 
> Kees' lkdtm tests compile and boot successfully with this patch for
> both arm and arm64 so you can add
> 
> Tested-by: Laura Abbott <labbott@redhat.com>

Cheers!

On the assumption that Russell is ok with the arm patch, I've dropped
that in the patch system (with tags) as 8588/1 [1].

Catalin, Will, I guess I should repost the arm64 patch come v4.8-rc1?

Thanks,
Mark.

[1] http://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8588/1

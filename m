From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 0/2] arm/arm64: localise objcopy flags
Date: Tue, 19 Jul 2016 15:35:08 +0100
Message-ID: <20160719143507.GG21256@e104818-lin.cambridge.arm.com>
References: <1468337282-14527-1-git-send-email-mark.rutland@arm.com>
 <a1441405-5a3a-731c-2693-b66cd42edc99@redhat.com>
 <20160719102925.GB27022@leverpostej>
 <20160719143141.GF21256@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36607 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752348AbcGSOfM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 19 Jul 2016 10:35:12 -0400
Content-Disposition: inline
In-Reply-To: <20160719143141.GF21256@e104818-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arch@vger.kernel.org, keescook@chromium.org, will.deacon@arm.com, linux@armlinux.org.uk, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org

On Tue, Jul 19, 2016 at 03:31:41PM +0100, Catalin Marinas wrote:
> On Tue, Jul 19, 2016 at 11:29:26AM +0100, Mark Rutland wrote:
> > On Mon, Jul 18, 2016 at 04:16:34PM -0700, Laura Abbott wrote:
> > > On 07/12/2016 08:28 AM, Mark Rutland wrote:
> > > >Mark Rutland (2):
> > > >  arm64: localise Image objcopy flags
> > > >  arm: localise objcopy flags
> > > >
> > > > arch/arm/Makefile        | 1 -
> > > > arch/arm/boot/Makefile   | 2 ++
> > > > arch/arm64/Makefile      | 1 -
> > > > arch/arm64/boot/Makefile | 2 ++
> > > > 4 files changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > 
> > > Kees' lkdtm tests compile and boot successfully with this patch for
> > > both arm and arm64 so you can add
> > > 
> > > Tested-by: Laura Abbott <labbott@redhat.com>
> > 
> > Cheers!
> > 
> > On the assumption that Russell is ok with the arm patch, I've dropped
> > that in the patch system (with tags) as 8588/1 [1].
> > 
> > Catalin, Will, I guess I should repost the arm64 patch come v4.8-rc1?
> 
> I queued them for 4.8. Thanks.

s/them/the arm64 patch/

-- 
Catalin

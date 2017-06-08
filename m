From: Will Deacon <will.deacon@arm.com>
Subject: Re: RISC-V Linux Port v2
Date: Thu, 8 Jun 2017 11:26:32 +0100
Message-ID: <20170608102632.GE6071@arm.com>
References: <20170607092342.GB30263@arm.com>
 <mhng-9bc0a031-a834-42cc-aec0-cfb2efc8fe0c@palmer-si-x1c4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45560 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751233AbdFHK0Z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Jun 2017 06:26:25 -0400
Content-Disposition: inline
In-Reply-To: <mhng-9bc0a031-a834-42cc-aec0-cfb2efc8fe0c@palmer-si-x1c4>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, albert@sifive.com, patches@groups.riscv.org

On Wed, Jun 07, 2017 at 02:54:16PM -0700, Palmer Dabbelt wrote:
> On Wed, 07 Jun 2017 02:23:42 PDT (-0700), will.deacon@arm.com wrote:
> > Hi Palmer,
> >
> > On Tue, Jun 06, 2017 at 03:59:50PM -0700, Palmer Dabbelt wrote:
> >> Thanks to everyone who has participated in the review process so far.  We've
> >> made a lot of changes since the v1 and while this isn't ready to go yet, I
> >> finally managed to get through everything in my inbox so I thought it would be
> >> a good time to submit a v2 so everyone is on the same page.
> >
> > [...]
> >
> >> [PATCH 13/17] RISC-V: Add include subdirectory
> >
> > This guy is too big, and got silently dropped by the mailing list. Any
> > chance you could split it up please, so that it can be reviewed?
> 
> Sorry about that.  It's online
> 
>   https://github.com/riscv/riscv-linux/commit/daaea1609cb5e8c93745c1ce112a06e90f5b663c
> 
> I'll be sure to split it up next time.  I can submit a v3 if you want?

It looks like you'll be submitting a v3 anyway, so if you could split it up
for that then it would be much appreciated.

Thanks,

Will

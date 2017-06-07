From: Will Deacon <will.deacon@arm.com>
Subject: Re: RISC-V Linux Port v2
Date: Wed, 7 Jun 2017 10:23:42 +0100
Message-ID: <20170607092342.GB30263@arm.com>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751008AbdFGJXf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Jun 2017 05:23:35 -0400
Content-Disposition: inline
In-Reply-To: <20170606230007.19101-1-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, olof@lixom.net, albert@sifive.com, patches@groups.riscv.org

Hi Palmer,

On Tue, Jun 06, 2017 at 03:59:50PM -0700, Palmer Dabbelt wrote:
> Thanks to everyone who has participated in the review process so far.  We've
> made a lot of changes since the v1 and while this isn't ready to go yet, I
> finally managed to get through everything in my inbox so I thought it would be
> a good time to submit a v2 so everyone is on the same page.

[...]

> [PATCH 13/17] RISC-V: Add include subdirectory

This guy is too big, and got silently dropped by the mailing list. Any
chance you could split it up please, so that it can be reviewed?

Thanks,

Will

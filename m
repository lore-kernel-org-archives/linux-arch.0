Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn1bon0092.outbound.protection.outlook.com ([157.56.111.92]:31280
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751363AbcENMuR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 14 May 2016 08:50:17 -0400
Date: Sat, 14 May 2016 15:49:50 +0300
From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 20/25] arm64:ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
Message-ID: <20160514124950.GA27841@yury-N73SV>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <2733875.IzutTZKHMc@wuerfel>
 <57347BD4.8010105@huawei.com>
 <4521594.dSmlmmAdFg@wuerfel>
 <20160512131948.GA30205@yury-N73SV>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20160512131948.GA30205@yury-N73SV>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-doc@vger.kernel.org, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, heiko.carstens@de.ibm.com, Hanjun Guo <guohanjun@huawei.com>, joseph@codesourcery.com, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, "jijun (D)" <jijun2@huawei.com>, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, agraf@suse.de, pinskia@gmail.com, klimov.linux@gmail.com, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, Andrew Pinski <apinski@cavium.com>, schwidefsky@de.ibm.com, christoph.muellner@theobroma-systems.com, jan.dakinevich@gmail.com
Message-ID: <20160514124950.J7-DTZdJ-uxOFyjPTJuP-P95qpHlOLI4MFr2H15HuAs@z>

On Thu, May 12, 2016 at 04:19:48PM +0300, Yury Norov wrote:

[...]

> > I think that's a good idea. The function used to be slightly different
> > for each architecture, but now it seems we have a significant number
> > of identical implementations that we could just merge them together
> > into one.
> > 
> > sys_mmap_pgoff was originally introduced as the common implementation
> > and it reduced the amount of duplication a lot, but as its units
> > are based on PAGE_SIZE rather than hardwired 4096 bytes, it's
> > not as useful.
> > 
> 
> microblaze and mips (twice) are doing like this. And aarh32 as well,
> in arch/arm64/kernel/entry32.S
> 
> In previous submissions it was a patch that shares aarch32 code to
> ilp32. If we decided turn around again, I think, we'd pick up that patch.
> 
> The other option is to make this hack generic, as so many arches use it.

Hi again,

I picked up that old patch from Jan, and found that it doesn't delouse
addr and length, which is wrong for ilp32. So now I think we'd pick
Bamvor version.

Jan's patch (rebased) is attached for reference.

Yury.

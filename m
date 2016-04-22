Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn1on0082.outbound.protection.outlook.com ([157.56.110.82]:37312
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751219AbcDVWAF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 22 Apr 2016 18:00:05 -0400
Date: Sat, 23 Apr 2016 00:59:18 +0300
From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 12/25] arm64: compat: change config dependences to aarch32
Message-ID: <20160422215918.GB2234@yury-N73SV>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <1459894127-17698-13-git-send-email-ynorov@caviumnetworks.com>
 <20160422155818.GP2998@e104818-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20160422155818.GP2998@e104818-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, broonie@kernel.org, linux-doc@vger.kernel.org, heiko.carstens@de.ibm.com, agraf@suse.de, klimov.linux@gmail.com, bamvor.zhangjian@huawei.com, schwidefsky@de.ibm.com, Nathan_Lynch@mentor.com, Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com
Message-ID: <20160422215918.7aVHbXf6uJlvxR5SGPU2O4w6nvaLU11dbTKEJTAioqw@z>

On Fri, Apr 22, 2016 at 04:58:18PM +0100, Catalin Marinas wrote:
> On Wed, Apr 06, 2016 at 01:08:34AM +0300, Yury Norov wrote:
> > From: Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>
> > 
> > With the patches of ILP32, COMPAT is not equivalent to AARCH32 in EL0.
> > This patch fix this by updating the dependency from COMPAT to
> > AARCH32_EL0 for ARMV8_DEPRECATED and ARM64_ERRATUM_845719.
> > 
> > Signed-off-by: Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>
> > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> 
> Can you not merge patches 10-12 into a single one? They all deal with
> the s/COMPAT/AARCH32_EL0/ replacement. I'm not even sure the series is
> bisectable after patch 10.
> 
> -- 
> Catalin

 OK, if Bamvoor is not objecting
 

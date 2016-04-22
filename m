From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 18/25] arm64: ilp32: introduce binfmt_ilp32.c
Date: Fri, 22 Apr 2016 17:51:30 +0100
Message-ID: <20160422165130.GQ2998@e104818-lin.cambridge.arm.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <1459894127-17698-19-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35983 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754538AbcDVQvg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 22 Apr 2016 12:51:36 -0400
Content-Disposition: inline
In-Reply-To: <1459894127-17698-19-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, broonie@kernel.org, linux-doc@vger.kernel.org, heiko.carstens@de.ibm.com, agraf@suse.de, klimov.linux@gmail.com, bamvor.zhangjian@huawei.com, schwidefsky@de.ibm.com, Nathan_Lynch@mentor.com, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com

On Wed, Apr 06, 2016 at 01:08:40AM +0300, Yury Norov wrote:
> --- /dev/null
> +++ b/arch/arm64/kernel/binfmt_ilp32.c

[...]

> +#include "../../../fs/binfmt_elf.c"

How different is this new binfmt_ilp32.c file from the first part of
compat_binfmt_elf.c? I wonder whether we could include the latter here
instead and make this similar to binfmt_elf32.c introduced by the
previous patch.

-- 
Catalin

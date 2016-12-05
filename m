Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751176AbcLEQSb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 5 Dec 2016 11:18:31 -0500
Date: Mon, 5 Dec 2016 16:18:24 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 14/18] arm64: signal32: move ilp32 and aarch32 common
 code to separated file
Message-ID: <20161205161823.GF14429@e104818-lin.cambridge.arm.com>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <1477081997-4770-15-git-send-email-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1477081997-4770-15-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, philipp.tomsich@theobroma-systems.com, joseph@codesourcery.com, zhouchengming1@huawei.com, Prasun.Kapoor@caviumnetworks.com, agraf@suse.de, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, pinskia@gmail.com, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org, bamvor.zhangjian@huawei.com, maxim.kuvyrkov@linaro.org, Nathan_Lynch@mentor.com, schwidefsky@de.ibm.com, davem@davemloft.net, christoph.muellner@theobroma-systems.com
Message-ID: <20161205161824.0a2TB1qiFCJnL66f8_moXyN-BKtkrw2qmjFmzD1TmCw@z>

On Fri, Oct 21, 2016 at 11:33:13PM +0300, Yury Norov wrote:
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>

Please add some description, even if it means copying the subject.

> ---
>  arch/arm64/include/asm/signal32.h        |   3 +
>  arch/arm64/include/asm/signal32_common.h |  27 +++++++
>  arch/arm64/kernel/Makefile               |   2 +-
>  arch/arm64/kernel/signal32.c             | 107 ------------------------
>  arch/arm64/kernel/signal32_common.c      | 135 +++++++++++++++++++++++++++++++
>  5 files changed, 166 insertions(+), 108 deletions(-)
>  create mode 100644 arch/arm64/include/asm/signal32_common.h
>  create mode 100644 arch/arm64/kernel/signal32_common.c

I wonder whether you can make such patches more readable by setting
"diff.renames" to "copy" in your gitconfig (unless it's set already and
Git cannot detect partial file code moving/copying).

-- 
Catalin

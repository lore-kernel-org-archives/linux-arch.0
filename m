Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:44345 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752585AbcIBKtB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Sep 2016 06:49:01 -0400
Message-ID: <57C9587B.9080006@huawei.com>
Date: Fri, 2 Sep 2016 18:46:19 +0800
From: Bamvor Jian Zhang <bamvor.zhangjian@huawei.com>
MIME-Version: 1.0
Subject: Re: [PATCH 12/18] arm64: ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
References: <1471434403-25291-1-git-send-email-ynorov@caviumnetworks.com> <1471434403-25291-13-git-send-email-ynorov@caviumnetworks.com>
In-Reply-To: <1471434403-25291-13-git-send-email-ynorov@caviumnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>, arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, libc-alpha@sourceware.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@davemloft.net, zhouchengming1@huawei.com, cmetcalf@ezchip.com, Andrew Pinski <apinski@cavium.com>, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, Hanjun Guo <guohanjun@huawei.com>, chenjianguo 00365834 <chenjianguo3@huawei.com>, jijun 00321192 <jijun2@huawei.com>, zhangjian 00293696 <bamvor.zhangjian@huawei.com>
Message-ID: <20160902104619.We1-KdDHt5NbcQO0rtb21vTGIM1CTPhKywN6eFW_i-8@z>

Hi, Yury

On 08/17/2016 07:46 PM, Yury Norov wrote:
> From: Andrew Pinski <apinski@cavium.com>
> 
[...]
> diff --git a/arch/arm64/kernel/sys_ilp32.c b/arch/arm64/kernel/sys_ilp32.c
> new file mode 100644
> index 0000000..10fc0ca
> --- /dev/null
> +++ b/arch/arm64/kernel/sys_ilp32.c
> @@ -0,0 +1,86 @@
> +/*
> + * AArch64- ILP32 specific system calls implementation
> + *
> + * Copyright (C) 2016 Cavium Inc.
> + * Author: Andrew Pinski <apinski@cavium.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#define __SYSCALL_COMPAT
> +
> +#include <linux/compiler.h>
> +#include <linux/errno.h>
> +#include <linux/fs.h>
> +#include <linux/mm.h>
> +#include <linux/msg.h>
> +#include <linux/export.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/syscalls.h>
> +#include <linux/compat.h>
> +#include <asm-generic/syscalls.h>
> +
> +/*
> + * Using aarch32 syscall handlerss where off_t is passed.
> + */
> +#define compat_sys_fadvise64_64		compat_sys_fadvise64_64_wrapper
> +#define compat_sys_fallocate		compat_sys_fallocate_wrapper
> +#define compat_sys_fcntl64		sys_fcntl
> +#define compat_sys_ftruncate64		compat_sys_ftruncate64_wrapper
> +#define compat_sys_pread64		compat_sys_pread64_wrapper
> +#define compat_sys_pwrite64		compat_sys_pwrite64_wrapper
> +#define compat_sys_readahead		compat_sys_readahead_wrapper
> +#define compat_sys_shmat		sys_shmat
> +#define compat_sys_sync_file_range	compat_sys_sync_file_range2_wrapper
> +#define compat_sys_truncate64		compat_sys_truncate64_wrapper
When we test sync_file_range with our own testcase, we found that the parameter
sequence is not correct for sync_file_range2 because glibc think kernel use
the sync_file_range. So, in this patch we force to sync_file_range2.

Is it make sense to you?

Regards

Bamvor

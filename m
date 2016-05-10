Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:50018 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbcEJIhn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 May 2016 04:37:43 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 20/25] arm64:ilp32: add sys_ilp32.c and a separate table (in entry.S) to use it
Date: Tue, 10 May 2016 10:36:40 +0200
Message-ID: <9651510.pg5Vmm8vKS@wuerfel>
In-Reply-To: <573190CF.6030408@huawei.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com> <20160506123731.GA11959@yury-N73SV> <573190CF.6030408@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>, Yury Norov <ynorov@caviumnetworks.com>, linux-doc@vger.kernel.org, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, catalin.marinas@arm.com, heiko.carstens@de.ibm.com, Hanjun Guo <guohanjun@huawei.com>, joseph@codesourcery.com, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, "jijun (D)" <jijun2@huawei.com>, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, agraf@suse.de, pinskia@gmail.com, klimov.linux@gmail.com, broonie@kernel.org, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, Andrew Pinski <apinski@cavium.com>, schwidefsky@de.ibm.com, christoph.muellner@theobroma-systems.com
Message-ID: <20160510083640.Zb5EJXD4-qdBlXmBKPZKNbc64v2rMRig5PyIMYNHY7A@z>

On Tuesday 10 May 2016 15:42:07 Zhangjian wrote:
> On 2016/5/6 20:37, Yury Norov wrote:
> > On Fri, May 06, 2016 at 08:16:48PM +0800, Zhangjian (Bamvor) wrote:
> >
> > AFAIR, here we don't shift offset, as it's 64-bit both in user-
> > and kernel-space,
> In your ilp32-2.22 branch, you wrapper mmap to mmap2 in which type of
> offset is off_t. And off_t is 32bit in ilp32, correct?
> "sysdeps/unix/sysv/linux/aarch64/ilp32/mmap64.c"
> /* mmap is provided by mmap as they are the same. */
> void *__mmap (void *__addr, size_t __len, int __prot,
>                       int __flags, int __fd, __off_t __offset)
> {
>     void *result;
>     result = (void *)
>       INLINE_SYSCALL (mmap2, 6, __addr,
>                       __len, __prot, __flags, __fd, __offset);
>     return result;
> }

__off_t should be 'long long' on new architectures, and map
to __kernel_loff_t.

Can you see how it is defined?

	Arnd

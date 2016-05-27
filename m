Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:52962 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932456AbcE0Inm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 27 May 2016 04:43:42 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/23] all: syscall wrappers: add documentation
Date: Fri, 27 May 2016 10:42:59 +0200
Message-ID: <13240365.okADkKsTBJ@wuerfel>
In-Reply-To: <20160527060357.GB3820@osiris>
References: <6293194.tGy03QJ9ME@wuerfel> <20160527003753.GA14247@yury-N73SV> <20160527060357.GB3820@osiris>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Yury Norov <ynorov@caviumnetworks.com>, Catalin Marinas <catalin.marinas@arm.com>, David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, libc-alpha@sourceware.org, schwidefsky@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com
Message-ID: <20160527084259.DGmO_TbSNsBVC8su4pOT793rEuDvJJnb7Krh_aUvnZI@z>

On Friday, May 27, 2016 8:03:57 AM CEST Heiko Carstens wrote:
> > > > > Cost wise, this seems like it all cancels out in the end, but what
> > > > > do I know?
> > > > 
> > > > I think you know something, and I also think Heiko and other s390 guys
> > > > know something as well. So I'd like to listen their arguments here.
> 
> If it comes to 64 bit arguments for compat system calls: s390 also has an
> x32-like ABI extension which allows user space to use full 64 bit
> registers. As far as I know hardly anybody ever made use of that.
> 
> However even if that would be widely used, to me it wouldn't make sense to
> add new compat system calls which allow 64 bit arguments, simply because
> something like
> 
> c = (u32)a | (u64)b << 32;
> 
> can be done with a single 1-cycle instruction. It's just not worth the
> extra effort to maintain additional system call variants.

For reference, both tile and mips also have separate 32-bit ABIs that are
only used on 64-bit kernels (aside from the normal 32-bit ABI). Tile
does it like s390 and passes 64-bit arguments as pairs, while MIPS
and x86 and pass them as single registers.

Tile is very similar to arm64 because it also uses the generic system
call table, which I think is a good argument to keep them in sync.

	Arnd

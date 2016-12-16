Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-cys01nam02on0053.outbound.protection.outlook.com ([104.47.37.53]:38439
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1760182AbcLPK5F (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 16 Dec 2016 05:57:05 -0500
Date: Fri, 16 Dec 2016 16:25:14 +0530
From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 3/3] mm: make pagoff_t type 64-bit
Message-ID: <20161216105514.GA466@yury-N73SV>
References: <1481461003-14361-1-git-send-email-ynorov@caviumnetworks.com>
 <1481461003-14361-4-git-send-email-ynorov@caviumnetworks.com>
 <2636242.RWRJivuddj@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2636242.RWRJivuddj@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: libc-alpha@sourceware.org, "Dr. Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, "Joseph S. Myers" <joseph@codesourcery.com>, zhouchengming1@huawei.com, "Kapoor, Prasun" <Prasun.Kapoor@caviumnetworks.com>, Alexander Graf <agraf@suse.de>, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, Andrew Pinski <pinskia@gmail.com>, linyongting@huawei.com, Alexey Klimov <klimov.linux@gmail.com>, broonie@kernel.org, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, Nathan Lynch <Nathan_Lynch@mentor.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, davem@davemloft.net, christoph.muellner@theobroma-systems.com
Message-ID: <20161216105514.mkbKtrXNb0lEokTDLH1NkVxKgJh7tmUKz2vCQbr7iOM@z>

On Sun, Dec 11, 2016 at 03:59:01PM +0100, Arnd Bergmann wrote:
> On Sunday, December 11, 2016 6:26:42 PM CET Yury Norov wrote:
> > Also fix related interfaces
> > 
> > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> 
> Thanks Yury for the demonstration. I think this would put the nail
> in the coffin of the idea of mmap64 even for Pavel, who didn't
> seem convinced already.
> 
> Changing all those interfaces and structure, struct page in particular,
> is clearly too costly for any advantage we might have otherwise
> gained.
> 
> 	Arnd

To be complete, we have 3 options:
 1 leave things as is. 32-bit architectures will have no option to
   mmap big offsets, and no one cares - as usual.
 2 add mmap64() for compat arches only. This way we don't need patch
   3, and arches like aarch32 or aarch64/ilp32 will enjoy true 64-bit
   offsets.
 3 introduce CONFIG_64_BIT_PGOFF_T, and let Pavel enable it if he has
   to work with big files on 32-bit arches.

The most realistic approach for me is 1 because I never heard about
64-bit pgoff_t requests, except Pavel's one. Thinking about
aarch64/ilp32, we probably need second approach. This is only 2 simple
patches that are already there, and one patch in glibc. It will let
32-bit software work in 64-bit environment more smoothly. Cavium
people should be completely satisfied with 2.

Third is more looking like research exercise than something we need
in practice.

The only thing that makes me sad is that we proudly declare 64-bit
off_t in new 32-bit ABIs but in fact we lie, at least in this
specific case. We should add corresponding checks on glibc side at
least. It's also simple.

Yury.

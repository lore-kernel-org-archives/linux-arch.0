Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-sn1nam01on0041.outbound.protection.outlook.com ([104.47.32.41]:51116
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751985AbcLGKgf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Dec 2016 05:36:35 -0500
Date: Wed, 7 Dec 2016 16:04:51 +0530
From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [Question] New mmap64 syscall?
Message-ID: <20161207103451.GA869@yury-N73SV>
References: <20161206185440.GA4654@yury-N73SV>
 <3014428.VXGdOARdm1@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3014428.VXGdOARdm1@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: libc-alpha@sourceware.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, philipp.tomsich@theobroma-systems.com, joseph@codesourcery.com, zhouchengming1@huawei.com, Prasun.Kapoor@caviumnetworks.com, agraf@suse.de, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, pinskia@gmail.com, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org, bamvor.zhangjian@huawei.com, linux-arm-kernel@lists.infradead.org, maxim.kuvyrkov@linaro.org, Nathan_Lynch@mentor.com, schwidefsky@de.ibm.com, davem@davemloft.net, christoph.muellner@theobroma-systems.com
Message-ID: <20161207103451.9g-2MDc_GzPD13XfmN_uOYjR-VI7TQag42rvl7IhOEU@z>

On Tue, Dec 06, 2016 at 10:20:20PM +0100, Arnd Bergmann wrote:
> On Wednesday, December 7, 2016 12:24:40 AM CET Yury Norov wrote:
> > 3. Introduce new mmap64() syscall like this:
> > sys_mmap64(void *addr, size_t len, int prot, int flags, int fd, struct off_pair *off);
> > (The pointer here because otherwise we have 7 args, if simply pass off_hi and
> > off_lo in registers.)
> 
> This wouldn't have to be a pair, just a pointer to a 64-bit number.
> 
> > With new 64-bit interface we can deprecate mmap2(), and generalize all
> > implementations in kernel.
> > 
> > I think we can discuss it because 64-bit is the default size for off_t 
> > in all new 32-bit architectures. So generic solution may take place.
> > 
> > The last question here is how important to support offsets bigger than
> > 2^44 on 32-bit machines in practice? It may be a case for ARM64 servers,
> > which are looking like main aarch64/ilp32 users. If no, we can leave
> > things as is, and just do nothing.
> 
> If there is a use case for larger than 16TB offsets, we should add
> the call on all architectures, probably using your approach 3. I don't
> think that we should treat it as anything special for arm64 though.

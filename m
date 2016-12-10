From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Question] New mmap64 syscall?
Date: Sat, 10 Dec 2016 10:10:01 +0100
Message-ID: <20161210091001.GA17896@xo-6d-61-c0.localdomain>
References: <20161206185440.GA4654@yury-N73SV>
 <20161207163210.GB31779@e104818-lin.cambridge.arm.com>
 <DF57E4A6-85C9-44EF-AD03-19EA688D19DB@theobroma-systems.com>
 <12011325.PfzMMUCfyS@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57763 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752183AbcLJPSK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Dec 2016 10:18:10 -0500
Content-Disposition: inline
In-Reply-To: <12011325.PfzMMUCfyS@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Dr. Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>, Catalin Marinas <catalin.marinas@arm.com>, Yury Norov <ynorov@caviumnetworks.com>, libc-alpha@sourceware.org, linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, "Joseph S. Myers" <joseph@codesourcery.com>, zhouchengming1@huawei.com, "Kapoor, Prasun" <Prasun.Kapoor@caviumnetworks.com>, Alexander Graf <agraf@suse.de>, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, Andrew Pinski <pinskia@gmail.com>, linyongting@huawei.com, Alexey Klimov <klimov.linux@gmail.com>, broonie@kernel.org, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Maxim

Hi!

> > Most of these advantages should eventually go away, when struct-reorg makes
> > it way into the compiler. That said, it’s a marginal (but real) improvement for a
> > subset of SPEC.
> > 
> > In the real world, the importance of ILP32 as an aid to transition legacy code
> > that is not 64bit clean… and this should drive the ILP32 discussion. That we
> > get a boost in our SPEC scores is just a nice extra that we get from it 
> 
> To bring this back from the philosophical questions of ABI design
> to the specific point of what file offset width you want for mmap()
> on 32-bit architectures.
> 
> For all I can tell, using mmap() to access a file that is many thousand
> times larger than your virtual address space is completely crazy.

Dunno. Wanting to mmap part of a partition does not seem too crazy... I'm pretty
sure there's some tool out there that uses mmap(), just because mmap() was nicer
to use then read(). And when the partition is big, the offset may be big.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

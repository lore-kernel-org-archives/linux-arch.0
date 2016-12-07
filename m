From: "Dr. Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>
Subject: Re: [Question] New mmap64 syscall?
Date: Wed, 7 Dec 2016 17:43:27 +0100
Message-ID: <DF57E4A6-85C9-44EF-AD03-19EA688D19DB@theobroma-systems.com>
References: <20161206185440.GA4654@yury-N73SV> <3014428.VXGdOARdm1@wuerfel> <20161207103451.GA869@yury-N73SV> <0F280FED-870A-42B5-ABC4-1976ACA32462@theobroma-systems.com> <20161207123944.GA11799@yury-N73SV> <20161207163210.GB31779@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from vegas.theobroma-systems.com ([144.76.126.164]:36219 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752088AbcLGQnm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Dec 2016 11:43:42 -0500
In-Reply-To: <20161207163210.GB31779@e104818-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Yury Norov <ynorov@caviumnetworks.com>, Arnd Bergmann <arnd@arndb.de>, libc-alpha@sourceware.org, linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, "Joseph S. Myers" <joseph@codesourcery.com>, zhouchengming1@huawei.com, "Kapoor, Prasun" <Prasun.Kapoor@caviumnetworks.com>, Alexander Graf <agraf@suse.de>, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, Andrew Pinski <pinskia@gmail.com>, linyongting@huawei.com, Alexey Klimov <klimov.linux@gmail.com>, broonie@kernel.org, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, Nathan Lynch <Nathan_Lynch@mentor.com>Ma

Catalin,

> On 07 Dec 2016, at 17:32, Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
>>> In other words: Why not keep ILP32 simple an ask users that need a 16TB+ offset
>>> to use LP64? It seems much more consistent with the other choices takes so far.
>> 
>> If user can switch to lp64, he doesn't need ilp32 at all, right? :)
>> Also, I don't understand how true 64-bit offset in mmap64() would
>> complicate this port.
> 
> It's more like the user wanting a quick transition from code that was
> only ever compiled for AArch32 (or other 32-bit architecture) with a
> goal of full LP64 transition on the long run. I have yet to see
> convincing benchmarks showing ILP32 as an advantage over LP64 (of
> course, I hear the argument of reading a pointer a loop is twice as fast
> with a half-size pointer but I don't consider such benchmarks relevant).

Most of the performance advantage in benchmarks comes from a reduction
in the size of data-structures and/or tighter packing of arrays.  In other words,
we can make slightly better use of the caches and push the memory subsystem
a little further when running multiple instances of benchmarks.

Most of these advantages should eventually go away, when struct-reorg makes
it way into the compiler. That said, it’s a marginal (but real) improvement for a
subset of SPEC.

In the real world, the importance of ILP32 as an aid to transition legacy code
that is not 64bit clean… and this should drive the ILP32 discussion. That we
get a boost in our SPEC scores is just a nice extra that we get from it ;-)


Regards,
Philipp.
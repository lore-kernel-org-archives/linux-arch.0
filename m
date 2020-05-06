From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: RFC: Adding arch-specific user ABI documentation in linux-man
Date: Wed, 6 May 2020 12:47:33 +0200
Message-ID: <a86c4f3e-b50e-0541-074f-1bfcb4a93b5d@gmail.com>
References: <20200504153214.GH30377@arm.com>
 <20200505104454.GC19710@willie-the-truck>
 <20200505124351.GF1551@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726906AbgEFKrf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 May 2020 06:47:35 -0400
In-Reply-To: <20200505124351.GF1551@shell.armlinux.org.uk>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>
Cc: mtk.manpages@gmail.com, Dave Martin <Dave.Martin@arm.com>, linux-arch@vger.kernel.org, linux-man@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arm-kernel@lists.infradead.org

On 5/5/20 2:43 PM, Russell King - ARM Linux admin wrote:
> On Tue, May 05, 2020 at 11:44:55AM +0100, Will Deacon wrote:
>> Michael has been nagging me on and off about that for, what, 10 years now?
>> I would therefore be very much in favour of having our ptrace extensions
>> documented!
>>
>> We could even put this stuff under Documentation/arm64/man/ if it's deemed
>> too CPU-specific for the man-pages project, but my preference would still
>> be for it to be hosted there alongside all the other man pages.
> 
> Stuffing random things into the kernel tree is painful for some people.

Yes, and too often not easily noticeable for user-space programmers.
> 
> For example, if you cross-build your kernel, then the stuff in the
> tools/ subdirectory is totally useless (I think everything except
> perf) because you can't build it.
> 
> Let's stop making the mistake of constantly shoving stuff into the
> kernel source tree.

Agrred.

Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/

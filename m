From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: RFC: Adding arch-specific user ABI documentation in linux-man
Date: Wed, 6 May 2020 12:47:25 +0200
Message-ID: <66fbca56-bed7-d36a-9f97-395a3d82565e@gmail.com>
References: <20200504153214.GH30377@arm.com>
 <20200505104454.GC19710@willie-the-truck>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726906AbgEFKr1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 May 2020 06:47:27 -0400
In-Reply-To: <20200505104454.GC19710@willie-the-truck>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>, Dave Martin <Dave.Martin@arm.com>
Cc: mtk.manpages@gmail.com, Catalin Marinas <catalin.marinas@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org

>>  * man2/arm64-ptrace.2 (or man2/ptrace.2arm64): new page:
>>    arm64 ptrace extensions
> 
> Michael has been nagging me on and off about that for, what, 10 years now?

Perhaps not that long, but a while now ;-).

> I would therefore be very much in favour of having our ptrace extensions
> documented!
> 
> We could even put this stuff under Documentation/arm64/man/ if it's deemed
> too CPU-specific for the man-pages project, but my preference would still
> be for it to be hosted there alongside all the other man pages.

Agreed; manual pages is I think a better place.

Cheers,

Michael



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/

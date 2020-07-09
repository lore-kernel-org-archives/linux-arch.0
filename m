From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v6 26/26] arm64: mte: Add Memory Tagging Extension
 documentation
Date: Thu, 9 Jul 2020 15:43:48 +0100
Message-ID: <20200709144347.GA7758@gaia>
References: <20200703153718.16973-1-catalin.marinas@arm.com>
 <20200703153718.16973-27-catalin.marinas@arm.com>
 <20200709093253.GI32219@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgGIOnx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 Jul 2020 10:43:53 -0400
Content-Disposition: inline
In-Reply-To: <20200709093253.GI32219@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, Andrew Morton <akpm@linux-foundation.org>, libc-alpha@sourceware.org, nd@arm.com

On Thu, Jul 09, 2020 at 10:32:54AM +0100, Szabolcs Nagy wrote:
> The 07/03/2020 16:37, Catalin Marinas wrote:
> > +    /*
> > +     * To be compiled with -march=armv8.5-a+memtag
> > +     */
> > +    #include <errno.h>
> > +    #include <stdio.h>
> > +    #include <stdlib.h>
> > +    #include <unistd.h>
> > +    #include <sys/auxv.h>
> > +    #include <sys/mman.h>
> > +    #include <sys/prctl.h>
> 
> the example should now include stdint.h

Thanks. I should write user-space stuff more often ;)

-- 
Catalin

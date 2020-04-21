From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 20/23] fs: Allow copy_mount_options() to access
 user-space in a single pass
Date: Tue, 21 Apr 2020 17:45:43 +0100
Message-ID: <20200421164543.GC12076@gaia>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
 <20200421142603.3894-21-catalin.marinas@arm.com>
 <20200421152948.GC23230@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:38338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgDUQpr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Apr 2020 12:45:47 -0400
Content-Disposition: inline
In-Reply-To: <20200421152948.GC23230@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Richard Earnshaw <Richard.Earnshaw@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org

On Tue, Apr 21, 2020 at 04:29:48PM +0100, Al Viro wrote:
> On Tue, Apr 21, 2020 at 03:26:00PM +0100, Catalin Marinas wrote:
> > While this function is not on a critical path, the single-pass behaviour
> > is required for arm64 MTE (memory tagging) support where a uaccess can
> > trigger intra-page faults (tag not matching). With the current
> > implementation, if this happens during the first page, the function will
> > return -EFAULT.
> 
> Details, please.

With the arm64 MTE support (memory tagging extensions, see [1] for the
full series), bits 56..59 of a pointer (the tag) are checked against the
corresponding tag/colour set in memory (on a 16-byte granule). When
copy_mount_options() gets such tagged user pointer, it attempts to read
4K even though the user buffer is smaller. The user would only guarantee
the same matching tag for the data it masses to mount(), not the whole
4K or to the end of a page. The side effect is that the first
copy_from_user() could still fault after reading some bytes but before
reaching the end of the page.

Prior to commit 12efec560274 ("saner copy_mount_options()"), this code
had a fallback to byte-by-byte copying. I thought I'd not revert this
commit as the copy_mount_options() now looks cleaner.

[1] https://lore.kernel.org/linux-arm-kernel/20200421142603.3894-1-catalin.marinas@arm.com/

-- 
Catalin

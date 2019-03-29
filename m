Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58826 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728704AbfC2MWV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 29 Mar 2019 08:22:21 -0400
Date: Fri, 29 Mar 2019 12:22:16 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 4/5] arm64: compat: Add KUSER_HELPERS config option
Message-ID: <20190329122216.xa6va62qwyynoldt@mbp>
References: <20190319151542.19557-1-vincenzo.frascino@arm.com>
 <20190319151542.19557-5-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319151542.19557-5-vincenzo.frascino@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Jann Horn <jannh@google.com>, Mark Rutland <mark.rutland@arm.com>
Message-ID: <20190329122216.QcWLNNvlIv4Qr763SCbKc4TBYbZw8Q8C6eU7XjCswt8@z>

On Tue, Mar 19, 2019 at 03:15:41PM +0000, Vincenzo Frascino wrote:
> When kuser helpers are enabled the kernel maps the relative code at
> a fixed address (0xffff0000). Making configurable the option to disable
> them means that the kernel can remove this mapping and any access to
> this memory area results in a sigfault.
> 
> Add a KUSER_HELPERS config option that can be used to disable the
> mapping when it is turned off.
> 
> This option can be turned off if and only if the applications are
> designed specifically for the platform and they do not make use of the
> kuser helpers code.
> 
> Note: kuser helpers is disabled by default with 64K pages.

Actually this last sentence is more than just the default y/n for this
option. It adds a hard dependency, which means it cannot be enabled.
Currently we do allow COMPAT with 64K pages if EXPERT.

Is the main reason for this just to be able to subtract PAGE_SIZE for
TASK_SIZE_32 in the last patch? What happens if we leave TASK_SIZE_32
set to 0x100000000 for the 64K page configuration? Do we still have the
C99 issue mentioned in the cover letter (assuming that the last page is
already occupied by the vectors page)?

-- 
Catalin

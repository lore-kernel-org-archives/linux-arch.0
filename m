Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46680 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729803AbfASX5B (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 19 Jan 2019 18:57:01 -0500
Date: Sat, 19 Jan 2019 23:56:52 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 0/3] arm64: system call table generation for asm-generic
Message-ID: <20190119235650.GC26876@brain-police>
References: <1546530025-26014-1-git-send-email-firoz.khan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546530025-26014-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Stefan Agner <stefan@agner.ch>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Russell King <rmk+kernel@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org
Message-ID: <20190119235652.sZzQzCROqiRInAGHiQgp9ayJpjzvBKCnILsby7xgaDs@z>

On Thu, Jan 03, 2019 at 09:10:22PM +0530, Firoz Khan wrote:
> This will be an automated scripts to provide easy support
> for add/modify/delete the system call entry by add in 
> respective *.tbl file.
> 
> System call table generation support for asm-generic is
> provide for arm64 architecture which will use the common
> scripts resides in scripts directory and use syscall.tbl
> syscall_arm32.tbl files as inputs. This implementation 
> will replace asm-generic/unistd.h.
> 
> This patch depends on:
>  https://lore.kernel.org/lkml/1546439331-18646-1-git-send-email-firoz.khan@linaro.org/
>  https://lore.kernel.org/lkml/1546520681-24453-1-git-send-email-firoz.khan@linaro.org/

I'm having a hard time understanding what the benefit of this series is,
given that we only support EABI compat tasks. When adding a new compat
system call, you can't just blindly hook it up without checking whether it
needs a wrapper to deal with any type conversion etc, so really we're just
replacing one table with another as far as I can tell. What am I missing?

I also really don't think we should be generating the 32-bit UAPI headers
from the 64-bit compat system call support (if that's what you're trying to
do -- make headers_check fails with your patches applied). arch/arm/ is the
canonical place for the 32-bit UAPI, and we're just implementing that.

Will

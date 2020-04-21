From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH 0/6] Silence some instances of -Wtautological-compare and
 enable globally
Date: Mon, 20 Apr 2020 21:32:51 -0700
Message-ID: <20200421043251.GA4996@ubuntu-s3-xlarge-x86>
References: <20200219045423.54190-1-natechancellor@gmail.com>
 <20200420210332.7ff9652c8bdca7fb91ccfb0c@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDUEcy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Apr 2020 00:32:54 -0400
Content-Disposition: inline
In-Reply-To: <20200420210332.7ff9652c8bdca7fb91ccfb0c@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Michal Marek <michal.lkml@markovi.net>, Arnd Bergmann <arnd@arndb.de>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Jason Baron <jbaron@akamai.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, clang-built-linux@googlegroups.com

Hi Andrew,

On Mon, Apr 20, 2020 at 09:03:32PM -0700, Andrew Morton wrote:
> On Tue, 18 Feb 2020 21:54:17 -0700 Nathan Chancellor <natechancellor@gmail.com> wrote:
> 
> > Hi everyone,
> > 
> > This patch series aims to silence some instances of clang's
> > -Wtautological-compare that are not problematic and enable it globally
> > for the kernel because it has a bunch of subwarnings that can find real
> > bugs in the kernel such as
> > https://lore.kernel.org/lkml/20200116222658.5285-1-natechancellor@gmail.com/
> > and https://bugs.llvm.org/show_bug.cgi?id=42666, which was specifically
> > requested by Dmitry.
> > 
> > The first patch adds a macro that casts the section variables to
> > unsigned long (uintptr_t), which silences the warning and adds
> > documentation.
> > 
> > Patches two through four silence the warning in the places I have
> > noticed it across all of my builds with -Werror, including arm, arm64,
> > and x86_64 defconfig/allmodconfig/allyesconfig. There might still be
> > more lurking but those will have to be teased out over time.
> > 
> > Patch six finally enables the warning, while leaving one of the
> > subwarnings disabled because it is rather noisy and somewhat pointless
> > for the kernel, where core kernel code is expected to build and run with
> > many different configurations where variable types can be different
> > sizes.
> > 
> 
> For some reason none of these patches apply.  Not sure why - prehaps
> something in the diff headers.
> 
> Anyway, the kmemleak.c code has recently changed in ways which impact
> these patches.  Please take a look at that, redo, retest and resend?
> 
> 

Thank you for doubling back around to this but we are good here. These
warnings have all been fixed in Linus' tree without the need for the
first patch in the series.

For those curious:

63174f61dfaef ("kernel/extable.c: use address-of operator on section symbols")
bf2cbe044da27 ("tracing: Use address-of operator on section symbols")
8306b057a85ec ("lib/dynamic_debug.c: use address-of operator on section symbols")
b0d14fc43d392 ("mm/kmemleak.c: use address-of operator on section symbols")
afe956c577b2d ("kbuild: Enable -Wtautological-compare")

Cheers,
Nathan

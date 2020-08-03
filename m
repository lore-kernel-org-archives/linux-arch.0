From: Szabolcs Nagy <szabolcs.nagy@arm.com>
Subject: Re: [PATCH v7 29/29] arm64: mte: Add Memory Tagging Extension
 documentation
Date: Mon, 3 Aug 2020 13:43:10 +0100
Message-ID: <20200803124309.GC14398@arm.com>
References: <20200715170844.30064-1-catalin.marinas@arm.com>
 <20200715170844.30064-30-catalin.marinas@arm.com>
 <20200727163634.GO7127@arm.com>
 <20200728110758.GA21941@arm.com>
 <20200728145350.GR7127@arm.com>
 <20200728195957.GA31698@gaia>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr00059.outbound.protection.outlook.com ([40.107.0.59]:14673
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727831AbgHCMnZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 3 Aug 2020 08:43:25 -0400
Content-Disposition: inline
In-Reply-To: <20200728195957.GA31698@gaia>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Martin <Dave.Martin@arm.com>, linux-arch@vger.kernel.org, Peter Collingbourne <pcc@google.com>, Andrey Konovalov <andreyknvl@google.com>, Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, nd@arm.com

The 07/28/2020 20:59, Catalin Marinas wrote:
> On Tue, Jul 28, 2020 at 03:53:51PM +0100, Szabolcs Nagy wrote:
> > if linux does not want to add a per process
> > setting then only libc will be able to opt-in
> > to mte and only at very early in the startup
> > process (before executing any user code that
> > may start threads). this is not out of question,
> > but i think it limits the usage and deployment
> > options.
> 
> There is also the risk that we try to be too flexible at this stage
> without a real use-case.

i don't know how mte will be turned on in libc.

if we can always turn sync tag checks on early
whenever mte is available then i think there is
no issue.

but if we have to make the decision later for
compatibility or performance reasons then per
thread setting is problematic.

use of the prctl outside of libc is very limited
if it's per thread only:

- application code may use it in a (elf specific)
  pre-initialization function, but that's a bit
  obscure (not exposed in c) and it is reasonable
  for an application to enable mte checks after
  it registered a signal handler for mte faults.
  (and at that point it may be multi-threaded).

- library code normally initializes per thread
  state on the first call into the library from a
  given thread, but with mte, as soon as memory /
  pointers are tagged in one thread, all threads
  are affected: not performing checks in other
  threads is less secure (may be ok) and it means
  incompatible syscall abi (not ok). so at least
  PR_TAGGED_ADDR_ENABLE should have process wide
  setting for this usage.

but i guess it is fine to design the mechanism
for these in a later linux version, until then
such usage will be unreliable (will depend on
how early threads are created).

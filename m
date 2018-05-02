Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52273 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751011AbeEBObA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 May 2018 10:31:00 -0400
Subject: Re: [PATCH] pkeys: Introduce PKEY_ALLOC_SIGNALINHERIT and change
 signal semantics
References: <20180502132751.05B9F401F3041@oldenburg.str.redhat.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <248faadb-e484-806f-1485-c34a72a9ca0b@intel.com>
Date: Wed, 2 May 2018 07:30:56 -0700
MIME-Version: 1.0
In-Reply-To: <20180502132751.05B9F401F3041@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Florian Weimer <fweimer@redhat.com>, linux-mm@kvack.org, linux-api@vger.kernel.org, linux-x86_64@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org
Cc: linuxram@us.ibm.com

On 05/02/2018 06:26 AM, Florian Weimer wrote:
> pkeys support for IBM POWER intends to inherited the access rights of
> the current thread in signal handlers.  The advantage is that this
> preserves access to memory regions associated with non-default keys,
> enabling additional usage scenarios for memory protection keys which
> currently do not work on x86 due to the unconditional reset to the
> (configurable) default key in signal handlers.

What's the usage scenario that does not work?

> Consequently, this commit updates the x86 implementation to preserve
> the PKRU register value of the interrupted context in signal handlers.
> If a key is allocated successfully with the PKEY_ALLOC_SIGNALINHERIT
> flag, the application can assume this signal inheritance behavior.

I think this is a pretty gross misuse of the API.  Adding an argument to
pkey_alloc() is something that folks would assume would impact the key
being *allocated*, not pkeys behavior across the process as a whole.

> This change does not affect the init_pkru optimization because if the
> thread's PKRU register is zero due to the init_pkru setting, it will
> remain zero in the signal handler through inheritance from the
> interrupted context.

I think you are right, but it's rather convoluted.  It does:

1. Running with PKRU in the init state
2. Kernel saves off init-state-PKRU XSAVE signal buffer
3. Enter signal, kernel XRSTOR (may) set the init state again
4. fpu__clear() does __write_pkru(), takes it out of the init state
5. Signal handler runs, exits
6. fpu__restore_sig() XRSTOR's the state from #2, taking PKRU back to
   the init state

But, about the patch in general:

I'm not a big fan of doing this in such a PKRU-specific way.  It would
be nice to have this available for all XSAVE states.  It would also keep
you from so unnecessarily frobbing with WRPKRU in fpu__clear().  You
could just clear the PKRU bit in the Requested Feature BitMap (RFBM)
passed to XRSTOR.  That would be much straightforward and able to be
more easily extended to more states.

PKRU is now preserved on signal entry, but not signal exit.  Was that
intentional?  That seems like odd behavior, and also differs from the
POWER implementation as I understand it.

Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:48772 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728855AbfHBKIj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 2 Aug 2019 06:08:39 -0400
Date: Fri, 2 Aug 2019 11:08:35 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v6 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.rst
Message-ID: <20190802100835.GA4175@arrakis.emea.arm.com>
References: <cover.1563904656.git.andreyknvl@google.com>
 <20190725135044.24381-1-vincenzo.frascino@arm.com>
 <20190725135044.24381-2-vincenzo.frascino@arm.com>
 <b74e7ce7-d58a-68a0-2f28-6648ec6302c0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b74e7ce7-d58a-68a0-2f28-6648ec6302c0@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>
Message-ID: <20190802100835.tp62cXAfpIC0_xVof2agSrd-YE_7nNeBg7KS4llm7UA@z>

Hi Dave,

On Wed, Jul 31, 2019 at 09:43:46AM -0700, Dave Hansen wrote:
> On 7/25/19 6:50 AM, Vincenzo Frascino wrote:
> > With the relaxed ABI proposed through this document, it is now possible
> > to pass tagged pointers to the syscalls, when these pointers are in
> > memory ranges obtained by an anonymous (MAP_ANONYMOUS) mmap().
> 
> I don't see a lot of description of why this restriction is necessary.
> What's the problem with supporting MAP_SHARED?

We could support MAP_SHARED | MAP_ANONYMOUS (and based on some internal
discussions, this would be fine with the hardware memory tagging as
well). What we don't want in the ABI is to support file mmap() for
top-byte-ignore (or MTE). If you see a use-case, please let us know.

-- 
Catalin

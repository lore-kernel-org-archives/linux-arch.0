Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:30347 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730367AbfGaQnr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 31 Jul 2019 12:43:47 -0400
Subject: Re: [PATCH v6 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.rst
References: <cover.1563904656.git.andreyknvl@google.com>
 <20190725135044.24381-1-vincenzo.frascino@arm.com>
 <20190725135044.24381-2-vincenzo.frascino@arm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <b74e7ce7-d58a-68a0-2f28-6648ec6302c0@intel.com>
Date: Wed, 31 Jul 2019 09:43:46 -0700
MIME-Version: 1.0
In-Reply-To: <20190725135044.24381-2-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>
Message-ID: <20190731164346.MQ9Ykx2pUTJdfJceLK3GfEomv7zL1KSpq6fN_nsaCDI@z>

On 7/25/19 6:50 AM, Vincenzo Frascino wrote:
> With the relaxed ABI proposed through this document, it is now possible
> to pass tagged pointers to the syscalls, when these pointers are in
> memory ranges obtained by an anonymous (MAP_ANONYMOUS) mmap().

I don't see a lot of description of why this restriction is necessary.
What's the problem with supporting MAP_SHARED?

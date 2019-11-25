Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:53306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfKYRiB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 Nov 2019 12:38:01 -0500
Date: Mon, 25 Nov 2019 17:37:57 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] asm-generic/atomic: Prefer __always_inline for
 wrappers
Message-ID: <20191125173756.GF32635@lakrids.cambridge.arm.com>
References: <20191122154221.247680-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122154221.247680-1-elver@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marco Elver <elver@google.com>
Cc: will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, arnd@arndb.de, dvyukov@google.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kasan-dev@googlegroups.com, paulmck@kernel.org, Randy Dunlap <rdunlap@infradead.org>
Message-ID: <20191125173757.tYwoVvuH4xjzjnT1dlGakqnoIDXVs9Gzkc7omfLQsSM@z>

On Fri, Nov 22, 2019 at 04:42:20PM +0100, Marco Elver wrote:
> Prefer __always_inline for atomic wrappers. When building for size
> (CC_OPTIMIZE_FOR_SIZE), some compilers appear to be less inclined to
> inline even relatively small static inline functions that are assumed to
> be inlinable such as atomic ops. This can cause problems, for example in
> UACCESS regions.

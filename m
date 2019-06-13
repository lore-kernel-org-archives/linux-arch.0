Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relay.sw.ru ([185.231.240.75]:44680 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732000AbfFMMt6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Jun 2019 08:49:58 -0400
Subject: Re: [PATCH v4 1/3] lib/test_kasan: Add bitops tests
References: <20190613123028.179447-1-elver@google.com>
 <20190613123028.179447-2-elver@google.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <6cc5e12d-1492-d9b7-3ea7-6381407439d7@virtuozzo.com>
Date: Thu, 13 Jun 2019 15:50:06 +0300
MIME-Version: 1.0
In-Reply-To: <20190613123028.179447-2-elver@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marco Elver <elver@google.com>, peterz@infradead.org, dvyukov@google.com, glider@google.com, andreyknvl@google.com, mark.rutland@arm.com, hpa@zytor.com
Cc: corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, arnd@arndb.de, jpoimboe@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kasan-dev@googlegroups.com
Message-ID: <20190613125006.KQZeixwxsyOraJy6zvIj3D2dCvtAdWvRi9aNuKdIdO0@z>



On 6/13/19 3:30 PM, Marco Elver wrote:
> This adds bitops tests to the test_kasan module. In a follow-up patch,
> support for bitops instrumentation will be added.
> 
> Signed-off-by: Marco Elver <elver@google.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> ---

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>




> +static noinline void __init kasan_bitops(void)
> +{
> +	/*
> +	 * Allocate 1 more byte, which causes kzalloc to round up to 16-bytes;
> +	 * this way we do not actually corrupt other memory, in case
> +	 * instrumentation is not working as intended.

This sound like working instrumentation somehow save us from corrupting memory. In fact it doesn't,
it only reports corruption.

> +	 */
> +	long *bits = kzalloc(sizeof(*bits) + 1, GFP_KERNEL);
> +	if (!bits)
> +		return;
> +

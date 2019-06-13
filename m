Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relay.sw.ru ([185.231.240.75]:40140 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728558AbfFMKvO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Jun 2019 06:51:14 -0400
Subject: Re: [PATCH v3 3/3] asm-generic, x86: Add bitops instrumentation for
 KASAN
References: <20190531150828.157832-1-elver@google.com>
 <20190531150828.157832-4-elver@google.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <5b4babdb-dfae-4006-0608-a9f5814e89e9@virtuozzo.com>
Date: Thu, 13 Jun 2019 13:51:23 +0300
MIME-Version: 1.0
In-Reply-To: <20190531150828.157832-4-elver@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marco Elver <elver@google.com>, peterz@infradead.org, dvyukov@google.com, glider@google.com, andreyknvl@google.com, mark.rutland@arm.com, hpa@zytor.com
Cc: corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, arnd@arndb.de, jpoimboe@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kasan-dev@googlegroups.com
Message-ID: <20190613105123.qR7GDlkdxYC6mbSd8qmeLC_cIIQyJPYqf4Fv19t33LA@z>



On 5/31/19 6:08 PM, Marco Elver wrote:
> This adds a new header to asm-generic to allow optionally instrumenting
> architecture-specific asm implementations of bitops.
> 
> This change includes the required change for x86 as reference and
> changes the kernel API doc to point to bitops-instrumented.h instead.
> Rationale: the functions in x86's bitops.h are no longer the kernel API
> functions, but instead the arch_ prefixed functions, which are then
> instrumented via bitops-instrumented.h.
> 
> Other architectures can similarly add support for asm implementations of
> bitops.
> 
> The documentation text was derived from x86 and existing bitops
> asm-generic versions: 1) references to x86 have been removed; 2) as a
> result, some of the text had to be reworded for clarity and consistency.
> 
> Tested: using lib/test_kasan with bitops tests (pre-requisite patch).
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=198439
> Signed-off-by: Marco Elver <elver@google.com>

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>

Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relay.sw.ru ([185.231.240.75]:40084 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728554AbfFMKub (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Jun 2019 06:50:31 -0400
Subject: Re: [PATCH v3 2/3] x86: Use static_cpu_has in uaccess region to avoid
 instrumentation
References: <20190531150828.157832-1-elver@google.com>
 <20190531150828.157832-3-elver@google.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <d3f70d55-0308-a2e2-0f4a-1bdf6bcde544@virtuozzo.com>
Date: Thu, 13 Jun 2019 13:50:40 +0300
MIME-Version: 1.0
In-Reply-To: <20190531150828.157832-3-elver@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marco Elver <elver@google.com>, peterz@infradead.org, dvyukov@google.com, glider@google.com, andreyknvl@google.com, mark.rutland@arm.com, hpa@zytor.com
Cc: corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, arnd@arndb.de, jpoimboe@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kasan-dev@googlegroups.com
Message-ID: <20190613105040.z6k5tUI4hxLyoTVtLF5wXyiruD75RvJ1PRxfGKWNiVw@z>



On 5/31/19 6:08 PM, Marco Elver wrote:
> This patch is a pre-requisite for enabling KASAN bitops instrumentation;
> using static_cpu_has instead of boot_cpu_has avoids instrumentation of
> test_bit inside the uaccess region. With instrumentation, the KASAN
> check would otherwise be flagged by objtool.
> 
> For consistency, kernel/signal.c was changed to mirror this change,
> however, is never instrumented with KASAN (currently unsupported under
> x86 32bit).
> 
> Signed-off-by: Marco Elver <elver@google.com>
> Suggested-by: H. Peter Anvin <hpa@zytor.com>

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>

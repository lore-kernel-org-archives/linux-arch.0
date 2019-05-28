From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/3] lib/test_kasan: Add bitops tests
Date: Tue, 28 May 2019 17:50:48 +0100
Message-ID: <20190528165048.GD28492@lakrids.cambridge.arm.com>
References: <20190528163258.260144-1-elver@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190528163258.260144-1-elver@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marco Elver <elver@google.com>
Cc: peterz@infradead.org, aryabinin@virtuozzo.com, dvyukov@google.com, glider@google.com, andreyknvl@google.com, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org, arnd@arndb.de, jpoimboe@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kasan-dev@googlegroups.com
List-Id: linux-arch.vger.kernel.org

Hi,

On Tue, May 28, 2019 at 06:32:56PM +0200, Marco Elver wrote:
> +static noinline void __init kasan_bitops(void)
> +{
> +	long bits = 0;
> +	const long bit = sizeof(bits) * 8;

You can use BITS_PER_LONG here.

Thanks,
Mark.

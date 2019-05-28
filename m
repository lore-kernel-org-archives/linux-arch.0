Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:32984 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbfE1Quy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 May 2019 12:50:54 -0400
Date: Tue, 28 May 2019 17:50:48 +0100
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/3] lib/test_kasan: Add bitops tests
Message-ID: <20190528165048.GD28492@lakrids.cambridge.arm.com>
References: <20190528163258.260144-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528163258.260144-1-elver@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marco Elver <elver@google.com>
Cc: peterz@infradead.org, aryabinin@virtuozzo.com, dvyukov@google.com, glider@google.com, andreyknvl@google.com, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org, arnd@arndb.de, jpoimboe@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kasan-dev@googlegroups.com
Message-ID: <20190528165048.cqRCN2c7zTqbwpouKdJvtcI1w9oPQjf1LcCBCi_Hv24@z>

Hi,

On Tue, May 28, 2019 at 06:32:56PM +0200, Marco Elver wrote:
> +static noinline void __init kasan_bitops(void)
> +{
> +	long bits = 0;
> +	const long bit = sizeof(bits) * 8;

You can use BITS_PER_LONG here.

Thanks,
Mark.

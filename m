Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from aws.guarana.org ([13.237.110.252]:48694 "EHLO aws.guarana.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbeILL0U (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Sep 2018 07:26:20 -0400
Date: Wed, 12 Sep 2018 06:14:33 +0000
From: Kevin Easton <kevin@guarana.org>
Subject: Re: [PATCH net-next v3 01/17] asm: simd context helper API
Message-ID: <20180912061433.GA8484@ip-172-31-15-78>
References: <20180911010838.8818-1-Jason@zx2c4.com>
 <20180911010838.8818-2-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911010838.8818-2-Jason@zx2c4.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net, gregkh@linuxfoundation.org, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org
Message-ID: <20180912061433.dq6GZ3M6i0E6eX5WwhvAEtKKDKwzpoOdIRRjVf5JFO4@z>

On Mon, Sep 10, 2018 at 07:08:21PM -0600, Jason A. Donenfeld wrote:
> Sometimes it's useful to amortize calls to XSAVE/XRSTOR and the related
> FPU/SIMD functions over a number of calls, because FPU restoration is
> quite expensive. This adds a simple header for carrying out this pattern:
> 
>     simd_context_t simd_context = simd_get();
>     while ((item = get_item_from_queue()) != NULL) {
>         encrypt_item(item, simd_context);
>         simd_context = simd_relax(simd_context);
>     }
>     simd_put(simd_context);
> 
> The relaxation step ensures that we don't trample over preemption, and
> the get/put API should be a familiar paradigm in the kernel.

Given that it's always supposed to be used like that, mightn't it be
better if simd_relax() took a pointer to the context, so the call is
just

    simd_relax(&simd_context);

?

The inlining means that there won't actually be a pointer dereference in
the emitted code.

If simd_put() also took a pointer then it could set the context back to
HAVE_NO_SIMD as well?

    - Kevin

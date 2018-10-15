Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45074 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeJOTog (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Oct 2018 15:44:36 -0400
Received: by mail-lf1-f67.google.com with SMTP id v22-v6so2070376lfe.12
        for <linux-arch@vger.kernel.org>; Mon, 15 Oct 2018 04:59:36 -0700 (PDT)
Subject: Re: [RESEND PATCH v4 3/8] gpio: 104-dio-48e: Utilize
 for_each_set_clump macro
References: <cover.1538441919.git.vilhelm.gray@gmail.com>
 <5906381114b14d5b0359510a1d23accbd239eaa5.1538441919.git.vilhelm.gray@gmail.com>
 <822be05b-092b-41c2-3c31-8981acd5cb9e@rasmusvillemoes.dk>
 <20181014041933.GA7335@icarus>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <afbe5c62-f003-ca92-d185-8e6e9340c75d@rasmusvillemoes.dk>
Date: Mon, 15 Oct 2018 13:59:33 +0200
MIME-Version: 1.0
In-Reply-To: <20181014041933.GA7335@icarus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linus.walleij@linaro.org, akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
Message-ID: <20181015115933.Qb5y7YElDaelWB-kqSKNjNMujSKinaim4p-mrGInMIA@z>

On 2018-10-14 06:19, William Breathitt Gray wrote:

> a bit value of 0 in the
> bits array does not necessarily mean the input was not requested, but
> may instead mean that the value at the input is 0;

sure enough, but...

> therefore, the caller
> must keep track of the requested inputs rather than try to deduce them
> from the values in the bits array.

...I don't agree that this logically follows. A caller might reasonably
expect not to find any bits set in positions other than those in mask. A
simple example would be caller that just tried to ask "are any of
_these_ inputs set"; it would be reasonable to implement that using
bitmap_empty() on the returned bitset, without first having to mask by
the mask he passed in.

Rasmus

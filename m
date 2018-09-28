Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f174.google.com ([209.85.208.174]:46723 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbeI1NqI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Sep 2018 09:46:08 -0400
Received: by mail-lj1-f174.google.com with SMTP id 203-v6so4800151ljj.13
        for <linux-arch@vger.kernel.org>; Fri, 28 Sep 2018 00:23:44 -0700 (PDT)
Subject: Re: [PATCH v5 2/4] mm: move is_kernel_rodata() to
 asm-generic/sections.h
References: <20180928071414.30703-1-brgl@bgdev.pl>
 <20180928071414.30703-3-brgl@bgdev.pl>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <c7484684-8f92-8e7a-e4fb-015d50180414@rasmusvillemoes.dk>
Date: Fri, 28 Sep 2018 09:23:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180928071414.30703-3-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Message-ID: <20180928072339.zyEz9d8y5h7nUaq_rvmuliy5VI65cM7SVav2ztNdKHo@z>

On 2018-09-28 09:14, Bartosz Golaszewski wrote:
> Export this routine so that we can use it later in devm_kstrdup_const()
> and devm_kfree_const().

s/devm_kfree_const/devm_kfree/.

Apart from that nit, feel free to add my ack to 1,2,3.

Thanks,
Rasmus

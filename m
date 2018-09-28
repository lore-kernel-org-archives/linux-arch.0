From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v5 2/4] mm: move is_kernel_rodata() to
 asm-generic/sections.h
Date: Fri, 28 Sep 2018 09:23:39 +0200
Message-ID: <c7484684-8f92-8e7a-e4fb-015d50180414@rasmusvillemoes.dk>
References: <20180928071414.30703-1-brgl@bgdev.pl>
 <20180928071414.30703-3-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180928071414.30703-3-brgl@bgdev.pl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

On 2018-09-28 09:14, Bartosz Golaszewski wrote:
> Export this routine so that we can use it later in devm_kstrdup_const()
> and devm_kfree_const().

s/devm_kfree_const/devm_kfree/.

Apart from that nit, feel free to add my ack to 1,2,3.

Thanks,
Rasmus

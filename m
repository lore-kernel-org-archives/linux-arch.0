From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 2/2] bits: Add tests of GENMASK
Date: Sat, 20 Jun 2020 21:36:32 -0700
Message-ID: <20200620213632.60c2c6b99ec9cf9392fa128d@linux-foundation.org>
References: <20200608184222.GA899@rikard>
        <20200608221823.35799-1-rikard.falkeborn@gmail.com>
        <20200608221823.35799-2-rikard.falkeborn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgFUEgd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 21 Jun 2020 00:36:33 -0400
In-Reply-To: <20200608221823.35799-2-rikard.falkeborn@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc: andy.shevchenko@gmail.com, arnd@arndb.de, emil.l.velikov@gmail.com, geert@linux-m68k.org, keescook@chromium.org, linus.walleij@linaro.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com, syednwaris@gmail.com, vilhelm.gray@gmail.com, yamada.masahiro@socionext.com

On Tue,  9 Jun 2020 00:18:23 +0200 Rikard Falkeborn <rikard.falkeborn@gmail.com> wrote:

> Add tests of GENMASK and GENMASK_ULL.
> 
> A few test cases that should fail compilation are provided
> under #ifdef TEST_GENMASK_FAILURES

WARNING: modpost: missing MODULE_LICENSE() in lib/test_bits.o


Could you please send a fix?

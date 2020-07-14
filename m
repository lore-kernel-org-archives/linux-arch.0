From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 4/5] arm64: Use the generic devmem_is_allowed()
Date: Tue, 14 Jul 2020 19:14:15 +0100
Message-ID: <20200714181415.GC10736@gaia>
References: <20200709211925.1926557-1-palmer@dabbelt.com>
 <20200709211925.1926557-5-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbgGNSO0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Jul 2020 14:14:26 -0400
Content-Disposition: inline
In-Reply-To: <20200709211925.1926557-5-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: zong.li@sifive.com, linux-riscv@lists.infradead.org, rppt@linux.ibm.com, linux@armlinux.org.uk, will@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, gxt@pku.edu.cn, Arnd Bergmann <arnd@arndb.de>, linus.walleij@linaro.org, akpm@linux-foundation.org, mchehab+samsung@kernel.org, gregory.0xf0@gmail.com, masahiroy@kernel.org, Nick Desaulniers <ndesaulniers@google.com>, bgolaszewski@baylibre.com, steve@sk2.org, tglx@linutronix.de, keescook@chromium.org, alex@ghiti.fr, mcgrof@kernel.org, mark.rutland@arm.com, james.morse@arm.com, alex.shi@linux.alibaba.com, andriy.shevchenko@linux.intel.com, broonie@kernel.org, rdunlap@infradead.org, davem@davemloft.net, rostedt@goodmis.org, dan.j.williams@intel.com, mhiramat@kernel.org, krzk@kernel.org, zaslonko@linux

On Thu, Jul 09, 2020 at 02:19:24PM -0700, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> I recently copied this into lib/ for use by the RISC-V port.
> 
> [I haven't even build tested this.  The lib/ patch is on riscv/for-next,
> which I'm targeting for 5.9, so this won't work alone.  See the cover
> letter for more details.]
> 
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

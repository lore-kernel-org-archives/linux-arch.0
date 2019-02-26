From: Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH v2 0/3] Ensure inX() is ordered wrt delay() routines
Date: Tue, 26 Feb 2019 10:14:31 -0800 (PST)
Message-ID: <mhng-1f3ce733-8498-47d8-9425-a6eaa3dfbb4c@palmer-si-x1c4>
References: <20190222180454.5992-1-will.deacon@arm.com>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190222180454.5992-1-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, andrew.murray@arm.com, Arnd Bergmann <arnd@arndb.de>, catalin.marinas@arm.com, geert@linux-m68k.org, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

On Fri, 22 Feb 2019 10:04:51 PST (-0800), Will Deacon wrote:
> Hi all,
>
> This is version two of the patches I previously posted here:
>
>   https://lore.kernel.org/lkml/20190211174544.4302-1-will.deacon@arm.com/T/#u
>
> Changes since v2 include:
>
>   * Incorporate riscv changes from Palmer
>   * Update macro definitions as suggested by Geert
>   * Extend to cover non-port reads via __io_ar() as well
>
> Feedback welcome,
>
> Will
>
> --->8
>
> Will Deacon (3):
>   asm-generic/io: Pass result of I/O accessor to __io_[p]ar()
>   riscv: io: Update __io_[p]ar() macros to take an argument
>   arm64: io: Hook up __io_par() for inX() ordering
>
>  arch/arm64/include/asm/io.h |  1 +
>  arch/riscv/include/asm/io.h | 36 ++++++++++++++++++------------------
>  include/asm-generic/io.h    | 20 ++++++++++----------
>  3 files changed, 29 insertions(+), 28 deletions(-)

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

Thanks!

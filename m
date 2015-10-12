From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] arm: add __initbss section attribute
Date: Mon, 12 Oct 2015 12:21:16 +0200
Message-ID: <8530796.1MzFUDEUSY@wuerfel>
References: <1444622356-8263-1-git-send-email-yalin.wang2010@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1444622356-8263-1-git-send-email-yalin.wang2010@gmail.com>
Sender: owner-linux-mm@kvack.org
To: yalin wang <yalin.wang2010@gmail.com>
Cc: linux@arm.linux.org.uk, ard.biesheuvel@linaro.org, will.deacon@arm.com, nico@linaro.org, keescook@chromium.org, catalin.marinas@arm.com, victor.kamensky@linaro.org, msalter@redhat.com, vladimir.murzin@arm.com, ggdavisiv@gmail.com, paul.gortmaker@windriver.com, mingo@kernel.org, rusty@rustcorp.com.au, mcgrof@suse.com, akpm@linux-foundation.org, kirill.shutemov@linux.intel.com, n-horiguchi@ah.jp.nec.com, aarcange@redhat.com, mhocko@suse.com, jack@suse.cz, iamjoonsoo.kim@lge.com, xiexiuqi@huawei.com, vbabka@suse.cz, Vineet.Gupta1@synopsys.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

On Monday 12 October 2015 11:59:16 yalin wang wrote:
> This attribute can make init data to be into .initbss section,
> this will make the data to be NO_BITS in vmlinux, can shrink the
> Image file size, and speed up the boot up time.
> 
> Signed-off-by: yalin wang <yalin.wang2010@gmail.com>

Do you have an estimate of how much it gains?

In multi_v7_defconfig, I see a total of 3367 symbols with
406016 bytes init.data, but only 348 bytes of those are
in zero-initialized symbols.

	Arnd

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>

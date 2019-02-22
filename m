From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 19/23] arm64: Enable compat vDSO support
Date: Fri, 22 Feb 2019 14:39:58 +0000
Message-ID: <20190222143957.GN42419@lakrids.cambridge.arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-20-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190222122430.21180-20-vincenzo.frascino@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Fri, Feb 22, 2019 at 12:24:26PM +0000, Vincenzo Frascino wrote:
> Enable compat vDSO support in the arm64 defconfig.
> 
> Note that the default compiler is set to arm-linux-gnueabihf-.
> For this to take effect and for the compat vDSO to compile correctly, it
> is required that this compiler is in the PATH.

I do not have such a compiler in my path by default.

I hope that we handle that gracefully, rather than causing a build
failure.

Can't we detect the presence of the compat compiler at config time, as
happens for the native compiler?

Thanks,
Mark.

> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index c8432e24207e..3adebe5f3573 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -120,6 +120,7 @@ CONFIG_ACPI_APEI_MEMORY_FAILURE=y
>  CONFIG_ACPI_APEI_EINJ=y
>  CONFIG_VIRTUALIZATION=y
>  CONFIG_KVM=y
> +CONFIG_CROSS_COMPILE_COMPAT_VDSO="arm-linux-gnueabihf-"
>  CONFIG_ARM64_CRYPTO=y
>  CONFIG_CRYPTO_SHA1_ARM64_CE=y
>  CONFIG_CRYPTO_SHA2_ARM64_CE=y
> -- 
> 2.20.1
> 

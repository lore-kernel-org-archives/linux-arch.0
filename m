From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v2 7/8] mips: vdso: Remove unused VDSO_HAS_32BIT_FALLBACK
Date: Tue, 3 Sep 2019 14:46:45 +0000
Message-ID: <20190903143801.7upetfqe6upouzlh@pburton-laptop>
References: <20190830135902.20861-1-vincenzo.frascino@arm.com>
 <20190830135902.20861-8-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190830135902.20861-8-vincenzo.frascino@arm.com>
Content-Language: en-US
Content-ID: <AC316F9566DBF246B86E082AA7B4F9C9@namprd22.prod.outlook.com>
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
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "luto@kernel.org" <luto@kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "salyzyn@android.com" <salyzyn@android.com>, "will@kernel.org" <will@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

Hi Vincenzo,

On Fri, Aug 30, 2019 at 02:59:01PM +0100, Vincenzo Frascino wrote:
> VDSO_HAS_32BIT_FALLBACK has been removed from the core since
> the architectures that support the generic vDSO library have
> been converted to support the 32 bit fallbacks.
> 
> Remove unused VDSO_HAS_32BIT_FALLBACK from mips vdso.
> 
> Cc: Paul Burton <paul.burton@mips.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Do you want this one in mips-next too, or applied somewhere else along
with the rest of the series? If the latter:

    Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul

> ---
>  arch/mips/include/asm/vdso/gettimeofday.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/mips/include/asm/vdso/gettimeofday.h b/arch/mips/include/asm/vdso/gettimeofday.h
> index e78462e8ca2e..5ad2b086626d 100644
> --- a/arch/mips/include/asm/vdso/gettimeofday.h
> +++ b/arch/mips/include/asm/vdso/gettimeofday.h
> @@ -107,8 +107,6 @@ static __always_inline int clock_getres_fallback(
>  
>  #if _MIPS_SIM != _MIPS_SIM_ABI64
>  
> -#define VDSO_HAS_32BIT_FALLBACK	1
> -
>  static __always_inline long clock_gettime32_fallback(
>  					clockid_t _clkid,
>  					struct old_timespec32 *_ts)
> -- 
> 2.23.0
> 

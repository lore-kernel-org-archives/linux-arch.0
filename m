From: Harald Freudenberger <freude@linux.ibm.com>
Subject: Re: [PATCH 6/6] s390x: Mark archrandom.h functions __must_check
Date: Tue, 29 Oct 2019 08:26:47 +0100
Message-ID: <935cf73a-d06c-365d-131a-23dcb350ba17@linux.ibm.com>
References: <20191028210559.8289-1-rth@twiddle.net>
 <20191028210559.8289-7-rth@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191028210559.8289-7-rth@twiddle.net>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Richard Henderson <richard.henderson@linaro.org>, linux-arch@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, x86@kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On 28.10.19 22:05, Richard Henderson wrote:
> We cannot use the pointer output without validating the
> success of the random read.
>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/archrandom.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/s390/include/asm/archrandom.h b/arch/s390/include/asm/archrandom.h
> index c67b82dfa558..f3f1ee0a8c38 100644
> --- a/arch/s390/include/asm/archrandom.h
> +++ b/arch/s390/include/asm/archrandom.h
> @@ -33,17 +33,17 @@ static inline bool arch_has_random_seed(void)
>  	return false;
>  }
>
> -static inline bool arch_get_random_long(unsigned long *v)
> +static inline bool __must_check arch_get_random_long(unsigned long *v)
>  {
>  	return false;
>  }
>
> -static inline bool arch_get_random_int(unsigned int *v)
> +static inline bool __must_check arch_get_random_int(unsigned int *v)
>  {
>  	return false;
>  }
>
> -static inline bool arch_get_random_seed_long(unsigned long *v)
> +static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
>  {
>  	if (static_branch_likely(&s390_arch_random_available)) {
>  		return s390_arch_random_generate((u8 *)v, sizeof(*v));
> @@ -51,7 +51,7 @@ static inline bool arch_get_random_seed_long(unsigned long *v)
>  	return false;
>  }
>
> -static inline bool arch_get_random_seed_int(unsigned int *v)
> +static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
>  {
>  	if (static_branch_likely(&s390_arch_random_available)) {
>  		return s390_arch_random_generate((u8 *)v, sizeof(*v));
Fine with me, Thanks, reviewed, build and tested.
You may add my reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
However, will this go into the kernel tree via crypto or s390 subsystem ?

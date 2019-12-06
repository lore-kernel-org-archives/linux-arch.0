From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 1/3] cpuinfo: add sysfs based arch independent cpuinfo
 framework
Date: Fri, 6 Dec 2019 08:56:02 -0800
Message-ID: <65a20b22-8cc9-4492-25d5-4f03727086e8@infradead.org>
References: <20191206162421.15050-1-trenn@suse.de>
 <20191206162421.15050-2-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191206162421.15050-2-trenn@suse.de>
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
To: Thomas Renninger <trenn@suse.de>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Felix Schnizlein <fschnizlein@suse.de>, Felix Schnizlein <fschnizlein@suse.com>, gregkh@linuxfoundation.org, x86@kernel.org, will.deacon@arm.com, linux@armlinux.org.uk, fschnitzlein@suse.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On 12/6/19 8:24 AM, Thomas Renninger wrote:
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 48b5e103bdb0..39015570b1ca 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -882,6 +882,17 @@ config STRICT_MODULE_RWX
>  	  and non-text memory will be made non-executable. This provides
>  	  protection against certain security exploits (e.g. writing to text)
>  
> +config CPUINFO_SYSFS
> +	bool "Provides processor information in sysfs. Successor of /proc/cpuinfo"

	      Provide

> +	def_bool y
> +	depends on HAVE_CPUINFO_SYSFS
> +	help
> +	  Provides architecture specific processor information in /sys/devices/system/cpu/info> +	  Use this instead of /proc/cpuinfo

End those 2 sentences with periods (full stop), please.

> +
> +config HAVE_CPUINFO_SYSFS
> +	bool
> +
>  # select if the architecture provides an asm/dma-direct.h header
>  config ARCH_HAS_PHYS_TO_DMA
>  	bool


-- 
~Randy

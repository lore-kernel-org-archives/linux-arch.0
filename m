From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: Re: [Y2038] [PATCH 02/23] y2038: add __kernel_old_timespec and
 __kernel_old_time_t
Date: Wed, 20 Nov 2019 22:30:18 +0000
Message-ID: <a5f530323b66cd8c0055c5e642ef4eb035c53808.camel@codethink.co.uk>
References: <20191108210236.1296047-1-arnd@arndb.de>
         <20191108210824.1534248-2-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191108210824.1534248-2-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org
Cc: Deepa Dinamani <deepa.kernel@gmail.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

On Fri, 2019-11-08 at 22:07 +0100, Arnd Bergmann wrote:
> The 'struct timespec' definition can no longer be part of the uapi headers
> because it conflicts with a a now incompatible libc definition. Also,
> we really want to remove it in order to prevent new uses from creeping in.
> 
> The same namespace conflict exists with time_t, which should also be
> removed. __kernel_time_t could be used safely, but adding 'old' in the
> name makes it clearer that this should not be used for new interfaces.
> 
> Add a replacement __kernel_old_timespec structure and __kernel_old_time_t
> along the lines of __kernel_old_timeval.
[...]
> --- a/include/uapi/linux/time_types.h
> +++ b/include/uapi/linux/time_types.h
> @@ -28,6 +28,11 @@ struct __kernel_old_timeval {
>  };
>  #endif
>  
> +struct __kernel_old_timespec {
> +	__kernel_time_t	tv_sec;			/* seconds */

Should this be __kernel_old_time_t for consistency?

Ben.

> +	long		tv_nsec;		/* nanoseconds */
> +};
> +
>  struct __kernel_sock_timeval {
>  	__s64 tv_sec;
>  	__s64 tv_usec;
-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

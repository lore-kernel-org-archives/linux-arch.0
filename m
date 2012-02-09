From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 04/21] arm: Use generic posix_types.h
Date: Thu, 9 Feb 2012 00:57:50 +0000
Message-ID: <20120209005750.GC15849@n2100.arm.linux.org.uk>
References: <1328677745-20121-1-git-send-email-hpa@zytor.com> <1328677745-20121-5-git-send-email-hpa@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41744 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932132Ab2BIA6I (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Feb 2012 19:58:08 -0500
Content-Disposition: inline
In-Reply-To: <1328677745-20121-5-git-send-email-hpa@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Tue, Feb 07, 2012 at 09:08:48PM -0800, H. Peter Anvin wrote:
> From: "H. Peter Anvin" <hpa@zytor.com>
> 
> Change the arm architecture to use <asm-generic/posix_types.h>.
> 
> Signed-off-by: H. Peter Anvin <hpa@zytor.com>
> Cc: Russell King <linux@arm.linux.org.uk>

This looks sane to me, given your description in the covering email.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks.

> ---
>  arch/arm/include/asm/posix_types.h |   55 ++++++------------------------------
>  1 files changed, 9 insertions(+), 46 deletions(-)
> 
> diff --git a/arch/arm/include/asm/posix_types.h b/arch/arm/include/asm/posix_types.h
> index 2446d23..efdf990 100644
> --- a/arch/arm/include/asm/posix_types.h
> +++ b/arch/arm/include/asm/posix_types.h
> @@ -19,59 +19,22 @@
>   * assume GCC is being used.
>   */
>  
> -typedef unsigned long		__kernel_ino_t;
>  typedef unsigned short		__kernel_mode_t;
> +#define __kernel_mode_t __kernel_mode_t
> +
>  typedef unsigned short		__kernel_nlink_t;
> -typedef long			__kernel_off_t;
> -typedef int			__kernel_pid_t;
> +#define __kernel_nlink_t __kernel_nlink_t
> +
>  typedef unsigned short		__kernel_ipc_pid_t;
> +#define __kernel_ipc_pid_t __kernel_ipc_pid_t
> +
>  typedef unsigned short		__kernel_uid_t;
>  typedef unsigned short		__kernel_gid_t;
> -typedef unsigned int		__kernel_size_t;
> -typedef int			__kernel_ssize_t;
> -typedef int			__kernel_ptrdiff_t;
> -typedef long			__kernel_time_t;
> -typedef long			__kernel_suseconds_t;
> -typedef long			__kernel_clock_t;
> -typedef int			__kernel_timer_t;
> -typedef int			__kernel_clockid_t;
> -typedef int			__kernel_daddr_t;
> -typedef char *			__kernel_caddr_t;
> -typedef unsigned short		__kernel_uid16_t;
> -typedef unsigned short		__kernel_gid16_t;
> -typedef unsigned int		__kernel_uid32_t;
> -typedef unsigned int		__kernel_gid32_t;
> +#define __kernel_uid_t __kernel_uid_t
>  
> -typedef unsigned short		__kernel_old_uid_t;
> -typedef unsigned short		__kernel_old_gid_t;
>  typedef unsigned short		__kernel_old_dev_t;
> +#define __kernel_old_dev_t __kernel_old_dev_t
>  
> -#ifdef __GNUC__
> -typedef long long		__kernel_loff_t;
> -#endif
> -
> -typedef struct {
> -	int	val[2];
> -} __kernel_fsid_t;
> -
> -#if defined(__KERNEL__)
> -
> -#undef	__FD_SET
> -#define __FD_SET(fd, fdsetp) \
> -		(((fd_set *)(fdsetp))->fds_bits[(fd) >> 5] |= (1<<((fd) & 31)))
> -
> -#undef	__FD_CLR
> -#define __FD_CLR(fd, fdsetp) \
> -		(((fd_set *)(fdsetp))->fds_bits[(fd) >> 5] &= ~(1<<((fd) & 31)))
> -
> -#undef	__FD_ISSET
> -#define __FD_ISSET(fd, fdsetp) \
> -		((((fd_set *)(fdsetp))->fds_bits[(fd) >> 5] & (1<<((fd) & 31))) != 0)
> -
> -#undef	__FD_ZERO
> -#define __FD_ZERO(fdsetp) \
> -		(memset (fdsetp, 0, sizeof (*(fd_set *)(fdsetp))))
> -
> -#endif
> +#include <asm-generic/posix_types.h>
>  
>  #endif
> -- 
> 1.7.6.5
> 

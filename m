From: "Michael Kerrisk (man-pages)" <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH v2 6/6] prctl.2: Add tagged address ABI control prctls
 (arm64)
Date: Tue, 9 Jun 2020 13:04:25 +0200
Message-ID: <88ac761e-64b3-e1e3-3cdc-1f413a6d69d6@gmail.com>
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
 <1590614258-24728-7-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1590614258-24728-7-git-send-email-Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
Sender: linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Cc: mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vincenzo Frascino <vincenzo.frascino-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

Hey folks,

Do we have any review comments for this (extensive!) patch from Dave?

Cheers,

Michael


On 5/27/20 11:17 PM, Dave Martin wrote:
> ** This patch is a draft for review and should not be applied before it
>    has been discussed. **
> 
> Add documentation for the the PR_SET_TAGGED_ADDR_CTRL and
> PR_GET_TAGGED_ADDR_CTRL prctls added in Linux 5.4 for arm64.
> 
> Signed-off-by: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
> Cc: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
> Cc: Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Vincenzo Frascino <vincenzo.frascino-5wv7dgnIgG8@public.gmane.org>
> ---
> 
>  man2/prctl.2 | 156 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 156 insertions(+)
> 
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index 3ee2702..062fd51 100644
> --- a/man2/prctl.2
> +++ b/man2/prctl.2
> @@ -1504,6 +1504,143 @@ For more information, see the kernel source file
>  (or
>  .I Documentation/arm64/sve.txt
>  before Linux 5.3).
> +.\" prctl PR_SET_TAGGED_ADDR_CTRL
> +.\" commit 63f0c60379650d82250f22e4cf4137ef3dc4f43d
> +.TP
> +.BR PR_SET_TAGGED_ADDR_CTRL " (since Linux 5.4, only on arm64)"
> +Controls support for passing tagged userspace addresses to the kernel
> +(i.e., addresses where bits 56\(em63 are not all zero).
> +.IP
> +The level of support is selected by
> +.IR "(unsigned int) arg2" ,
> +which can be one of the following:
> +.RS
> +.TP
> +.B 0
> +Addresses that are passed
> +for the purpose of being dereferenced by the kernel
> +must be untagged.
> +.TP
> +.B PR_TAGGED_ADDR_ENABLE
> +Addresses that are passed
> +for the purpose of being dereferenced by the kernel
> +may be tagged, with the exceptions summarized below.
> +.RE
> +.IP
> +The remaining arguments
> +.IR arg3 ", " arg4 " and " arg5
> +must all be zero.
> +.IP
> +On success, the mode specified in
> +.I arg2
> +is set for the calling thread and the the return value is 0.
> +If the arguments are invalid,
> +the mode specified in
> +.I arg2
> +is unrecognized,
> +or if this feature is disabled or unsupported by the kernel,
> +the call fails with
> +.BR EINVAL .
> +.IP
> +In particular, if
> +.BR prctl ( PR_SET_TAGGED_ADDR_CTRL ,
> +0, 0, 0, 0)
> +fails with
> +.B EINVAL
> +then all addresses passed to the kernel must be untagged.
> +.IP
> +Irrespective of which mode is set,
> +addresses passed to certain interfaces
> +must always be untagged:
> +.RS
> +.IP \(em
> +.BR brk (2),
> +.BR mmap (2),
> +.BR shmat (2),
> +and the
> +.I new_address
> +argument of
> +.BR mremap (2).
> +.IP
> +(Prior to Linux 5.6 these accepted tagged addresses,
> +but the behaviour may not be what you expect.
> +Don't rely on it.)
> +.IP \(em
> +\(oqpolymorphic\(cq interfaces
> +that accept pointers to arbitrary types cast to a
> +.I void *
> +or other generic type, specifically
> +.BR prctl (2),
> +.BR ioctl (2),
> +and in general
> +.BR setsockopt (2)
> +(only certain specific
> +.BR setsockopt (2)
> +options allow tagged addresses).
> +.IP \(em
> +.BR shmdt (2).
> +.RE
> +.IP
> +This list of exclusions may shrink
> +when moving from one kernel version to a later kernel version.
> +While the kernel may make some guarantees
> +for backwards compatibility reasons,
> +for the purposes of new software
> +the effect of passing tagged addresses to these interfaces
> +is unspecified.
> +.IP
> +The mode set by this call is inherited across
> +.BR fork (2)
> +and
> +.BR clone (2).
> +The mode is reset by
> +.BR execve (2)
> +to 0
> +(i.e., tagged addresses not permitted in the user/kernel ABI).
> +.IP
> +.B Warning:
> +Because the compiler or run-time environment
> +may make use of address tagging,
> +a successful
> +.B PR_SET_TAGGED_ADDR_CTRL
> +may crash the calling process.
> +The conditions for using it safely are complex and system-dependent.
> +Don't use it unless you know what you are doing.
> +.IP
> +For more information, see the kernel source file
> +.IR Documentation/arm64/tagged\-address\-abi.rst .
> +.\" prctl PR_GET_TAGGED_ADDR_CTRL
> +.\" commit 63f0c60379650d82250f22e4cf4137ef3dc4f43d
> +.TP
> +.BR PR_GET_TAGGED_ADDR_CTRL " (since Linux 5.4, only on arm64)"
> +Returns the current tagged address mode
> +for the calling thread.
> +.IP
> +Arguments
> +.IR arg2 ", " arg3 ", " arg4 " and " arg5
> +must all be zero.
> +.IP
> +If the arguments are invalid
> +or this feature is disabled or unsupported by the kernel,
> +the call fails with
> +.BR EINVAL .
> +In particular, if
> +.BR prctl ( PR_GET_TAGGED_ADDR_CTRL ,
> +0, 0, 0, 0)
> +fails with
> +.BR EINVAL ,
> +then this feature is definitely unsupported or disabled,
> +and all addresses passed to the kernel must be untagged.
> +.IP
> +Otherwise, the call returns a nonnegative value
> +describing the current tagged address mode,
> +encoded in the same way as the
> +.I arg2
> +argument of
> +.BR PR_SET_TAGGED_ADDR_CTRL .
> +.IP
> +For more information, see the kernel source file
> +.IR Documentation/arm64/tagged\-address\-abi.rst .
>  .\"
>  .\" prctl PR_TASK_PERF_EVENTS_DISABLE
>  .TP
> @@ -1749,6 +1886,7 @@ On success,
>  .BR PR_GET_SPECULATION_CTRL ,
>  .BR PR_SVE_GET_VL ,
>  .BR PR_SVE_SET_VL ,
> +.BR PR_GET_TAGGED_ADDR_CTRL ,
>  .BR PR_GET_THP_DISABLE ,
>  .BR PR_GET_TIMING ,
>  .BR PR_GET_TIMERSLACK ,
> @@ -2057,6 +2195,24 @@ is
>  .B PR_SVE_GET_VL
>  and SVE is not available on this platform.
>  .TP
> +.B EINVAL
> +.I option
> +is
> +.BR PR_SET_TAGGED_ADDR_CTRL
> +and the arguments are invalid or unsupported.
> +See the description of
> +.B PR_SET_TAGGED_ADDR_CTRL
> +above for details.
> +.TP
> +.B EINVAL
> +.I option
> +is
> +.BR PR_GET_TAGGED_ADDR_CTRL
> +and the arguments are invalid or unsupported.
> +See the description of
> +.B PR_GET_TAGGED_ADDR_CTRL
> +above for details.
> +.TP
>  .B ENODEV
>  .I option
>  was
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/

From: "Michael Kerrisk (man-pages)" <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 5/6] prctl.2: Add PR_PAC_RESET_KEYS (arm64)
Date: Tue, 9 Jun 2020 13:36:42 +0200
Message-ID: <1084d017-54f3-475c-be1b-aabc801d9a71@gmail.com>
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
 <1590614258-24728-6-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1590614258-24728-6-git-send-email-Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
Sender: linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Cc: mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Amit Daniel Kachhap <amit.kachhap-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

Hello Dave,

I've applied this patch (manually, because 4/6 is not yet applied).
I have a question below.

On 5/27/20 11:17 PM, Dave Martin wrote:
> Add documentation for the PR_PAC_RESET_KEYS ioctl added in Linux
> 5.0 for arm64.
> 
> Signed-off-by: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
> Cc: Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
> Cc: Amit Daniel Kachhap <amit.kachhap-5wv7dgnIgG8@public.gmane.org>
> Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> 
> ---
> 
> Since v1:
> 
>  * Clarify explicitly that PR_PAC_RESET_KEYS is redundant when combined
>    with execve().
> 
>  * Move error condition details into the prctl description, to avoid
>    excessive duplication while keeping keeping related pieces of text
>    closer together.
> 
>  * In lieu of having a separate man page to cross reference for detailed
>    guidance, cross-reference the kernel documentation.
> 
>  * Add safety warning.  This is deliberately vague, pending ongoing
>    discussions with libc folks.
> ---
>  man2/prctl.2 | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 

[...]

> +.IP
> +.B Warning:
> +Because the compiler or run-time environment
> +may be using some or all of the keys,
> +a successful

Things got a bit garbled here. I think the next few lines should have been 
at the end.
> +.IP
> +For more information, see the kernel source file
> +.I Documentation/arm64/pointer\-authentication.rst
> +.\"commit b693d0b372afb39432e1c49ad7b3454855bc6bed
> +(or
> +.I Documentation/arm64/pointer\-authentication.txt
> +before Linux 5.3).
> +.B PR_PAC_RESET_KEYS
> +may crash the calling process.
> +The conditions for using it safely are complex and system-dependent.
> +Don't use it unless you know what you are doing.

I applied the following change after your patch; is it okay?

 .IP
 .B Warning:
 Because the compiler or run-time environment
 may be using some or all of the keys,
 a successful
+may crash the calling process.
+The conditions for using it safely are complex and system-dependent.
+Don't use it unless you know what you are doing.
 .IP
 For more information, see the kernel source file
 .I Documentation/arm64/pointer\-authentication.rst
@@ -1020,9 +1023,6 @@ For more information, see the kernel source file
 .I Documentation/arm64/pointer\-authentication.txt
 before Linux 5.3).
 .B PR_PAC_RESET_KEYS
-may crash the calling process.
-The conditions for using it safely are complex and system-dependent.
-Don't use it unless you know what you are doing.
 .\" prctl PR_SET_PDEATHSIG
 .TP
 .BR PR_SET_PDEATHSIG " (since Linux 2.1.57)"

[...]

Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/

From: Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 5/6] prctl.2: Add PR_PAC_RESET_KEYS (arm64)
Date: Tue, 9 Jun 2020 11:02:03 +0100
Message-ID: <20200609100202.GB25362@willie-the-truck>
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
 <1590614258-24728-6-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1590614258-24728-6-git-send-email-Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Sender: linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Cc: Michael Kerrisk <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Amit Daniel Kachhap <amit.kachhap-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Wed, May 27, 2020 at 10:17:37PM +0100, Dave Martin wrote:
> Add documentation for the PR_PAC_RESET_KEYS ioctl added in Linux
> 5.0 for arm64.

[...]

> +If the arguments are invalid,
> +and in particular if
> +.I arg2
> +contains set bits that are unrecognized
> +or that correspond to a key not available on this platform,
> +the call fails with error
> +.BR EINVAL .
> +.IP
> +.B Warning:
> +Because the compiler or run-time environment
> +may be using some or all of the keys,
> +a successful
> +.IP
> +For more information, see the kernel source file
> +.I Documentation/arm64/pointer\-authentication.rst
> +.\"commit b693d0b372afb39432e1c49ad7b3454855bc6bed
> +(or
> +.I Documentation/arm64/pointer\-authentication.txt
> +before Linux 5.3).
> +.B PR_PAC_RESET_KEYS
> +may crash the calling process.

I might be misreading this, but this looks like the kernel reference appears
mid-sentence. Regardless, I think we should drop the kernel doc reference,
as I mentioned on the SVE patches.

With that:

Acked-by: Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Will

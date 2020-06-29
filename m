From: "Michael Kerrisk (man-pages)" <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 0/2] prctl.2 man page updates for Linux 5.6
Date: Mon, 29 Jun 2020 13:52:24 +0200
Message-ID: <c17e330c-69f7-da7a-feae-cb8b8f5d7ea0@gmail.com>
References: <1593020162-9365-1-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1593020162-9365-1-git-send-email-Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
Sender: linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Cc: mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vincenzo Frascino <vincenzo.frascino-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

Hi Dave,

On 6/24/20 7:36 PM, Dave Martin wrote:
> A bunch of updates to the prctl(2) man page to fill in missing
> prctls (mostly) up to Linux 5.6 (along with a few other tweaks and
> fixes).
> 
> Patches from the v2 series [1] that have been applied or rejected
> already have been dropped.
> 
> All that remain here now are the SVE and tagged address ABI controls
> for arm64.
> 
> 
> 
> [1] https://lore.kernel.org/linux-man/1590614258-24728-1-git-send-email-Dave.Martin-5wv7dgnIgG8@public.gmane.org/
> 
> 
> Dave Martin (2):
>   prctl.2: Add SVE prctls (arm64)
>   prctl.2: Add tagged address ABI control prctls (arm64)
> 
>  man2/prctl.2 | 331 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 331 insertions(+)
Thanks. I've pushed these changes to master now.

Cheers,

Michael



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/

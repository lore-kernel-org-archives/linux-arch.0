From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 05/25] lmb: Prepare to include linux/lmb.h in core file
Date: Tue, 22 Jun 2010 20:45:50 +0200
Message-ID: <20100622184550.GA25947@merkur.ravnborg.org>
References: <1277227614-11581-1-git-send-email-yinghai@kernel.org> <1277227614-11581-6-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1277227614-11581-6-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jun 22, 2010 at 10:26:34AM -0700, Yinghai Lu wrote:
> Need to add protection in linux/lmb.h, to prepare to include it in
>  mm/page_alloc.c and mm/bootmem.c etc.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  include/linux/lmb.h |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/lmb.h b/include/linux/lmb.h
> index eb8a5a3..d529232 100644
> --- a/include/linux/lmb.h
> +++ b/include/linux/lmb.h
> @@ -2,6 +2,7 @@
>  #define _LINUX_LMB_H
>  #ifdef __KERNEL__
>  
> +#ifdef CONFIG_HAVE_LMB

The file could loose the "#ifdef __KERNEL__"
as lmb.h is not exported to userspace.

	Sam

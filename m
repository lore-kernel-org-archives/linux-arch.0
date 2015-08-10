From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH v2 02/11] nios2: Export strncpy_from_user / strnlen_user
 to modules
Date: Mon, 10 Aug 2015 16:10:44 +0800
Message-ID: <CAFiDJ59myj9n5wwYaMWK9aYnwhKS-mOovaCx=bJ+mHtNecC5Dw@mail.gmail.com>
References: <1438960924-23628-1-git-send-email-james.hogan@imgtec.com>
	<1438960924-23628-3-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:36341 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269AbbHJIKp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 10 Aug 2015 04:10:45 -0400
In-Reply-To: <1438960924-23628-3-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>

On Fri, Aug 7, 2015 at 11:21 PM, James Hogan <james.hogan@imgtec.com> wrote:
> Update the nios2 architecture code to export strncpy_from_user() and
> strnlen_user() to modules. The test_user_copy module will soon test
> them.
>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ley Foon Tan <lftan@altera.com>
> Cc: nios2-dev@lists.rocketboards.org
> ---
>  arch/nios2/mm/uaccess.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/nios2/mm/uaccess.c b/arch/nios2/mm/uaccess.c
> index 7663e156ff4f..ecd8b122948b 100644
> --- a/arch/nios2/mm/uaccess.c
> +++ b/arch/nios2/mm/uaccess.c
> @@ -146,6 +146,7 @@ long strncpy_from_user(char *__to, const char __user *__from, long __len)
>                 l--;
>         return l;
>  }
> +EXPORT_SYMBOL(strncpy_from_user);
>
>  long strnlen_user(const char __user *s, long n)
>  {
> @@ -161,3 +162,4 @@ long strnlen_user(const char __user *s, long n)
>         }
>         return n + 1;
>  }
> +EXPORT_SYMBOL(strnlen_user);

Acked-by: Ley Foon Tan <lftan@altera.com>

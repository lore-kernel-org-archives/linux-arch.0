Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44949 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbfHSPqY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Aug 2019 11:46:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so1432357pgl.11
        for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2019 08:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190815154403.16473-1-catalin.marinas@arm.com> <20190815154403.16473-3-catalin.marinas@arm.com>
In-Reply-To: <20190815154403.16473-3-catalin.marinas@arm.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Mon, 19 Aug 2019 17:46:12 +0200
Message-ID: <CAAeHK+w7Y=UgwTyjyVt6bBSi=DZROkMaz1B6-0BefK3AjSPpYw@mail.gmail.com>
Subject: Re: [PATCH v8 2/5] arm64: Tighten the PR_{SET,GET}_TAGGED_ADDR_CTRL
 prctl() unused arguments
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Memory Management List <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will.deacon@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Dave P Martin <Dave.Martin@arm.com>, Dave Hansen <dave.hansen@intel.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20190819154612.VVahDFHhxwCKg6yX9KM6RmJjWzJ6QIwUdPvJ1LxzOdc@z>

On Thu, Aug 15, 2019 at 5:44 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Require that arg{3,4,5} of the PR_{SET,GET}_TAGGED_ADDR_CTRL prctl and
> arg2 of the PR_GET_TAGGED_ADDR_CTRL prctl() are zero rather than ignored
> for future extensions.
>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Andrey Konovalov <andreyknvl@google.com>

> ---
>  kernel/sys.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/sys.c b/kernel/sys.c
> index c6c4d5358bd3..ec48396b4943 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2499,9 +2499,13 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>                 error = PAC_RESET_KEYS(me, arg2);
>                 break;
>         case PR_SET_TAGGED_ADDR_CTRL:
> +               if (arg3 || arg4 || arg5)
> +                       return -EINVAL;
>                 error = SET_TAGGED_ADDR_CTRL(arg2);
>                 break;
>         case PR_GET_TAGGED_ADDR_CTRL:
> +               if (arg2 || arg3 || arg4 || arg5)
> +                       return -EINVAL;
>                 error = GET_TAGGED_ADDR_CTRL();
>                 break;
>         default:

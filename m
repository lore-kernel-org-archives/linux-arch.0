Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:38270 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932400AbbCLQQn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 12 Mar 2015 12:16:43 -0400
MIME-Version: 1.0
In-Reply-To: <1426175534-29874-1-git-send-email-jslaby@suse.cz>
References: <1426175534-29874-1-git-send-email-jslaby@suse.cz>
Date: Thu, 12 Mar 2015 09:16:42 -0700
Message-ID: <CA+55aFyxTvdC6u9RPdY2Pg=ALrHkHKHLt9+tY01RqKABP9cFPw@mail.gmail.com>
Subject: Re: [patch added to the 3.12 stable tree] vm: add VM_FAULT_SIGSEGV
 handling support
From: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: stable <stable@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20150312161642.OWWx2OWGaKxbUb8O5pGW9FsHOZdA6WGoBZtssAxpGsk@z>

On Thu, Mar 12, 2015 at 8:52 AM, Jiri Slaby <jslaby@suse.cz> wrote:
>
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 5b90bbcad9f6..d9d8d91a64ff 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -873,6 +873,8 @@ mm_fault_error(struct pt_regs *regs, unsigned long error_code,
>                 if (fault & (VM_FAULT_SIGBUS|VM_FAULT_HWPOISON|
>                              VM_FAULT_HWPOISON_LARGE))
>                         do_sigbus(regs, error_code, address, fault);
> +               else if (fault & VM_FAULT_SIGSEGV)
> +                       bad_area_nosemaphore(regs, error_code, address);
>                 else
>                         BUG();
>         }

Just double-checking that you are aware that this semantically depends
on commit 7fb08eca4527 ("x86: mm: move mmap_sem unlock from
mm_fault_error() to caller"). We had that back-porting bug at least
twice, because it was so subtle.

So either you need to backport 7fb08eca4527 too before (so that we
really have dropped the semaphore at this point), or that
"bad_area_nosemaphore()" needs to be just a "bad_area()" instead,
because we still hold the semaphore.

I didn't look at the rest of the series, so this *may* be ok as-is, I
just wanted to make sure we didn't introduce this problem *again* in a
backport.

                                 Linus

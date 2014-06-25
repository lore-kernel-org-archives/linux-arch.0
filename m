Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:21683 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754459AbaFYOFs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Jun 2014 10:05:48 -0400
Date: Wed, 25 Jun 2014 16:03:12 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v8 3/9] seccomp: introduce writer locking
Message-ID: <20140625140312.GC7892@redhat.com>
References: <1403642893-23107-1-git-send-email-keescook@chromium.org> <1403642893-23107-4-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1403642893-23107-4-git-send-email-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>, Alexei Starovoitov <ast@plumgrid.com>, Andrew Morton <akpm@linux-foundation.org>, Daniel Borkmann <dborkman@redhat.com>, Will Drewry <wad@chromium.org>, Julien Tinnes <jln@chromium.org>, David Drysdale <drysdale@google.com>, linux-api@vger.kernel.org, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org
Message-ID: <20140625140312.aUpl6SrYCQWW8JlErlWcmfUeM3o0w4UBlKZiW2D3V14@z>

On 06/24, Kees Cook wrote:
>
> @@ -524,6 +529,8 @@ static long seccomp_set_mode(unsigned long seccomp_mode, char __user *filter)
>  	}
>  #endif
>
> +	spin_lock_irqsave(&current->sighand->siglock, irqflags);
> +

Well, I won't argue if you prefer to use _irqsave "just in case".

But irqs must be enabled in syscall paths, you could use spin_lock_irq().
The same for seccomp_set_mode_filter() added later.

Oleg.


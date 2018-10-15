Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.llwyncelyn.cymru ([82.70.14.225]:35432 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbeJPFKM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Oct 2018 01:10:12 -0400
Date: Mon, 15 Oct 2018 22:21:44 +0100
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] kernel/signal: Signal-based pre-coredump notification
Message-ID: <20181015222144.27fdafc3@alans-desktop>
In-Reply-To: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Enke Chen <enkechen@cisco.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <christian@brauner.io>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Martin <Dave.Martin@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@surriel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Roman Gushchin <guro@fb.com>, Marcos Paulo de Souza <marcos.souza.org@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Cyrill Gorcunov <gorcunov@openvz.org>, Yang Shi <yang.shi@linux.alibaba.com>, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Victor Kamensky (kamensky)" <kamensky@cisco.com>, xe-linux-external@cisco.com, Stefan Strogin <sstrogin@cisco.com>
Message-ID: <20181015212144.OwvYW1UUKHSZEZqSg6zdTjcWfIcKf6f3sKu1Yswcnb8@z>

> +/*
> + * Returns true if current's euid is same as p's uid or euid,
> + * or has CAP_SYS_ADMIN.
> + *
> + * Called with rcu_read_lock, creds are safe.
> + *
> + * Adapted from set_one_prio_perm().
> + */
> +static bool set_predump_signal_perm(struct task_struct *p)
> +{
> +	const struct cred *cred = current_cred(), *pcred = __task_cred(p);
> +
> +	return uid_eq(pcred->uid, cred->euid) ||
> +	       uid_eq(pcred->euid, cred->euid) ||
> +	       capable(CAP_SYS_ADMIN);
> +}

This makes absolutely no security sense whatsoever. The uid and euid of
the parent and child can both change between the test and the signal
delivery.

There are reasons that the child signal control code is incredibly
careful about either the parent or child using execve or doing a
privilege change that might pose a risk.

Until this code gets the same protections I don't believe it's safe.

Alan

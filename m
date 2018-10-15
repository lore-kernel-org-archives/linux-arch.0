From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] kernel/signal: Signal-based pre-coredump notification
Date: Mon, 15 Oct 2018 22:21:44 +0100
Message-ID: <20181015222144.27fdafc3@alans-desktop>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enke Chen <enkechen@cisco.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <christian@brauner.io>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Martin <Dave.Martin@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik
List-Id: linux-arch.vger.kernel.org

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

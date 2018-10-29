From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v4] kernel/signal: Signal-based pre-coredump notification
Date: Mon, 29 Oct 2018 12:18:05 +0100
Message-ID: <20181029111804.GA24820@redhat.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <458c04d8-d189-4a26-729a-bb1d1d751534@cisco.com>
 <7741efa7-a3f8-62a1-ba52-613883164643@cisco.com>
 <84460a77-a111-404e-4bad-88104a6e246e@cisco.com>
 <20181026082812.GA10581@redhat.com>
 <21f678a8-4001-df36-c26e-e96cf203b1b1@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <21f678a8-4001-df36-c26e-e96cf203b1b1@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enke Chen <enkechen@cisco.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <christian@brauner.io>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Martin <Dave.Martin@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@s>
List-Id: linux-arch.vger.kernel.org

Hi,

On 10/26, Enke Chen wrote:
>
> This is really a good idea given that "parent" is declared as RCU-protected.
> Just a bit odd, though, that the "parent" has not been accessed this way in
> the code base.

It is acccessed when possible,

> So just to confirm: the revised code would look like the following:
>
> static void do_notify_parent_predump(void)
> {
>         struct task_struct *parent;
>         int sig;
>
>         rcu_read_lock();
>         parent = rcu_dereference(current->parent);
>         sig = parent->signal->predump_signal;
>         if (sig != 0)
>                 do_send_sig_info(sig, SEND_SIG_NOINFO, parent, PIDTYPE_TGID);
>         rcu_read_unlock();
> }

Yes, this is what I meant.

But I still think do_notify_parent_predump() should notify ->real_parent,
not ->parent.

Oleg.

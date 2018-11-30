From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v5 1/2] kernel/signal: Signal-based pre-coredump
 notification
Date: Fri, 30 Nov 2018 13:03:45 +0100
Message-ID: <20181130120344.GA25998@redhat.com>
References: <7741efa7-a3f8-62a1-ba52-613883164643@cisco.com>
 <84460a77-a111-404e-4bad-88104a6e246e@cisco.com>
 <20181026082812.GA10581@redhat.com>
 <21f678a8-4001-df36-c26e-e96cf203b1b1@cisco.com>
 <20181029111804.GA24820@redhat.com>
 <0c197608-3b7e-ffd1-8943-801a60beb917@cisco.com>
 <80e96710-f424-9b39-72ee-9cc7cbe7a5f7@cisco.com>
 <20181128151911.GN3505@e103592.cambridge.arm.com>
 <ad461da7-f0a6-7912-3201-e440dc372f89@cisco.com>
 <20181129115520.GO3505@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181129115520.GO3505@e103592.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Martin <Dave.Martin@arm.com>
Cc: Enke Chen <enkechen@cisco.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <christian@brauner.io>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@surr>
List-Id: linux-arch.vger.kernel.org

On 11/29, Dave Martin wrote:
>
> SIGCHLD + wait() is immune to this problem for other child status
> notifications (albeit with higher overhead).
>
> Unless I've missed something fundamental, signals simply aren't a
> reliable data transport

Yes. But I hope we are not going to implement WCOREDUMP.

I am not fan of this patch, but at least it is simple.

Oleg.

From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 1/2] kernel/signal: Signal-based pre-coredump
 notification
Date: Tue, 4 Dec 2018 14:37:59 -0800
Message-ID: <20181204143759.fe24ee036a33000193339561@linux-foundation.org>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
        <458c04d8-d189-4a26-729a-bb1d1d751534@cisco.com>
        <7741efa7-a3f8-62a1-ba52-613883164643@cisco.com>
        <84460a77-a111-404e-4bad-88104a6e246e@cisco.com>
        <20181026082812.GA10581@redhat.com>
        <21f678a8-4001-df36-c26e-e96cf203b1b1@cisco.com>
        <20181029111804.GA24820@redhat.com>
        <0c197608-3b7e-ffd1-8943-801a60beb917@cisco.com>
        <80e96710-f424-9b39-72ee-9cc7cbe7a5f7@cisco.com>
        <20181128151911.GN3505@e103592.cambridge.arm.com>
        <ad461da7-f0a6-7912-3201-e440dc372f89@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ad461da7-f0a6-7912-3201-e440dc372f89@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enke Chen <enkechen@cisco.com>
Cc: Dave Martin <Dave.Martin@arm.com>, Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@surriel.com>
List-Id: linux-arch.vger.kernel.org

On Wed, 28 Nov 2018 16:15:35 -0800 Enke Chen <enkechen@cisco.com> wrote:

> Thanks for your comments. You have indeed missed some of the prior reviews
> and discussions. But that is OK.

This is why it is best to update the changelog in response to the
review discussion - if person A was wondering about something then it
is likely that person B will wonder about the same thing.  Take a
reviewer's questioning as an indication that the changelog was lacking.

I'm not sure what to make of this patchset, really.  Oleg sounds
unhappy and that's always a bad sign.  And signals are rather ugly
things.  Oleg, can you please expand on your concerns?

The arguments against using connector aren't very compelling.  Sure,
connector is hard to use from shell scripts but so are signals?  And is
there much of a usecase for managing these things with shell scripts
anyway?

Has an eventfd implementation been considered?

I'm sure we've added other kernel->userspace comminication schemes, but
I can't immediately recall them all :(

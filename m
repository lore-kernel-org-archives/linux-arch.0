From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5] kernel/signal: Signal-based pre-coredump
 notification
Date: Wed, 21 Nov 2018 16:37:11 -0800
Message-ID: <20181121163711.2c00316784d221eb1750edb0@linux-foundation.org>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
        <458c04d8-d189-4a26-729a-bb1d1d751534@cisco.com>
        <7741efa7-a3f8-62a1-ba52-613883164643@cisco.com>
        <84460a77-a111-404e-4bad-88104a6e246e@cisco.com>
        <20181026082812.GA10581@redhat.com>
        <21f678a8-4001-df36-c26e-e96cf203b1b1@cisco.com>
        <20181029111804.GA24820@redhat.com>
        <0c197608-3b7e-ffd1-8943-801a60beb917@cisco.com>
        <20181030164628.GD7643@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181030164628.GD7643@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Enke Chen <enkechen@cisco.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Martin <Dave.Martin@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@surriel.com>
List-Id: linux-arch.vger.kernel.org

On Tue, 30 Oct 2018 17:46:29 +0100 Oleg Nesterov <oleg@redhat.com> wrote:

> On 10/29, Enke Chen wrote:
> >
> > Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> 
> Hmm. I didn't say this ;)
> 
> But OK, feel free to keep this tag.
> 
> I do not like this feauture.

Why is that?

> But I see no technical problems in this version
> and I never pretented I understand the user-space needs, so I won't argue.

The changelog appears to spell this all out quite well?  Unusually
well, in my experience ;)

A couple of things...

- We'll be looking for a manpage update please.  (Search MAINTAINERS
  for "manpage")

- As it's a linux-specific feature, a test under
  tools/testing/selftests would be appropriate.  I don't know how much
  that work will be.  Do we have other linux-specific signal extensions
  which could piggyback onto that?

From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5] kernel/signal: Signal-based pre-coredump
 notification
Date: Wed, 21 Nov 2018 17:33:41 -0800
Message-ID: <20181121173341.707a0a869bf16b85f09d75b5@linux-foundation.org>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
        <458c04d8-d189-4a26-729a-bb1d1d751534@cisco.com>
        <7741efa7-a3f8-62a1-ba52-613883164643@cisco.com>
        <84460a77-a111-404e-4bad-88104a6e246e@cisco.com>
        <20181026082812.GA10581@redhat.com>
        <21f678a8-4001-df36-c26e-e96cf203b1b1@cisco.com>
        <20181029111804.GA24820@redhat.com>
        <0c197608-3b7e-ffd1-8943-801a60beb917@cisco.com>
        <20181030164628.GD7643@redhat.com>
        <20181121163711.2c00316784d221eb1750edb0@linux-foundation.org>
        <ae3b48ef-6bb0-2bc2-eca6-651fdb2dce37@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ae3b48ef-6bb0-2bc2-eca6-651fdb2dce37@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enke Chen <enkechen@cisco.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Martin <Dave.Martin@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@surriel.com>
List-Id: linux-arch.vger.kernel.org

On Wed, 21 Nov 2018 17:09:50 -0800 Enke Chen <enkechen@cisco.com> wrote:

> Hi, Andrew:
> 
> On 11/21/18 4:37 PM, Andrew Morton wrote:
> > On Tue, 30 Oct 2018 17:46:29 +0100 Oleg Nesterov <oleg@redhat.com> wrote:
> > 
> >> On 10/29, Enke Chen wrote:
> >>>
> >>> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> >>
> >> Hmm. I didn't say this ;)
> >>
> >> But OK, feel free to keep this tag.
> >>
> >> I do not like this feauture.
> > 
> > Why is that?
> > 
> >> But I see no technical problems in this version
> >> and I never pretented I understand the user-space needs, so I won't argue.
> > 
> > The changelog appears to spell this all out quite well?  Unusually
> > well, in my experience ;)
> 
> I also followed up with a little more explanation in the email thread on
> 10/30/2018:
> 
> ---
> As I explained earlier, the primary application is in the area of network
> high-availability / non-stop-forwarding where early fault notification and
> early action can help maintain BFD sessions and thus avoid unnecessary
> disruption to forwarding while the control-plane is recovering.
> ---
> 
> BTW, I probably should have pointed out this earlier:
> 
> BFD stands for "RFC 5880: Bi-directional forwarding detection".

I saw that.  My point is that your above followup wasn't necessary -
the changelog is clear!

> > 
> > - As it's a linux-specific feature, a test under
> >   tools/testing/selftests would be appropriate.  I don't know how much
> >   that work will be. 
> 
> The selftest code was submitted on 10/25/2018:
> 
>    [PATCH] selftests/prctl: selftest for pre-coredump signal notification

OK, please prepare these as a patch series.

> > Do we have other linux-specific signal extensions which could piggyback onto that?
> 
> No. There are enough existing signals that an application can choose for this
> purpose, such as SIGUSR1, SIGUSR1, and any of the RT signals.
> 

My point is that if we have previously added any linux-specific signal
expensions then your selftest patch would be an appropriate place where
we could add tests for those features.  I'm not saying that you should
add such tests at this time, but please do prepare the selftest as a
thing which tests linux-specific signal extensions in general, not as a
thing which tests pre-coredump signals only.

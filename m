From: Jann Horn <jannh@google.com>
Subject: Re: [PATCH v5 1/2] kernel/signal: Signal-based pre-coredump notification
Date: Tue, 4 Dec 2018 22:47:57 -0800
Message-ID: <CAG48ez1CMTMAZKQ_Vqjju8RaoNtUu_1rttw9PxHJFypCTEkYGA@mail.gmail.com>
References: <458c04d8-d189-4a26-729a-bb1d1d751534@cisco.com>
 <7741efa7-a3f8-62a1-ba52-613883164643@cisco.com> <84460a77-a111-404e-4bad-88104a6e246e@cisco.com>
 <20181026082812.GA10581@redhat.com> <21f678a8-4001-df36-c26e-e96cf203b1b1@cisco.com>
 <20181029111804.GA24820@redhat.com> <0c197608-3b7e-ffd1-8943-801a60beb917@cisco.com>
 <80e96710-f424-9b39-72ee-9cc7cbe7a5f7@cisco.com> <20181128151911.GN3505@e103592.cambridge.arm.com>
 <ad461da7-f0a6-7912-3201-e440dc372f89@cisco.com> <20181129115520.GO3505@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181129115520.GO3505@e103592.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave.Martin@arm.com
Cc: enkechen@cisco.com, Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, deller@gmx.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, christian@brauner.io, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, mchehab+samsung@kernel.org, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@surriel.com>, "Kirill A . Shutemov" <kirill.shutemov@linu>
List-Id: linux-arch.vger.kernel.org

On Thu, Nov 29, 2018 at 3:55 AM Dave Martin <Dave.Martin@arm.com> wrote:
> On Thu, Nov 29, 2018 at 12:15:35AM +0000, Enke Chen wrote:
> > Hi, Dave:
> >
> > Thanks for your comments. You have indeed missed some of the prior reviews
> > and discussions. But that is OK.
> >
> > Please see my replies inline.
> >
> > On 11/28/18 7:19 AM, Dave Martin wrote:
> > > On Tue, Nov 27, 2018 at 10:54:41PM +0000, Enke Chen wrote:
> > >> diff --git a/kernel/sys.c b/kernel/sys.c
> > >> index 123bd73..39aa3b8 100644
> > >> --- a/kernel/sys.c
> > >> +++ b/kernel/sys.c
> > >> @@ -2476,6 +2476,19 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
> > >>                    return -EINVAL;
> > >>            error = arch_prctl_spec_ctrl_set(me, arg2, arg3);
> > >>            break;
> > >> +  case PR_SET_PREDUMP_SIG:
> > >> +          if (arg3 || arg4 || arg5)
> > >
> > > glibc has
> > >
> > >     int prctl(int option, ...);
> > >
> > > Some prctls() police extra arguments for zeros, but this means that
> > > the userspace caller also has to supply pointless 0 arguments.
> > >
> > > It's debatable which is the preferred approach.  Did you have any
> > > particular rationale for your choice here?
> > >
> >
> > The initial version did not check the values of these unused arguments.
> > But Jann Horn pointed out the new convention is to enforce the 0 values
> > so I followed ...
>
> Hmmm, I wasn't aware of this convention when I added PR_SVE_SET_VL etc.,
> and there is no clear pattern in sys.c, and nobody commented at the
> time.
>
> Of course, it works either way.

Looking at the last couple prctls that have been added:

PR_GET_SPECULATION_CTRL/PR_GET_SPECULATION_CTRL: checks unused args
(commit b617cfc858161140d69cc0b5cc211996b557a1c7, by tglx)
PR_SVE_GET_VL/PR_SVE_SET_VL: doesn't check unused args (commit
2d2123bc7c7f843aa9db87720de159a049839862, by Dave Martin)
PR_CAP_AMBIENT: checks unused args (by Andy Lutomirski)
PR_SET_FP_MODE/PR_GET_FP_MODE: doesn't check unused args
PR_MPX_ENABLE_MANAGEMENT/PR_MPX_DISABLE_MANAGEMENT: checks unused
args; this one actually specifically added such checks in commit
e9d1b4f3c60997fe197bf0243cb4a41a44387a88 ("x86, mpx: Strictly enforce
empty prctl() args") and specifically says "should be done for all new
prctl()s":

    Description from Michael Kerrisk.  He suggested an identical patch
    to one I had already coded up and tested.

    commit fe3d197f8431 "x86, mpx: On-demand kernel allocation of bounds
    tables" added two new prctl() operations, PR_MPX_ENABLE_MANAGEMENT and
    PR_MPX_DISABLE_MANAGEMENT.  However, no checks were included to ensure
    that unused arguments are zero, as is done in many existing prctl()s
    and as should be done for all new prctl()s. This patch adds the
    required checks.

    Suggested-by: Andy Lutomirski <luto@amacapital.net>
    Suggested-by: Michael Kerrisk <mtk.manpages@gmail.com>
    Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
    Cc: Dave Hansen <dave@sr71.net>
    Link: http://lkml.kernel.org/r/20150108223022.7F56FD13@viggo.jf.intel.com
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

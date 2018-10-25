From: Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2] kernel/signal: Signal-based pre-coredump notification
Date: Thu, 25 Oct 2018 15:45:29 +0200
Message-ID: <CAG48ez2aJD1wcz3UjhaQvgqhg5UMeQ_-iMZesA=SfhYwUdGGyA@mail.gmail.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <458c04d8-d189-4a26-729a-bb1d1d751534@cisco.com> <87sh0vpj5q.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87sh0vpj5q.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: enkechen@cisco.com, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, deller@gmx.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, christian@brauner.io, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave.Martin@arm.com, mchehab+samsung@kernel.org, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@surriel.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, guro@fb.com, Marcos Souza <marcos.souza.org@gmail.c>
List-Id: linux-arch.vger.kernel.org

On Wed, Oct 24, 2018 at 3:30 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> Enke Chen <enkechen@cisco.com> writes:
> > For simplicity and consistency, this patch provides an implementation
> > for signal-based fault notification prior to the coredump of a child
> > process. A new prctl command, PR_SET_PREDUMP_SIG, is defined that can
> > be used by an application to express its interest and to specify the
> > signal (SIGCHLD or SIGUSR1 or SIGUSR2) for such a notification. A new
> > signal code (si_code), CLD_PREDUMP, is also defined for SIGCHLD.
> >
> > Changes to prctl(2):
> >
> >    PR_SET_PREDUMP_SIG (since Linux 4.20.x)
> >           Set the child pre-coredump signal of the calling process to
> >           arg2 (either SIGUSR1, or SIUSR2, or SIGCHLD, or 0 to clear).
> >           This is the signal that the calling process will get prior to
> >           the coredump of a child process. This value is cleared across
> >           execve(2), or for the child of a fork(2).
> >
> >           When SIGCHLD is specified, the signal code will be set to
> >           CLD_PREDUMP in such an SIGCHLD signal.
[...]
> Ugh.  Your test case is even using signalfd.  So you don't even want
> this signal to be delivered as a signal.

Just to make sure everyone's on the same page: You're suggesting that
it might make sense to deliver the pre-dump notification via a new
type of file instead (along the lines of signalfd, timerfd, eventfd
and so on)?

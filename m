From: Richard Guy Briggs <rgb@redhat.com>
Subject: Re: [ARCH question] Do syscall_get_nr and syscall_get_arguments
	always work?
Date: Fri, 21 Feb 2014 16:21:44 -0500
Message-ID: <20140221212144.GF17952@madcap2.tricolour.ca>
References: <CALCETrU6M=Abo1z2cRoZy07-=3bwKiK84gCSMcBPLA1TkXPb8A@mail.gmail.com>
	<CACM3HyHwrKQAWZRhE2N1VtGKu1xSvcGeuMG1Ag+vzP2BA111cQ@mail.gmail.com>
	<CALCETrXXnSdyc5VpT8f6uu6kbO1cq4QwdKqr9z8AOhY_wsoBLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-audit-bounces@redhat.com>
Content-Disposition: inline
In-Reply-To: <CALCETrXXnSdyc5VpT8f6uu6kbO1cq4QwdKqr9z8AOhY_wsoBLA@mail.gmail.com>
List-Unsubscribe: <https://www.redhat.com/mailman/options/linux-audit>,
	<mailto:linux-audit-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/linux-audit>
List-Post: <mailto:linux-audit@redhat.com>
List-Help: <mailto:linux-audit-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/linux-audit>,
	<mailto:linux-audit-request@redhat.com?subject=subscribe>
Sender: linux-audit-bounces@redhat.com
Errors-To: linux-audit-bounces@redhat.com
To: Andy Lutomirski <luto@amacapital.net>
Cc: linux-arch <linux-arch@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, linux-audit@redhat.com, Jonas Bonn <jonas.bonn@gmail.com>
List-Id: linux-arch.vger.kernel.org

On 14/02/07, Andy Lutomirski wrote:
> On Fri, Feb 7, 2014 at 4:58 AM, Jonas Bonn <jonas.bonn@gmail.com> wrote:
> > Hi Andy,
> >
> > On 5 February 2014 00:50, Andy Lutomirski <luto@amacapital.net> wrote:
> >>
> >> I can't even find the system call entry point on mips.
> >>
> >>
> >> Is there a semi-official answer here?
> >
> > I don't have an official answer for you, but when I wanted to do
> > something with these entry points a couple of years back I discovered
> > that they aren't very thoroughly implemented across the various
> > architectures.  I started cleaning this up and can probably dig up
> > some of this for you if you need it.
> 
> The syscall_get_xyz functions are certainly implemented and functional
> in all relevant architectures -- the audit code is already using them.
>  The thing I'm uncertain about is whether they are usable with no
> syscall slow path bits set.

I just stumbled on syscall_get_arch missing on at least s390x.  Others
may have it missing too, but the build quit on discovering that one.

> I guess that, if the syscall restart logic needs to read the argument
> registers, then they're probably reliably saved...
> 
> --Andy

- RGB

--
Richard Guy Briggs <rbriggs@redhat.com>
Senior Software Engineer, Kernel Security, AMER ENG Base Operating Systems, Red Hat
Remote, Ottawa, Canada
Voice: +1.647.777.2635, Internal: (81) 32635, Alt: +1.613.693.0684x3545

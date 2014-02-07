From: Jonas Bonn <jonas.bonn@gmail.com>
Subject: Re: [ARCH question] Do syscall_get_nr and syscall_get_arguments
 always work?
Date: Fri, 7 Feb 2014 13:58:56 +0100
Message-ID: <CACM3HyHwrKQAWZRhE2N1VtGKu1xSvcGeuMG1Ag+vzP2BA111cQ@mail.gmail.com>
References: <CALCETrU6M=Abo1z2cRoZy07-=3bwKiK84gCSMcBPLA1TkXPb8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALCETrU6M=Abo1z2cRoZy07-=3bwKiK84gCSMcBPLA1TkXPb8A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-arch <linux-arch@vger.kernel.org>, linux-audit@redhat.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, Steve Grubb <sgrubb@redhat.com>, Eric Paris <eparis@redhat.com>
List-Id: linux-arch.vger.kernel.org

Hi Andy,

On 5 February 2014 00:50, Andy Lutomirski <luto@amacapital.net> wrote:
>
> I can't even find the system call entry point on mips.
>
>
> Is there a semi-official answer here?

I don't have an official answer for you, but when I wanted to do
something with these entry points a couple of years back I discovered
that they aren't very thoroughly implemented across the various
architectures.  I started cleaning this up and can probably dig up
some of this for you if you need it.

See:
https://lkml.org/lkml/2011/10/23/87

Then again, this may be in better shape  today, already... I didn't check.

/Jonas

>
>
> --Andy
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jonas Bonn
Stockholm, Sweden

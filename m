From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/2] Fatal signal handing within uaccess faults
Date: Tue, 11 Jul 2017 16:10:53 +0100
Message-ID: <20170711151053.GG2681@leverpostej>
References: <1499782590-31366-1-git-send-email-mark.rutland@arm.com>
 <CALCETrX_T5=9Y77Z7VrM+YcpoFiJkhUGFNTOh2KbuG+7cey-bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrX_T5=9Y77Z7VrM+YcpoFiJkhUGFNTOh2KbuG+7cey-bw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: linux-arm-kerne@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, James Morse <james.morse@arm.com>, Laura Abbott <labbott@redhat.com>, Russell King <linux@armlinux.org.uk>, stable <stable@vger.kernel.org>, steve.capper@arm.com, Will Deacon <will.deacon@arm.com>, Al Viro <viro@zeniv.linux.org.uk>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 11, 2017 at 08:04:50AM -0700, Andy Lutomirski wrote:
> On Tue, Jul 11, 2017 at 7:16 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > Hi,
> >
> > Arch maintainer tl;dr: most arch fault code doesn't handle fatal signals
> > correctly, allowing unprivileged users to create an unkillable task which can
> > lock up the system. Please check whether your arch is affected.
> 
> I haven't tested for real, but brief inspection of the code suggests
> that x86 is okay.

AFAICT, yes.

As mentioned later on in the message, I beleive it's been ok since
commit:

  26178ec11ef3c6c8 ("x86: mm: consolidate VM_FAULT_RETRY handling")

... and my test-case didn't trigger anything in local testing on my
desktop.

Mark.

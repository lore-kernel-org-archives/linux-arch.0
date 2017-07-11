From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 0/2] Fatal signal handing within uaccess faults
Date: Tue, 11 Jul 2017 08:04:50 -0700
Message-ID: <CALCETrX_T5=9Y77Z7VrM+YcpoFiJkhUGFNTOh2KbuG+7cey-bw@mail.gmail.com>
References: <1499782590-31366-1-git-send-email-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1499782590-31366-1-git-send-email-mark.rutland@arm.com>
Sender: stable-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kerne@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, James Morse <james.morse@arm.com>, Laura Abbott <labbott@redhat.com>, Russell King <linux@armlinux.org.uk>, stable <stable@vger.kernel.org>, steve.capper@arm.com, Will Deacon <will.deacon@arm.com>, Al Viro <viro@zeniv.linux.org.uk>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 11, 2017 at 7:16 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> Arch maintainer tl;dr: most arch fault code doesn't handle fatal signals
> correctly, allowing unprivileged users to create an unkillable task which can
> lock up the system. Please check whether your arch is affected.

I haven't tested for real, but brief inspection of the code suggests
that x86 is okay.

--Andy

From: =?UTF-8?B?0JDQu9C10LrRgdC10Lkg0JHRgNC+0LTQutC40L0=?=
        <alexey.brodkin@gmail.com>
Subject: Re: [PATCH v2] devres: Really align data field to unsigned long long
Date: Sun, 8 Jul 2018 21:45:31 +0300
Message-ID: <CAML3pwV8YMa0269fLH-+SNhOYCWdymqTE-XYMuRJktH-=UXH8g@mail.gmail.com>
References: <20180708175621.6951-1-abrodkin@synopsys.com> <20180708184049.GA1645@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180708184049.GA1645@kroah.com>
Sender: stable-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, Alexey Brodkin <abrodkin@synopsys.com>, Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi Greg,

=D0=B2=D1=81, 8 =D0=B8=D1=8E=D0=BB. 2018 =D0=B3. =D0=B2 21:40, Greg KH <gre=
g@kroah.com>:
>
> On Sun, Jul 08, 2018 at 08:56:21PM +0300, Alexey Brodkin wrote:
> > Depending on ABI "long long" type of a particular 32-bit CPU
> > might be aligned by either word (32-bits) or double word (64-bits).
> > Make sure "data" is really 64-bit aligned for any 32-bit CPU.
> >
> > At least for 32-bit ARC cores ABI requires "long long" types
> > to be aligned by normal 32-bit word. This makes "data" field aligned to
> > 12 bytes. Which is still OK as long as we use 32-bit data only.
> >
> > But once we want to use native atomic64_t type (i.e. when we use specia=
l
> > instructions LLOCKD/SCONDD for accessing 64-bit data) we easily hit
> > misaligned access exception.
> >
> > That's because even on CPUs capable of non-aligned data access LL/SC
> > instructions require strict alignment.
> >
> > Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: stable@vger.kernel.org
> > ---
> >
> > Changes v1 -> v2:
> >
> >  * Reworded commit message
> >  * Inserted comment right in source [Thomas]
> >
> >  drivers/base/devres.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
>
> Always use scripts/get_maintainer.pl to properly cc: the needed
> developer/maintainer.  As it is, this patch is going to get dropped on
> the floor, sorry...

Right I was way too relaxed dealing with very generic stuff which might get
not that much of attention as more narrow topics or subsystems. But anyways
get_maintainer.pl says you're the guy so do I need to do anything extra sti=
ll or
it's OK for this time?

-Alexey

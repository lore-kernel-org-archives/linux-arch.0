From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] The patch solves =?utf-8?Q?the?=
 =?utf-8?Q?_type_error__of_the_parameter_=E2=80=9Coff?= =?utf-8?B?4oCd?= in
 syscall mmap on the ARM64 platform.
Date: Wed, 24 Apr 2019 14:50:15 +0100
Message-ID: <20190424135015.GE14829@fuggles.cambridge.arm.com>
References: <20190423170445.GB21047@fuggles.cambridge.arm.com>
 <1555504525-17962-1-git-send-email-zhouby_cn@126.com>
 <20190418112818.GA31923@lakrids.cambridge.arm.com>
 <28023.1556094688@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <28023.1556094688@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Boyang Zhou <zhouby_cn@126.com>, catalin.marinas@arm.com, haozhu@nudt.edu.cn, linux@dominikbrodowski.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, viro@zeniv.linux.org.uk, akpm@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

On Wed, Apr 24, 2019 at 09:31:28AM +0100, David Howells wrote:
> Will Deacon <will.deacon@arm.com> wrote:
> 
> > -		unsigned long, fd, off_t, off)
> > +		unsigned long, fd, off_t, pgoff)
> >  {
> > +	unsigned long off = pgoff;
> > +
> 
> Would loff_t be better?

I don't think so, isn't that still signed? I also think it's the same
size as off_t on arm64 (long long vs long).

Will

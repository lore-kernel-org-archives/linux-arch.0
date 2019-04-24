Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44006 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbfDXNuU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Apr 2019 09:50:20 -0400
Date: Wed, 24 Apr 2019 14:50:15 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] The patch solves =?utf-8?Q?the?=
 =?utf-8?Q?_type_error__of_the_parameter_=E2=80=9Coff?= =?utf-8?B?4oCd?= in
 syscall mmap on the ARM64 platform.
Message-ID: <20190424135015.GE14829@fuggles.cambridge.arm.com>
References: <20190423170445.GB21047@fuggles.cambridge.arm.com>
 <1555504525-17962-1-git-send-email-zhouby_cn@126.com>
 <20190418112818.GA31923@lakrids.cambridge.arm.com>
 <28023.1556094688@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28023.1556094688@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Boyang Zhou <zhouby_cn@126.com>, catalin.marinas@arm.com, haozhu@nudt.edu.cn, linux@dominikbrodowski.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, viro@zeniv.linux.org.uk, akpm@linux-foundation.org
Message-ID: <20190424135015.i37pyxMbk1XA1wR_0iz9TFZVj8lQBSvcQM6mSvx29Y4@z>

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

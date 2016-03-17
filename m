From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mtd: only use __xipram annotation when XIP_KERNEL is set
Date: Thu, 17 Mar 2016 16:56:33 +0100
Message-ID: <4420020.GISMAEPJsq@wuerfel>
References: <1453736525-1959191-2-git-send-email-arnd@arndb.de> <1457137718.43867.266.camel@infradead.org> <20160305004336.GG55664@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160305004336.GG55664@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Friday 04 March 2016 16:43:36 Brian Norris wrote:
> On Sat, Mar 05, 2016 at 12:28:38AM +0000, David Woodhouse wrote:
> > On Fri, 2016-03-04 at 16:22 -0800, Brian Norris wrote:
> > > 
> > > ...but, does anyone care about XIP / MTD_XIP then, if the first two
> > > examples we have both have long-standing build issues?
> > 
> > I think there are people trying to make it work on other platforms,
> > yes.
> 
> OK... can we kill the broken platforms though? I'm not confident that my
> and Arnd's workaround attempts will yield anything more than a pat on
> our own backs to say "yay, it compiles!" And given the number of
> practically unused things we're already maintaining in MTD, I'm always
> happy for an excuse to kill off some of it.

Sorry for the late reply.

As the three platforms that use this have all been broken for around
ten years, it seems reasonable to assume nobody is going to miss the
current implementation, but I'd leave it up to the individual platform
maintainers.

If we remove all three, that would also give us more flexibility
regarding the interface definition for any future users of the feature.
I think the most likely to use it is the Renesas RZ/A1H platform
with its 10MB of on-chip SRAM, and this one doesn't work with the
current method anyway.

	Arnd

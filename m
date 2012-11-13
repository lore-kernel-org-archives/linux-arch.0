Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:54799 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab2KMVww (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 13 Nov 2012 16:52:52 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V2 2/11] time: convert arch_gettimeoffset to a pointer
Date: Tue, 13 Nov 2012 21:52:36 +0000
References: <1352753462-2915-1-git-send-email-swarren@wwwdotorg.org> <50A16BD3.5010707@us.ibm.com> <50A27FF8.3080905@wwwdotorg.org>
In-Reply-To: <50A27FF8.3080905@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <201211132152.36668.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: John Stultz <johnstul@us.ibm.com>, Russell King <linux@arm.linux.org.uk>, Olof Johansson <olof@lixom.net>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, Mike Frysinger <vapier@gentoo.org>, Mikael Starvik <starvik@axis.com>, Hirokazu Takata <takata@linux-m32r.org>
Message-ID: <20121113215236.vX9nZTNI8p5wi3VVBhd7E44vQeKu1UgyPf06fqmUXW4@z>

On Tuesday 13 November 2012, Stephen Warren wrote:
> > One last thing to watch out for: If you're trying to build a kernel that
> > mixes clocksource support with get_arch_timeoffset, you'll need to
> > rework the #ifdef in update_wall_time(), since we currently assume with
> > get_arch_timeoffset() that you're using tick + interpolation, so every
> > call to update_wall_time() only moves time forward by one jiffy.
> 
> OK. I don't have any immediate plans to do that, although I wouldn't be
> surprised if we (the ARM community in general) end up wanting to do that
> at some point. It all depends on which ARM sub-architectures end up
> getting converted to the multi-platform zImage support I guess.

IIRC the plan is to get rid of ARCH_USES_GETTIMEOFFSET in the long run,
at least on ARM. Certainly for the platforms that are part of
the multiplatform support. The only platforms remaining that currently
use it are:

* gemini
* ebsa110
* ep93xx
* h720x
* rpc
* s3c24xx
* s3c64xx
* s5pc100
* shark

Most of these are actually ARMv4 based and not maintained very actively.
I'm pretty sure we can take care of ep93xx and the samsung platforms,
which are the more active of the above.

	Arnd

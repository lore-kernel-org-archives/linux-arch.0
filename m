Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35496 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbbKZLJA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 Nov 2015 06:09:00 -0500
Date: Thu, 26 Nov 2015 12:08:55 +0100
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 2/2] restrict /dev/mem to idle io memory ranges
Message-ID: <20151126110855.GA32226@gmail.com>
References: <20151124000553.26360.57819.stgit@dwillia2-desk3.jf.intel.com>
 <20151124000604.26360.56945.stgit@dwillia2-desk3.jf.intel.com>
 <20151124142521.e6d23e44a8b2c24c044c2dec@linux-foundation.org>
 <CAPcyv4ijWns879DytqUa+=r5hzQ1qzmB83VV6Z16kQNtmHUtbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4ijWns879DytqUa+=r5hzQ1qzmB83VV6Z16kQNtmHUtbA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Message-ID: <20151126110855.z9nt5AqUDOi-6QG6H-R12UbXnkP1cI3Mq5Q1KWuphxg@z>


* Dan Williams <dan.j.williams@intel.com> wrote:

> > - why is the patch mucking with access to PCI and BIOS space?  Is the
> >   persistent memory even mappable in those regions?  Or is the concern
> >   that userspace can access control registers associated with the
> >   persistent memory?  What is the problem scenario?
> 
> It seems to me that letting /dev/mem do arbitrary access to any region
> of memory is a dangerous capability for a production environment.

So basically the original motivation years ago was to disable /dev/mem altogether: 
it used to be a wide open roothole if anything with write access to it (such as 
old Xorg) is exploited, plus it's a favorite and convenient tool for stealth 
access to system areas of memory in cases where the attacker already has root. 

(this is relevant as even being root might not give easy access to system mmio 
areas if things like being able to load modules is restricted even for room, and 
if the system has readonly storage and a few other things configured.)

But we couldn't disable /dev/mem completely due to Xorg and dosemu legacies - so 
we came up with this restriction feature that limits its scope.

Any additional steps that limit the scope of access under the STRICT_DEVMEM option 
(which is really a misnomer: it should be RESTRICT_DEVMEM instead) are welcome 
from a generic Linux distro POV.

Thanks,

	Ingo

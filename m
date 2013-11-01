From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 00/11] RFC: Common machine reset handling
Date: Fri, 1 Nov 2013 16:12:47 +0000
Message-ID: <20131101161246.GM16735@n2100.arm.linux.org.uk>
References: <20131031062708.520968323@linux.com> <5272D05E.1070207@wwwdotorg.org> <20131101051610.GA28233@glitch> <5273CFB9.1080603@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42259 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777Ab3KAQNK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Nov 2013 12:13:10 -0400
Content-Disposition: inline
In-Reply-To: <5273CFB9.1080603@wwwdotorg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Domenico Andreoli <domenico.andreoli@linux.com>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org

On Fri, Nov 01, 2013 at 09:58:49AM -0600, Stephen Warren wrote:
> For PMICs that provide power off, we've been adding a property to DT to
> indicate whether the PMIC is *the* system power off controller or not.
> If the property is present, the PMIC registers itself in the poweroff
> hook. If not, it doesn't. So, there really isn't an algorithm for
> selecting the power off mechanism, but rather we designate one mechanism
> ahead of time, and that's the only one that's relevant. We could
> probably do the same for reset mechanisms.
> 
> I guess the vexpress situation is actually the same; there's a single
> concept of a custom vexpress reset, it's just that sysfs is used to
> select exactly what that does?

I'm not aware of that.  Vexpress has the following mechanisms:

- reset - this causes the system to be restarted without powering off.
- restart - this causes the system to be powered off and back on.
- poweroff - this causes the system to power off.

Obviously, poweroff is what needs to happen when someone issues the
poweroff command (or, when we get hibernate support, the power off
hook will also be called to power the system off after saving all
system state.)  So, a power off callback really better power the
system off and not reboot it.

reset vs restart is a choice, and one of those should happen as a result
of the reboot command, or other similar event which ends up requesting
a system restart.  That may be configurable.

Ultimately though, this should have no bearing on the hooking of poweroff
and restart callbacks; the only difference there is on Vexpress is the
function code passed to the system controller.

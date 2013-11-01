From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 00/11] RFC: Common machine reset handling
Date: Fri, 01 Nov 2013 09:58:49 -0600
Message-ID: <5273CFB9.1080603@wwwdotorg.org>
References: <20131031062708.520968323@linux.com> <5272D05E.1070207@wwwdotorg.org> <20131101051610.GA28233@glitch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:39772 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084Ab3KAP6x (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Nov 2013 11:58:53 -0400
In-Reply-To: <20131101051610.GA28233@glitch>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Domenico Andreoli <domenico.andreoli@linux.com>, linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org

On 10/31/2013 11:16 PM, Domenico Andreoli wrote:
> On Thu, Oct 31, 2013 at 03:49:18PM -0600, Stephen Warren wrote:
>> On 10/31/2013 12:27 AM, Domenico Andreoli wrote:
>>> Hi,
>>>
>>>   I've been looking for a solution to my bcm4760 watchdog based restart
>>> hook when I noticed that the kernel reboot/shutdown mechanism is having
>>> a few unaddressed issues.
>>>
>>> Those I identified are:
>>>
>>>  1) context pointer often needed by the reset hook
>>>     (currently local static data is used for this pourpose)
>>>  2) unclear ownership/policy in case of multiple reset hooks
>>>     (currently almost nobody seems to care much)
>>
>> I'm not sure how this patchset solves (2); even with the new API, it's
>> still the case that whichever code calls set_machine_reset() last wins,
>> just like before where whichever code wrote to pm_power_off won. I'm not
>> sure what this series attempts to solve.
> 
> That's right, the last wins. But the previous has a chance to know.
> 
> I only supposed there is somebody in charge of selecting the best handler
> for the machine. Don't know how fancy this decision is but at least for
> the vexpress there is also a sysfs way to configure different reset methods
> from user-space.

For PMICs that provide power off, we've been adding a property to DT to
indicate whether the PMIC is *the* system power off controller or not.
If the property is present, the PMIC registers itself in the poweroff
hook. If not, it doesn't. So, there really isn't an algorithm for
selecting the power off mechanism, but rather we designate one mechanism
ahead of time, and that's the only one that's relevant. We could
probably do the same for reset mechanisms.

I guess the vexpress situation is actually the same; there's a single
concept of a custom vexpress reset, it's just that sysfs is used to
select exactly what that does?

> So cleaning up things after the handler is replaced seemed a sensible
> thing to do.

Can't we avoid replacing handlers, but only registering a single handler?

> Another "problem" this patch would solve is the registration of the
> reset handler in a architecture independent way. Now an otherwise platform
> generic gpio HW reset driver would need to do different things on different
> architectures.

OK, if there are architecture differences in how the hooks are
registered, that seems like a good thing to fix.

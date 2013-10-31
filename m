From: Domenico Andreoli <domenico.andreoli@linux.com>
Subject: [PATCH 00/11] RFC: Common machine reset handling
Date: Thu, 31 Oct 2013 07:27:08 +0100
Message-ID: <20131031062708.520968323@linux.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ea0-f177.google.com ([209.85.215.177]:50392 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836Ab3JaGaE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 31 Oct 2013 02:30:04 -0400
Received: by mail-ea0-f177.google.com with SMTP id f15so1111162eak.8
        for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2013 23:30:02 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mips@lvger.kernel.org, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Ralf Baechle <ralf@linux-mips.org>

Hi,

  I've been looking for a solution to my bcm4760 watchdog based restart
hook when I noticed that the kernel reboot/shutdown mechanism is having
a few unaddressed issues.

Those I identified are:

 1) context pointer often needed by the reset hook
    (currently local static data is used for this pourpose)
 2) unclear ownership/policy in case of multiple reset hooks
    (currently almost nobody seems to care much)
 
I put together this patchset to explore some possible interface
and improve the status, essentially moving away from the
function-pointer-assignament kind of reset hook registration.

It is meant to be platform agnostic and sits in kernel/machine_reset.c. It
opts in only when needed and when supported.

A common usage, as reset hook provider (drivers, boardfiles):

	void restart_hook(void *dev, enum reboot_mode mode, const char *cmd)
{
	/* reboot the board */
}

void release_hook(void *dev)
{
	/* release the hook */
}

void init_restart_hook(void *dev)
{
	struct reset_hook hook;
	reset_hook_init(&hook);
	hook.restart = restart_hook;
	hook.release = release_hook; /* optional */
	set_machine_reset(RESET_RESTART, &hook, dev);
}


A common usage, as reset hook consumer (arch specific hooks, kernel):

	void machine_restart(char *command)
{
	if (_machine_restart)
		_machine_restart(command);
	else
		default_restart(reboot_mode, command);
}

void machine_halt(void)
{
	if (_machine_halt)
		_machine_halt();
	else
		default_halt();
}

void machine_power_off(void)
{
	if (pm_power_off)
		pm_power_off();
	else
		default_power_off();
}


I don't see these impressive diffstats but at least it's possible to free
some static data along the way. Maybe there are some other desiderata that
could be satisfied?

Comments are welcome.

Thanks,
Domenico

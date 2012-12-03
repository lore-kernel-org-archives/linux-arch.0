From: James Hogan <james.hogan@imgtec.com>
Subject: What's the deal with the different boot command lines?
Date: Mon, 3 Dec 2012 17:08:35 +0000
Message-ID: <50BCDC93.4080100@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:51606 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754000Ab2LCRJL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 3 Dec 2012 12:09:11 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Jonas Bonn <jonas.bonn@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Grant Likely <grant.likely@secretlab.ca>
Cc: linux-arch <linux-arch@vger.kernel.org>

Hi,

I've been trying to figure out how the various copies of the command
line are handled and what they're for, to figure out what the best thing
to do is to avoid getting the same cmdline twice when
early_init_dt_scan_chosen falls back to CONFIG_CMDLINE. As far as I can
tell from the generic code:

setup_arch() is expected to set
* boot_command_line
* the pointer pointed to by it's argument (which goes into
start_kernel()'s command_line variable).

What is the intention of both of these command lines? Are they supposed
to be the same, or different, or what?

boot_command_line:
* passed to parse_args("early options", ...)
* gets printed
* copied to saved_command_line, which is copied to static_command_line
and used for parsing args at each init level

command_line:
* copied to static_command_line first, and passed to parse_args("Booting
kernel", ...)

Some interesting architecture's setup_arch() behaviour that I've noticed:

Openrisc appears to set command_line to CONFIG_CMDLINE, but gets
boot_command_line from the devicetree chosen.bootargs, which defaults to
CONFIG_CMDLINE. So it appears that it provides different values. Was
this intentional?

MIPS appears to use of_scan_flat_dt to set arcs_cmdline from the
devicetree (this will default to CONFIG_CMDLINE). CONFIG_CMDLINE may
then be appended again in arch_mem_init. This is the same problem we
have with metag. I'm of the opinion that of_scan_flat_dt is doing the
wrong thing in falling back to CONFIG_CMDLINE, but maybe I misunderstand
and it just doesn't matter if command line options are repeated. Any
thoughts?

Thanks
James

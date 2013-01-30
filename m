From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v3 40/71] ARC: OProfile support
Date: Wed, 30 Jan 2013 12:04:29 +0530
Message-ID: <5108BEF5.6030500@synopsys.com>
References: <1359025589-22277-1-git-send-email-vgupta@synopsys.com> <1359025589-22277-25-git-send-email-vgupta@synopsys.com> <5108016B.5050303@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from kiruna.synopsys.com ([198.182.44.80]:36107 "EHLO
	kiruna.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753363Ab3A3Gf3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 30 Jan 2013 01:35:29 -0500
In-Reply-To: <5108016B.5050303@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, Robert Richter <rric@kernel.org>, oprofile-list@lists.sf.net

On Tuesday 29 January 2013 10:35 PM, James Hogan wrote:
> Hi Vineet,
>
> You don't appear to define CONFIG_HW_PERF_EVENTS, so
> include/linux/oprofile.h will presumably define oprofile_perf_init as
> just a pr_info(...); return -ENODEV;
>
> Similarly drivers/oprofile/oprofile_perf.o doesn't seem to be being built.
>
> I'm probably missing something somewhere?

Not much :-)

oprofile_arch_init() failure causes oprofile to fall back to timer based PC only
sampling - for coarse grained profiling. I'll soon be starting on integratign the
hardware counter support to both oprofile/perf.

FWIW, I just re-verified that latest upstream OProfile works fine with 3.8 kernel.

[ARCLinux]$ uname -a
Linux ARCLinux 3.8.0-rc4+ #2 Wed Jan 30 11:13:21 IST 2013 arc GNU/Linux
[ARCLinux]$ ./opcontrol -v
opcontrol: oprofile 0.9.9git compiled on Jan 30 2013 11:40:15
[ARCLinux]$ ./opcontrol --dump
[ARCLinux]$ ./opreport -l /mnt/arc/next-linux/vmlinux
Using /var/lib/oprofile/samples/ for samples directory.
CPU: CPU with timer interrupt
Profiling through timer interrupt
samples  %        symbol name
856      69.3679  cpu_idle
61        4.9433  arch_local_irq_enable
....

Thx for taking a look and if you are content - a Reviewed-by please (and for
DeviceTree patch as well if that looks sane now). I'll start doing the same for
metag patches after this one bug I'm debugging right now.

-Vineet

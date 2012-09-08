From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v3 00/31] AArch64 Linux kernel port
Date: Sat, 08 Sep 2012 14:48:35 +0530
Message-ID: <504B0D6B.9010908@ti.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:46051 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752547Ab2IHJSm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 8 Sep 2012 05:18:42 -0400
Received: by iebc10 with SMTP id c10so1399343ieb.1
        for <linux-arch@vger.kernel.org>; Sat, 08 Sep 2012 02:18:41 -0700 (PDT)
In-Reply-To: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

Catalin,

On Friday 07 September 2012 09:56 PM, Catalin Marinas wrote:
> This is the 3rd version of patches implementing Linux kernel support for
> the 64-bit ARM architecture. Most of the review comments for the
> previous release have been implemented. There are a few left (like
> generic timer dts specification) but the main goal was to freeze the
> user ABI.
>
> The Linux kernel patches are available on this tree:
>
Firstly thanks for clarifying the questions asked on the previous
version and also for the update on the arch timer code.

Mostly I was looking at the series from SOC boot and CPU PM
point of view and boot part seems to just fine.

As per discussion at LPC, I have gone through the SMC
proposal which ARM has published. In general the boot part
with SMC seems to be doable and can be standardized across SOCs.
The part which will be conflicting is the CPU power management.
That seems to be the harder one and the document is at too
infancy stage from the details point of view. Some bits about
save, restore are related to switcher kind of architecture, which
may not be the requirement for all the SoCs.

Ofcourse the SMC discussion is not related to $subject series
as such. Also the PM support for ARMv8 not seems be the scope
of the series so the discussion can be parked aside till we
need to talk about it. I have few more questions on the various
MM attribute usage, exceptions and PL's but I will do some
reading before asking those to you.

For the series itself, feel free to add my ack if yo
need one.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

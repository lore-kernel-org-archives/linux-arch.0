Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53284 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387530AbfG2K7a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jul 2019 06:59:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so53422491wmj.3
        for <linux-arch@vger.kernel.org>; Mon, 29 Jul 2019 03:59:28 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH 0/2] clocksource/Hyper-V: Add Hyper-V specific sched clock function
In-Reply-To: <20190729075243.22745-1-Tianyu.Lan@microsoft.com>
References: <20190729075243.22745-1-Tianyu.Lan@microsoft.com>
Date: Mon, 29 Jul 2019 12:59:26 +0200
Message-ID: <87zhkxksxd.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: lantianyu1986@gmail.com
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>, linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org, daniel.lezcano@linaro.org, arnd@arndb.de, michael.h.kelley@microsoft.comashal@kernel.org
Message-ID: <20190729105926.9SlbxShh6mhyLBg42THAPPD5JqLEVJ9cr-H7YsxtCBs@z>

lantianyu1986@gmail.com writes:

> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>
> Hyper-V guests use the default native_sched_clock() in pv_ops.time.sched_clock
> on x86.  But native_sched_clock() directly uses the raw TSC value, which
> can be discontinuous in a Hyper-V VM.   Add the generic hv_setup_sched_clock()
> to set the sched clock function appropriately.  On x86, this sets
> pv_ops.time.sched_clock to read the Hyper-V reference TSC value that is
> scaled and adjusted to be continuous.

Hypervisor can, in theory, disable TSC page and then we're forced to use
MSR-based clocksource but using it as sched_clock() can be very slow,
I'm afraid.

On the other hand, what we have now is probably worse: TSC can,
actually, jump backwards (e.g. on migration) and we're breaking the
requirements for sched_clock().

-- 
Vitaly

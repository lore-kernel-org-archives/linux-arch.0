Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:56003 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfKTJuD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Nov 2019 04:50:03 -0500
Date: Wed, 20 Nov 2019 10:49:51 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/2] x86/hyperv: Implement
 hv_is_hibernation_supported()
In-Reply-To: <1574234165-49066-2-git-send-email-decui@microsoft.com>
Message-ID: <alpine.DEB.2.21.1911201049030.6731@nanos.tec.linutronix.de>
References: <1574234165-49066-1-git-send-email-decui@microsoft.com> <1574234165-49066-2-git-send-email-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dexuan Cui <decui@microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, mikelley@microsoft.com, david@redhat.com, arnd@arndb.de, bp@alien8.de, daniel.lezcano@linaro.org, hpa@zytor.com, mingo@redhat.com, x86@kernel.org, Alexander.Levin@microsoft.com, vkuznets@redhat.com, linux-arch@vger.kernel.org
Message-ID: <20191120094951.3pxkHaYAm8k9fkvFmlY26xANyKXh9xMOemaqhfK3RMY@z>

On Tue, 19 Nov 2019, Dexuan Cui wrote:
> Once all the vmbus and VSC patches for the hibernation feature are
> accepted, an extra patch will be submitted to forbid hibernation if the
> virtual ACPI S4 state is absent, i.e. hv_is_hibernation_supported() is
> false.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> ---
> 
> v2 is actually the same as v1. This is just a resend.
> 
> I suggest this patch should go through the Hyper-V tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=hyperv-next
> because it's needed by
> [PATCH v2 2/2] hv_balloon: Add the support of hibernation
> and some upcoming patches.

Acked-by: Thomas Gleixner <tglx@linutronix.de>

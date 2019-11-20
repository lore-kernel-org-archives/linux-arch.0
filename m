Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbfKTOKB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Nov 2019 09:10:01 -0500
Date: Wed, 20 Nov 2019 09:09:59 -0500
From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 0/2] Implement hv_is_hibernation_supported() and
 enhance hv_balloon for hibernation
Message-ID: <20191120140959.GG16867@sasha-vm>
References: <1574234165-49066-1-git-send-email-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1574234165-49066-1-git-send-email-decui@microsoft.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dexuan Cui <decui@microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, mikelley@microsoft.com, david@redhat.com, arnd@arndb.de, bp@alien8.de, daniel.lezcano@linaro.org, hpa@zytor.com, mingo@redhat.com, tglx@linutronix.de, x86@kernel.org, Alexander.Levin@microsoft.com, vkuznets@redhat.com, linux-arch@vger.kernel.org
Message-ID: <20191120140959.pS5uyMQa1Iv7RR3Q16eo6IzgOKcZ-j4D9YBEq0CNtws@z>

On Tue, Nov 19, 2019 at 11:16:03PM -0800, Dexuan Cui wrote:
>v2 is actually the same as v1. This is just a resend.
>
>I suggest both the patches should go through the Hyper-V tree:
>https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=hyperv-next
>because the first patch is needed by the second one.
>
>This first patch doesn't conflict with any patch in the tip.git tree.

Queued for hyperv-next, thanks!

-- 
Thanks,
Sasha

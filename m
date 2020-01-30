From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6][RESEND] x86/hyperv: Suspend/resume the hypercall page for hibernation
Date: Thu, 30 Jan 2020 08:37:29 +0100
Message-ID: <877e195r9i.fsf@nanos.tec.linutronix.de>
References: <20200130000552.GD2896@sasha-vm>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200130000552.GD2896@sasha-vm>
Sender: linux-kernel-owner@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc: "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Haiyang Zhang <haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, Stephen Hemminger <sthemmin@microsoft.com>, "x86@kernel.org" <x86@kernel.org>, Michael Kelley <mikelley@microsoft.com>, Sasha Levin <Alexander.Levin@microsoft.com>, vkuznets <vkuznets@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Sasha Levin <sashal@kernel.org> writes:
> On Sat, Jan 25, 2020 at 01:44:31AM +0000, Dexuan Cui wrote:
>>> This is a RESEND of https://lkml.org/lkml/2019/11/20/68
>>>
>>> Please review.
>>>
>>> If it looks good, can you please pick it up through the tip.git tree?
>>>
>>>  arch/x86/hyperv/hv_init.c | 48
>>> +++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 48 insertions(+)
>>
>>Hi, Vitaly and x86 maintainers,
>>Can you please take a look at this patch?
>
> Ping?
>
> This patch has been floating around in it's current form for the past 2
> months. I'll happily take Hyper-V patches under arch/x86/hyperv/ via the
> Hyper-V tree rather than tip if the x86 folks don't want to deal with
> them.

sorry fell through the cracks. Will take care of it.

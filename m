From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] spectre variant1 mitigations for 4.16
Date: Sat, 20 Jan 2018 20:49:32 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1801202047400.1998@nanos>
References: <1516473386.30886.35.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kernel-hardening-return-11366-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
In-Reply-To: <1516473386.30886.35.camel@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "alan@linux.intel.com" <alan@linux.intel.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "Reshetova, Elena" <elena.reshetova@intel.com>, "johannes@sipsolutions.net" <johannes@sipsolutions.net>, "will.deacon@arm.com" <will.deacon@arm.com>, "luto@kernel.org" <luto@kernel.org>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Dan,

On Sat, 20 Jan 2018, Williams, Dan J wrote:

> The following changes since commit a8750ddca918032d6349adbf9a4b6555e7db20da:
> 
>   Linux 4.15-rc8 (2018-01-14 15:32:30 -0800)

can you please post the individual patches? I want to make sure that they
go through x86/pti for ease of backporting.

Thanks,

	tglx

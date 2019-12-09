From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 3/3] arm64 cpuinfo: implement sysfs nodes for arm64
Date: Mon, 9 Dec 2019 10:31:11 +0000
Message-ID: <20191209103110.GB3306@willie-the-truck>
References: <20191206162421.15050-1-trenn@suse.de>
 <20191206162421.15050-4-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191206162421.15050-4-trenn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Felix Schnizlein <fschnizlein@suse.de>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk, will.deacon@arm.com, x86@kernel.org, fschnitzlein@suse.de, Felix Schnizlein <fschnizlein@suse.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Dec 06, 2019 at 05:24:21PM +0100, Thomas Renninger wrote:
> From: Felix Schnizlein <fschnizlein@suse.de>
> 
> Export all information from /proc/cpuinfo to sysfs:
> implementer, architecture, variant, part, revision,
> bogomips and flags are exported.
> 
> Example:
> /sys/devices/system/cpu/cpu1/info/:[0]# head *
> ==> architecture <==
> 8
> 
> ==> bogomips <==
> 40.00
> 
> ==> flags <==
> fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid asimdrdm
> 
> ==> implementer <==
> 0x51
> 
> ==> part <==
> 0xc00
> 
> ==> revision <==
> 1
> 
> ==> variant <==
> 0x0
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> Signed-off-by: Felix Schnizlein <fschnizlein@suse.com>
> ---
>  Documentation/ABI/testing/sysfs-devices-system-cpu | 22 +++++++++
>  arch/arm64/Kconfig                                 |  1 +
>  arch/arm64/kernel/cpuinfo.c                        | 55 ++++++++++++++++++++++
>  3 files changed, 78 insertions(+)

I don't understand why we need this on arm64 and why it's an improvement
over all the other schemes we already support for identifying CPU features.

Given the pain we've endured over the years exposing this sort of stuff to
userspace, I'm relucant to add more just for the fun of it.

Will

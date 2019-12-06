Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbfLFQhY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Dec 2019 11:37:24 -0500
Date: Fri, 6 Dec 2019 17:37:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/3] arm64 cpuinfo: implement sysfs nodes for arm64
Message-ID: <20191206163720.GD86904@kroah.com>
References: <20191206162421.15050-1-trenn@suse.de>
 <20191206162421.15050-4-trenn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206162421.15050-4-trenn@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Renninger <trenn@suse.de>
Cc: linux-kernel@vger.kernel.org, Felix Schnizlein <fschnizlein@suse.de>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk, will.deacon@arm.com, x86@kernel.org, fschnitzlein@suse.de, Felix Schnizlein <fschnizlein@suse.com>
Message-ID: <20191206163720.Jhr49eDsfiC9NooanoRtKwb8SjHb2liFHBZQqNd37js@z>

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

Same comments as on the x86 patch :(

Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729278AbfLKN42 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Dec 2019 08:56:28 -0500
Date: Wed, 11 Dec 2019 14:56:19 +0100
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/3] x86 cpuinfo: implement sysfs nodes for x86
Message-ID: <20191211135619.GA538980@kroah.com>
References: <20191206162421.15050-1-trenn@suse.de>
 <20191206163656.GC86904@kroah.com>
 <87sglroqix.fsf@nanos.tec.linutronix.de>
 <4737004.4U1sY2OxSp@skinner.arch.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4737004.4U1sY2OxSp@skinner.arch.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Renninger <trenn@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Felix Schnizlein <fschnizlein@suse.com>, linux-kernel@vger.kernel.org, Felix Schnizlein <fschnizlein@suse.de>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk, will.deacon@arm.com, x86@kernel.org
Message-ID: <20191211135619.X68T8LMDWXpv359DMpdZFVMrs_b6QRPKjwbAIjt-HLI@z>

On Wed, Dec 11, 2019 at 11:42:35AM +0100, Thomas Renninger wrote:
> If Greg (and others) are ok, I would add "page size exceeding" handling.
> Hm, quick searching for an example I realize that debugfs can exceed page 
> size. Is it that hard to expose a sysfs file larger than page size?

No, there is a simple way to do it, but I'm not going to show you how as
it is NOT how to use sysfs at all :)

Why are you wanting to dump this whole mess into one file and then parse
it, it's no different from having 100+ different sysfs files and then
doing a readdir(3) on the thing, right?

greg k-h

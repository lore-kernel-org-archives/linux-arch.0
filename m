Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39800 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727554AbfLKOMy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Dec 2019 09:12:54 -0500
From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/3] x86 cpuinfo: implement sysfs nodes for x86
Date: Wed, 11 Dec 2019 15:12:51 +0100
Message-ID: <22533595.7ohjOCJ8As@skinner.arch.suse.de>
In-Reply-To: <20191211135619.GA538980@kroah.com>
References: <20191206162421.15050-1-trenn@suse.de> <4737004.4U1sY2OxSp@skinner.arch.suse.de> <20191211135619.GA538980@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Felix Schnizlein <fschnizlein@suse.com>, linux-kernel@vger.kernel.org, Felix Schnizlein <fschnizlein@suse.de>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk, will.deacon@arm.com, x86@kernel.org
Message-ID: <20191211141251.6hBQMKqmYh40PvKfibjWHiqT5Ki2KMZzE7wPdfGEG6g@z>

On Wednesday, December 11, 2019 2:56:19 PM CET Greg KH wrote:
> On Wed, Dec 11, 2019 at 11:42:35AM +0100, Thomas Renninger wrote:
> > If Greg (and others) are ok, I would add "page size exceeding" handling.
> > Hm, quick searching for an example I realize that debugfs can exceed page
> > size. Is it that hard to expose a sysfs file larger than page size?
> 
> No, there is a simple way to do it, but I'm not going to show you how as
> it is NOT how to use sysfs at all :)
>
> Why are you wanting to dump this whole mess into one file

I wouldn't call a whitespace separated list of CPU feature flags a mess...

> and then parse
> it, it's no different from having 100+ different sysfs files and then
> doing a readdir(3) on the thing, right?

If this is the way it "has to"/should/"is designed for" to export such
(not that complex) data via sysfs...

I do not have such a strong opinion on the how, this is up to maintainers
to discuss.

I hope it is agreed that this info is worth exporting via sysfs.
So I wait for the "how are CPU feature flags/bugs data" to be exported
via sysfs and I volunteer to pick it up and submit a patch out of it.

Thanks,

   Thomas

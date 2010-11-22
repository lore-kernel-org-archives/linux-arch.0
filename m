From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] persistent store
Date: Mon, 22 Nov 2010 10:43:12 +0000
Message-ID: <20101122104312.23b6daea@lxorguk.ukuu.org.uk>
References: <4ce85e437577ae827@agluck-desktop.sc.intel.com>
	<1290391175.2903.132.camel@yhuang-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:34169 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753303Ab0KVKpH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 22 Nov 2010 05:45:07 -0500
In-Reply-To: <1290391175.2903.132.camel@yhuang-dev>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Huang Ying <ying.huang@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@elte.hu" <mingo@elte.hu>, "greg@kroah.com" <greg@kroah.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>

> > "reader" which iterates over all records currently in the
> > store - returning type, size and a record identifier as
> > well as the actual data.
> > 
> > "writer" which writes a record with a type to the persistent store
> 
> I think it is necessary to require this to be NMI safe (in comments?),
> because hardware error handler may need to write to persistent storage
> in NMI context. Or we can add a "flag" field to let storage provider
> advocate its capability of NMI safe.

One thing we need for some of the driver code sitting in the pending pile
is support for hardware assisted logging, where record numberes are handed
out by a device register access.

> > The "type" of error record I mentioned earlier is used to
> > name the files ... saved console logs from kmsg_dmp() are
> > named with a "dmesg" prefix as shown above.
> > 
> > Once an error record has been viewed, analysed, saved. The
> > user can request it to be cleared by writing its name to the
> > "erase" file:

How will fragmentation be handled ?

> The persistent storage may be full, and the writing may fail. So I think
> we can just try to write one by one, until the first success writing.

If you intend to treat it basically like an fs why not just make it a
file system. No more weird echo erase into magic sysfs file node you can
just use "rm".

The logging off an interrupt isn't a big problem either as you can have a
pool of blocks which are preallocated for the log files and more can be
stitched into the files asynchronously after the interrupt logging
events. For that matter you can keep it as a circular log just easily but
present it as a file system.

> [...]
> > + * Erase records by writing their filename to the "erase" file. E.g.
> > + *     # echo "dmesg-0" > erase

rm dmesg-0

We have a model for this and filesystem indirected via sysfs commands is
in the daft category.

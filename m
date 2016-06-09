Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49366 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752395AbcFIREX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 9 Jun 2016 13:04:23 -0400
Date: Thu, 9 Jun 2016 12:04:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH][RFC] PCI: Workaround to enable poweroff on Mac Pro 11
Message-ID: <20160609170419.GC1109@localhost>
References: <1464604404-11257-1-git-send-email-yu.c.chen@intel.com>
 <20160530213305.GA21322@localhost>
 <574D03F9.6050201@intel.com>
 <CAE9FiQV_Mc9VuyBvCB7hL_0pgj+-wW1_jupzhbTHij+VQeLF-A@mail.gmail.com>
 <574D3AAA.6090503@intel.com>
 <20160531131658.GA23837@localhost>
 <57579F9F.6010200@intel.com>
 <20160608124742.GA16764@localhost>
 <20160609165011.GA1109@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160609165011.GA1109@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Yinghai Lu <yinghai@kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Message-ID: <20160609170419.Km2gzgLn49x4B5z-NNwMdMc-ETRfRpCfEhM1nMkIhDg@z>

On Thu, Jun 09, 2016 at 11:50:11AM -0500, Bjorn Helgaas wrote:

> 5) 00:1c.0 claims to have a slot that supports hotplug.  Is that
>    actually true?  Could you add a device below it?  If not, maybe the
>    problem is that the BIOS should have configured 00:1c.0 so it
>    doesn't report a slot.  If it didn't report a slot, we shouldn't
>    assign resources to it, since there is no possibility of a device
>    below it.

Of course, this would only be *part* of the problem, because a hot-added
device somewhere else could still be assigned the space at 
[mem 0x7fc00000-0x7fdfffff].

This just smells like an unreported device in there somewhere.

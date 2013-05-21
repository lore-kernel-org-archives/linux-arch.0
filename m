Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ams-iport-2.cisco.com ([144.254.224.141]:59329 "EHLO
	ams-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655Ab3EUHsz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 May 2013 03:48:55 -0400
From: Hans Verkuil <hansverk@cisco.com>
Subject: Re: [PATCH] Finally eradicate CONFIG_HOTPLUG
Date: Tue, 21 May 2013 09:38:42 +0200
References: <20130521134935.d18c3f5c23485fb5ddabc365@canb.auug.org.au>
In-Reply-To: <20130521134935.d18c3f5c23485fb5ddabc365@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <201305210938.43064.hansverk@cisco.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Doug Thompson <dougthompson@xmission.com>, linux-edac@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-pcmcia@lists.infradead.org, Hans Verkuil <hans.verkuil@cisco.com>, Steven Whitehouse <swhiteho@redhat.com>, cluster-devel@redhat.com, Arnd Bergmann <arnd@arndb.de>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
Message-ID: <20130521073842.jK2Mw0eNA-_QbTutzfTMOUqqQTIMRRPvMEX-0-Mk3FU@z>

On Tue 21 May 2013 05:49:35 Stephen Rothwell wrote:
> Ever since commit 45f035ab9b8f ("CONFIG_HOTPLUG should be always on"),
> it has been basically impossible to build a kernel with CONFIG_HOTPLUG
> turned off.  Remove all the remaining references to it.
> 
> Cc: linux-arch@vger.kernel.org
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Doug Thompson <dougthompson@xmission.com>
> Cc: linux-edac@vger.kernel.org
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-pcmcia@lists.infradead.org
> Cc: Hans Verkuil <hans.verkuil@cisco.com>
> Cc: Steven Whitehouse <swhiteho@redhat.com>
> Cc: cluster-devel@redhat.com
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Cc: linux-pm@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

For drivers/staging/media/go7007/go7007.txt:

Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

Regards,

	Hans

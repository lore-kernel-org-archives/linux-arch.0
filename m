Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40808 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754497AbcAHKPB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jan 2016 05:15:01 -0500
Date: Fri, 8 Jan 2016 12:14:48 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/3] checkpatch: add virt barriers
Message-ID: <20160108121352-mutt-send-email-mst@redhat.com>
References: <1451907395-15978-1-git-send-email-mst@redhat.com>
 <1451907395-15978-4-git-send-email-mst@redhat.com>
 <1451926073.4334.90.camel@perches.com>
 <20160104230528-mutt-send-email-mst@redhat.com>
 <1451945497.4334.107.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1451945497.4334.107.camel@perches.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, "Cc : Andy Whitcroft" <apw@canonical.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@kernel.org>, Tony Lindgren <tony@atomide.com>, Andrey Konovalov <andreyknvl@google.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Message-ID: <20160108101448.Mhh4Zh87hO73J6iQxYBwqZfZBjJ_FJ93T36NwvqdX9Q@z>

On Mon, Jan 04, 2016 at 02:11:37PM -0800, Joe Perches wrote:
> On Mon, 2016-01-04 at 23:07 +0200, Michael S. Tsirkin wrote:
> > On Mon, Jan 04, 2016 at 08:47:53AM -0800, Joe Perches wrote:
> > > On Mon, 2016-01-04 at 13:37 +0200, Michael S. Tsirkin wrote:
> > > > Add virt_ barriers to list of barriers to check for
> > > > presence of a comment.
> > > 
> > > Are these virt_ barriers used anywhere?
> > > 
> > > I see some virtio_ barrier like uses.
> > 
> > They will be :) They are added and used by patchset
> > 	        arch: barrier cleanup + barriers for virt
> > 
> > See
> > http://article.gmane.org/gmane.linux.kernel.virtualization/26555
> 
> Ah, OK, thanks.
> 
> Are the virtio_ barriers going away?
> If not, maybe those should be added too.

I don't mind. I'll queue a patch like that.


-- 
MST

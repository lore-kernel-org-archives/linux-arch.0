Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:44703 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161173AbWASCbp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 Jan 2006 21:31:45 -0500
From: Andi Kleen <ak@suse.de>
Subject: Re: new syscalls
Date: Thu, 19 Jan 2006 03:30:08 +0100
References: <B8E391BBE9FE384DAA4C5C003888BE6F05737A9F@scsmsx401.amr.corp.intel.com> <20060118133629.1cda96fd.akpm@osdl.org> <Pine.LNX.4.62.0601181716520.3217@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0601181716520.3217@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601190330.09115.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, "Luck, Tony" <tony.luck@intel.com>, linux-arch@vger.kernel.org, JANAK DESAI <janak@us.ibm.com>, Ulrich Drepper <drepper@redhat.com>, David Woodhouse <dwmw2@infradead.org>, David Howells <dhowells@redhat.com>, Davide Libenzi <davidel@xmailserver.org>, Christoph Lameter <christoph@lameter.com>
List-ID: <linux-arch.vger.kernel.org>

On Thursday 19 January 2006 02:19, Christoph Lameter wrote:
> On Wed, 18 Jan 2006, Andrew Morton wrote:
> > Guys, architecture maintainers need test suites to verify that the
> > syscalls actually work as they wire them up.  Please share.  A stable URL
> > would be preferred - something which can go into the changlog or
> > conceivably into the kernel source.
>
> sys_migrate_pages will be supported by libnuma in Andi Kleen's numactl
> package. There is no URL that I am aware of.

The home is ftp://ftp.suse.com/pub/people/ak/numa/

The main server is a bit slow, best use a mirror like
ftp://ftp.gwde.de/pub/linux/suse/ftp.suse.com/people/ak/numa

But I haven't pushed out a  update with Christoph's patch yet
(will do ASAP)

And of course you'll need a CONFIG_NUMA=y multi node system to actually try 
it, that probably rules it out on most architectures. On the others 
it will always -ENOSYS.

-Andi

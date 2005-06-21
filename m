Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j5LGHsvJ011581
	for <linux-arch@vger.kernel.org>; Tue, 21 Jun 2005 12:17:54 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j5LGHsKK199132
	for <linux-arch@vger.kernel.org>; Tue, 21 Jun 2005 12:17:54 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j5LGHoIr016794
	for <linux-arch@vger.kernel.org>; Tue, 21 Jun 2005 12:17:51 -0400
Subject: RE: sparsemem patches in -mm
From: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F03BF854E@scsmsx401.amr.corp.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F03BF854E@scsmsx401.amr.corp.intel.com>
Content-Type: text/plain
Date: Tue, 21 Jun 2005 09:17:32 -0700
Message-Id: <1119370652.27442.39.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>, "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2005-06-21 at 09:09 -0700, Luck, Tony wrote:
> >I'd only suggest that we keep the "extreme" stuff in -mm for a couple
> >more releases.  It's a pretty clean add-on, and it has only had a very
> >short time in -mm.  Bob, would you agree?
> 
> Without the extreme code, I'll have a hard time putting together a
> practical generic config for ia64.  When you say "a couple more releases",
> are you referring to "-mm" releases, or Linus releases?

Just -mm.  I think it's only been in one -mm release so far.  The rest
of sparsemem has been in -mm since early May.

I have memory hotplug working on top of the extreme patches as well now,
which required a few more tweaks.  That kind of tweaking needs to be
completed by the time it's submitted to mainline, and it's just not
quite there yet.  I'm sure it will be soon.

-- Dave

Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:47666 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760849AbXGTIcy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Jul 2007 04:32:54 -0400
From: Andi Kleen <ak@novell.com>
Subject: Re: build fix for x86_64...
Date: Fri, 20 Jul 2007 10:32:47 +0200
References: <617E1C2C70743745A92448908E030B2A01FA4327@scsmsx411.amr.corp.intel.com>
In-Reply-To: <617E1C2C70743745A92448908E030B2A01FA4327@scsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200707201032.47545.ak@novell.com>
Sender: linux-arch-owner@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Arthur Jones <arthur.jones@qlogic.com>, Vasily Tarasov <vtaras@openvz.org>, linux-kernel@vger.kernel.org, Jan Kara <jack@ucw.cz>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Friday 20 July 2007 01:54:51 Luck, Tony wrote:
 
> > Tony, perhaps it would make sense to define some common CONFIG
> > for COMPAT_FOR_U64_ALIGNMENT longer term to make the #ifs for this
> > case a little less ugly.
> 
> Certainly if there is ever a third architecture that needs this the
> #if mess will be beyond bad.  But with only the two of us we'd trade
> one ugly #ifdef line here for another half-dozen lines in each of
> our Kconfig files to define the new term. 

Half dozens? 

config COMPAT_FOR_U64_ALIGNMENT
	bool
	default y

-Andi

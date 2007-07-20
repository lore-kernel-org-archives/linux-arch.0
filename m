Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:60681 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759483AbXGTSNH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Jul 2007 14:13:07 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: build fix for x86_64...
Date: Fri, 20 Jul 2007 20:13:03 +0200
References: <617E1C2C70743745A92448908E030B2A01FA46A9@scsmsx411.amr.corp.intel.com> <jezm1rq8gz.fsf@sykes.suse.de> <46A0F4AC.50809@zytor.com>
In-Reply-To: <46A0F4AC.50809@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200707202013.03568.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andreas Schwab <schwab@suse.de>, "Luck, Tony" <tony.luck@intel.com>, Randy Dunlap <randy.dunlap@oracle.com>, Arthur Jones <arthur.jones@qlogic.com>, Vasily Tarasov <vtaras@openvz.org>, linux-kernel@vger.kernel.org, Jan Kara <jack@ucw.cz>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


> Obviously, this is not a panacea; if the original "struct foo" has also
> been introduced on 64 bits before the bug is caught, 

That's usually the case. There is already an established 64bit ABI

-Andi


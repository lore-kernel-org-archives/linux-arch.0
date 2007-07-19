Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:8237 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762025AbXGSXyy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jul 2007 19:54:54 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: build fix for x86_64...
Date: Thu, 19 Jul 2007 16:54:51 -0700
Message-ID: <617E1C2C70743745A92448908E030B2A01FA4327@scsmsx411.amr.corp.intel.com>
In-Reply-To: <200707200109.02039.ak@suse.de>
From: "Luck, Tony" <tony.luck@intel.com>
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>, Arthur Jones <arthur.jones@qlogic.com>
Cc: Vasily Tarasov <vtaras@openvz.org>, linux-kernel@vger.kernel.org, Jan Kara <jack@ucw.cz>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> Looks good.

Looks good to me too (I'm to blame for the version posted by Doug
that only fixed ia64 ... I didn't take the time to check whether
there was a CONFIG_COMPAT option for x86_64 ... oops).

> Tony, perhaps it would make sense to define some common CONFIG
> for COMPAT_FOR_U64_ALIGNMENT longer term to make the #ifs for this
> case a little less ugly.

Certainly if there is ever a third architecture that needs this the
#if mess will be beyond bad.  But with only the two of us we'd trade
one ugly #ifdef line here for another half-dozen lines in each of
our Kconfig files to define the new term.  I'm not sure whether that
is a win.

-Tony

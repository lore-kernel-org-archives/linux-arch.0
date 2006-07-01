Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:23719 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750779AbWGACiv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 Jun 2006 22:38:51 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17573.57397.70425.459137@cargo.ozlabs.ibm.com>
Date: Sat, 1 Jul 2006 12:38:45 +1000
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch] s390 kconfig cleanup, 2nd version.
In-Reply-To: <200606301605.53258.ak@suse.de>
References: <1151670404.11575.5.camel@localhost>
	<200606301509.16981.ak@suse.de>
	<1151674086.11575.24.camel@localhost>
	<200606301605.53258.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: schwidefsky@de.ibm.com, linux-arch@vger.kernel.org, geert@linux-m68k.org, Keir.Fraser@cl.cam.ac.uk, chrisw@sous-sol.org, matthew@wil.cx, akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>

Andi Kleen writes:

> ATA/IDE, parallel port, PNP could be PC_STYLE_HARDWARE. 

Hmmm, powermacs have ATA/IDE but not parallel ports or PNP.

Paul.

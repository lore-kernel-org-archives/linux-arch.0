Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55528 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759317AbXGSIXm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 Jul 2007 04:23:42 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 2.6.22] Do not include other cpus' interrupt 0 in nmi_watchdog
Date: Thu, 19 Jul 2007 10:23:36 +0200
References: <9346.1184828486@kao2.melbourne.sgi.com>
In-Reply-To: <9346.1184828486@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200707191023.36765.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Keith Owens <kaos@ocs.com.au>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thursday 19 July 2007 09:01:26 Keith Owens wrote:
> kstat_irqs(0) includes the count of interrupt 0 from all cpus, not just
> the current cpu.  The updated interrupt 0 on other cpus can stop the
> nmi_watchdog from tripping, so only include the current cpu's int 0.

I queued the patch thanks.

-Andi

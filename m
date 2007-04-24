Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:10232 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422919AbXDXR62 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 Apr 2007 13:58:28 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: larger per cpu data
Date: Tue, 24 Apr 2007 10:58:20 -0700
Message-ID: <617E1C2C70743745A92448908E030B2A0162DEC4@scsmsx411.amr.corp.intel.com>
In-Reply-To: <yq0odldpud2.fsf@jaguar.mkp.net>
From: "Luck, Tony" <tony.luck@intel.com>
Sender: linux-arch-owner@vger.kernel.org
To: Jes Sorensen <jes@sgi.com>
Cc: Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> 256KB * 1024 CPUs (or more) == verymightyhuge ..... I certainly
> wouldn't like to see this.

"Only" 256M :-)  That 1024 cpu system probably has 1TB of memory or
more ... so this isn't quite as terrible as it sounds (at least in
terms of percentage of memory used).

Are there customers buying high cpu count, low memory systems?

But unless these are some fabulously useful counters that Andi
wants to add ... I'd prefer to keep the ia64 percpu area at 64K
for a while longer.

-Tony

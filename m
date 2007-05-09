Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-4-out.sgi.com ([192.48.171.29]:36168 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756135AbXEIPww (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 May 2007 11:52:52 -0400
Date: Wed, 9 May 2007 08:52:51 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
Subject: Re: New slab allocator SLUB
In-Reply-To: <200705091536.21526.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0705090852140.27342@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0705081145360.11368@schroedinger.engr.sgi.com>
 <200705091536.21526.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org, akpm@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 9 May 2007, Andi Kleen wrote:

> Assuming you fix the performance regressions first?

There are no unfixed performance regressions. The netperf issue with 
Cloverton has a fix in mm.


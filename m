Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:33462 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S2993052AbXDTRFo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Apr 2007 13:05:44 -0400
Date: Fri, 20 Apr 2007 10:05:43 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
Subject: Re: Better local_t implementation needed
In-Reply-To: <200704201901.39437.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0704201004500.20647@schroedinger.engr.sgi.com>
References: <200704201256.13008.ak@suse.de> <Pine.LNX.4.64.0704200903130.20232@schroedinger.engr.sgi.com>
 <200704201901.39437.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 20 Apr 2007, Andi Kleen wrote:

> > Is the per cpu access fixed on x86? Last I checked it was not atomic.
> 
> With upcomming patches per cpu can be directly referenced using %fs/%gs
> Then cpu_local_add() etc will be a single instruction that is atomic
> regarding interrupts.

Ahh.. Great! When is that feature going to be available? 2.6.22?

Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from scrub.xs4all.nl ([194.109.195.176]:53341 "EHLO scrub.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767281AbXDTVxD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Apr 2007 17:53:03 -0400
From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Better local_t implementation needed
Date: Fri, 20 Apr 2007 23:25:04 +0200
References: <200704201256.13008.ak@suse.de>
In-Reply-To: <200704201256.13008.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200704202325.06301.zippel@linux-m68k.org>
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org, Christoph Lameter <clameter@sgi.com>
List-ID: <linux-arch.vger.kernel.org>

Hi,

On Friday 20 April 2007 12:56, Andi Kleen wrote:

> There used to be a portable implementation of local.h
> that instead defines local_t as a two value array
> indexed by in_interrupt(). I'm considering to add that back.

That doesn't really work in general, interrupts can interrupt other 
interrupts.

bye, Roman

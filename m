Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42149 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932454AbWAXAOI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 23 Jan 2006 19:14:08 -0500
From: Andi Kleen <ak@suse.de>
Subject: Re: [RFC] is_compat_task helper
Date: Tue, 24 Jan 2006 01:13:39 +0100
References: <20060124000753.GC5604@quicksilver.road.mcmartin.ca>
In-Reply-To: <20060124000753.GC5604@quicksilver.road.mcmartin.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601240113.39825.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Kyle McMartin <kyle@parisc-linux.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tuesday 24 January 2006 01:07, Kyle McMartin wrote:

> +/* Arches may override __is_compat_task from asm/compat.h */
> +#ifndef __is_compat_task
> +#define __is_compat_task(x)	(personality(x->personality) == PER_LINUX32)

I don't think this particular patch is a good idea. PER_LINUX32 means
something completely different than you think on many architectures.
You can't do a default for it.

-Andi

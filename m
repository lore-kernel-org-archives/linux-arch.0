From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 10/19] h8300: convert to generic init_task.c
Date: Thu, 11 Dec 2008 13:59:43 +0100
Message-ID: <200812111359.43858.arnd@arndb.de>
References: <cover.1228966585.git.kyle@mcmartin.ca> <1e07f124e694d9c5dcbd022e5e339649eedc4fd5.1228966585.git.kyle@mcmartin.ca> <14045ea83a7a5b2b4b151547da92270b1976e86d.1228966585.git.kyle@mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:57972 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756799AbYLKM7o (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Dec 2008 07:59:44 -0500
In-Reply-To: <14045ea83a7a5b2b4b151547da92270b1976e86d.1228966585.git.kyle@mcmartin.ca>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: linux-arch@vger.kernel.org, Kyle McMartin <kyle@redhat.com>

On Thursday 11 December 2008, Kyle McMartin wrote:
> This one has a bizarre 4-byte align on init_task, but that would
> (at least) be implied alignment on a struct...
> 
> Signed-off-by: Kyle McMartin <kyle@redhat.com>

I'm pretty sure that the .align was copied from m68knommu, which does
indeed have bizarre alignment rules and needs this.

	Arnd <><

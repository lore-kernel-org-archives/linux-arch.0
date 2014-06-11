From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/1] define generic version of cmpxchg{64} only if not, previously defined
Date: Wed, 11 Jun 2014 14:55:16 +0200
Message-ID: <201406111455.16343.arnd@arndb.de>
References: <5390EAAC.5070601@gatech.edu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:56734 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbaFKMzZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 11 Jun 2014 08:55:25 -0400
In-Reply-To: <5390EAAC.5070601@gatech.edu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pranith Kumar <pranith@gatech.edu>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 06 June 2014, Pranith Kumar wrote:
> 
> define generic versions of cmpxchg{64} only if not previously defined.
> 
> This makes these definition in-line to other definitions of generic versions
> 
> 
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

I assume  you have a patch that depends on this. Please queue up this first
patch in the same series as the one that needs it.

	Arnd

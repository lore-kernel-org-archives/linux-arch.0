From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH 10/17] tile: Remove tile-specific _sinitdata and _einitdata
Date: Thu, 14 Nov 2013 09:55:35 -0500
Message-ID: <5284E467.6040502@tilera.com>
References: <1384285347-13506-1-git-send-email-geert@linux-m68k.org> <1384285347-13506-11-git-send-email-geert@linux-m68k.org> <528414A6.8090208@tilera.com> <alpine.DEB.2.02.1311140927170.9407@ayla.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([12.216.194.151]:34079 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753514Ab3KNOzg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 14 Nov 2013 09:55:36 -0500
In-Reply-To: <alpine.DEB.2.02.1311140927170.9407@ayla.of.borg>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/14/2013 3:31 AM, Geert Uytterhoeven wrote:
> Feel free to take v2 below. Thanks!
>
> From d761d4d63945ff0a6eab5a9058c132f870c92aff Mon Sep 17 00:00:00 2001
> From: Geert Uytterhoeven <geert@linux-m68k.org>
> Date: Fri, 8 Nov 2013 21:33:29 +0100
> Subject: [PATCH -v2] tile: Remove tile-specific _sinitdata and _einitdata
>
> Use standard __init_begin and __init_end instead.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Chris Metcalf <cmetcalf@tilera.com>

Taken into the tile tree; thanks!  (I did fix one extra place where it mentioned _sinitdata in a comment.)

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com

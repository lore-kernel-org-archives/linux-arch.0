Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ra.se.axis.com ([195.60.68.13]:39337 "EHLO ra.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755352Ab1ATMLO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 20 Jan 2011 07:11:14 -0500
Date: Thu, 20 Jan 2011 13:11:11 +0100
From: Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [PATCH] cris: use asm-generic/cacheflush.h
Message-ID: <20110120121111.GC9874@axis.com>
References: <1295523136-4277-1-git-send-email-akinobu.mita@gmail.com> <1295523136-4277-4-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1295523136-4277-4-git-send-email-akinobu.mita@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, Mikael Starvik <starvik@axis.com>, linux-cris-kernel <linux-cris-kernel@axis.com>
Message-ID: <20110120121111.18Faiho4ZgocLCvLfmQo88afedIs1OsiDw7aoskpUkQ@z>

On Thu, Jan 20, 2011 at 12:32:16PM +0100, Akinobu Mita wrote:
> The implementation of the cache flushing interfaces on the cris
> is identical with the default implementation in asm-generic.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Mikael Starvik <starvik@axis.com>

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com

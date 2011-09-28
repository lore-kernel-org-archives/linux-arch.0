Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:64393 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754415Ab1I1O6C (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2011 10:58:02 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 05/24] C6X: build infrastructure
Date: Wed, 28 Sep 2011 16:57:59 +0200
References: <1317155405-26235-1-git-send-email-msalter@redhat.com> <201109281523.15680.arnd@arndb.de> <1317220372.2580.68.camel@deneb.redhat.com>
In-Reply-To: <1317220372.2580.68.camel@deneb.redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <201109281657.59636.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20110928145759.A0UVY0eG0Nh5fTDxXuo3EoUOGNhYhvvYqgx93eHfoXE@z>

On Wednesday 28 September 2011, Mark Salter wrote:
> > Also, how different are these boards and socs still? Since you are
> > based on device trees for hardware configuration, do you actually
> > need the options at all?
> 
> The BOARD configs can go. The SOC configs will go out when clkdev
> stuff gets reworked when generic clock bindings are available.
> 
Ok, sounds good.

	Arnd

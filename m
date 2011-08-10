From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 22/24] C6X: specific board support
Date: Wed, 10 Aug 2011 16:26:09 +0200
Message-ID: <201108101626.10256.arnd@arndb.de>
References: <1312839879-13592-1-git-send-email-msalter@redhat.com> <201108091904.43047.arnd@arndb.de> <1312910178.2356.16.camel@deneb.redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:64034 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381Ab1HJO0N (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 10 Aug 2011 10:26:13 -0400
In-Reply-To: <1312910178.2356.16.camel@deneb.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org

On Tuesday 09 August 2011, Mark Salter wrote:
> > 
> > I would argue that none of these should exist. When you have device
> > tree probing,
> > you should be able to do all the initialization according to the
> > device tree contents.
> > 
> 
> Yes, one of your previous replies touched on this point and got me to
> thinking about it. I think it would be fairly easy to get rid of them.
> 

Ok, very good.

	Arnd

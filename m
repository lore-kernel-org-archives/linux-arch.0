From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 13/17] unicore32 io: redefine __REG(x) and re-use readl/writel funcs
Date: Fri, 4 Mar 2011 10:49:14 +0100
Message-ID: <201103041049.14189.arnd@arndb.de>
References: <cover.1298821856.git.epip@hera.kernel.org> <201102281617.00462.arnd@arndb.de> <03a101cbda42$4c48b080$e4da1180$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:57862 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834Ab1CDJtV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 4 Mar 2011 04:49:21 -0500
In-Reply-To: <03a101cbda42$4c48b080$e4da1180$@mprc.pku.edu.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: 'Guan Xuetao' <epip@hera.kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, greg@kroah.com

On Friday 04 March 2011 09:00:55 Guan Xuetao wrote:
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > I was expecting this to get folded into the patches that introduce the files,
> > but this way is fine as well.
> I want to keep the patches for core and additional architecture files stable, so each usage of old __REG macor
> should be replaced by readl/writel and then generating a big patch.

Ok, makes sense.

	Arnd

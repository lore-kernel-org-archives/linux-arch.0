From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 13/17] unicore32 io: redefine __REG(x) and re-use readl/writel funcs
Date: Mon, 28 Feb 2011 16:17:00 +0100
Message-ID: <201102281617.00462.arnd@arndb.de>
References: <cover.1298821856.git.epip@hera.kernel.org> <b05e05c32279bbb45939006a6bbaf7e7183f14ce.1298821856.git.epip@hera.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:59234 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754661Ab1B1PRF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2011 10:17:05 -0500
In-Reply-To: <b05e05c32279bbb45939006a6bbaf7e7183f14ce.1298821856.git.epip@hera.kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guan Xuetao <epip@hera.kernel.org>
Cc: GuanXuetao <gxt@mprc.pku.edu.cn>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, greg@kroah.com

On Sunday 27 February 2011, Guan Xuetao wrote:
> From: GuanXuetao <gxt@mprc.pku.edu.cn>
> 
>   -- by advice of Arnd Bergmann
> 
> Signed-off-by: Guan Xuetao <gxt@mprc.pku.edu.cn>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

I was expecting this to get folded into the patches that introduce the files,
but this way is fine as well.

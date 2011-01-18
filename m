From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: Request for unicore32 architecture codes to merge into linux-next
Date: Tue, 18 Jan 2011 18:10:32 +0900
Message-ID: <20110118091032.GA18525@linux-sh.org>
References: <004901cbb4d5$b9bb1370$2d313a50$@mprc.pku.edu.cn> <20110118043323.GF2122@linux-sh.org> <01b501cbb6ef$3299f2a0$97cdd7e0$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:33787 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061Ab1ARJMu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 18 Jan 2011 04:12:50 -0500
Content-Disposition: inline
In-Reply-To: <01b501cbb6ef$3299f2a0$97cdd7e0$@mprc.pku.edu.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
Cc: sfr@canb.auug.org.au, 'Arnd Bergmann' <arnd@arndb.de>, gregkh@suse.de, jbarnes@virtuousgeek.org, dmitry.torokhov@gmail.com, dtor@mail.ru, rubini@cvml.unipv.it, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-next@vger.kernel.org

On Tue, Jan 18, 2011 at 05:07:41PM +0800, Guan Xuetao wrote:
> IMO, the whole architecture specific codes need to be merged first, and only some
> necessary drivers are included under staging. Then, I could split the staging drivers
> into corresponding mail-list, and then, additional drivers.
> Otherwise, there are no architecture basic for drivers review.
> 
That's of course fine so long as the driver changes are reasonably
self-contained. The situation we want to avoid is that you end up with
drivers that depend on some private infrastructure of API where not
enough context is provided when the two are decoupled. 

In any event, the architecture bits are the most self-contained and have
had the most review of anything in this series of patches, so it probably
makes sense to work on getting those bits integrated and then dealing
with the rest incrementally.

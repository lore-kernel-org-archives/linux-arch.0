From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 01/22] pci-dma-compat: Add pci_zalloc_consistent helper
Date: Mon, 23 Jun 2014 07:03:28 -0700
Message-ID: <1403532208.18747.58.camel@joe-AO725>
References: <cover.1403530604.git.joe@perches.com>
	 <2248b3ffe86cd8995a809bf7e2871f38039979c1.1403530604.git.joe@perches.com>
	 <4279380.YmNJ3E7DEi@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0037.hostedemail.com ([216.40.44.37]:33264 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753393AbaFWODd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 23 Jun 2014 10:03:33 -0400
In-Reply-To: <4279380.YmNJ3E7DEi@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Mon, 2014-06-23 at 15:53 +0200, Arnd Bergmann wrote:
> On Monday 23 June 2014 06:41:29 Joe Perches wrote:
> > Add this helper for consistency with pci_zalloc_coherent
> > and the ability to remove unnecessary memset(,0,) uses.

> Shouldn't these drivers just use the normal dma-mapping API now?

Maybe.  I wouldn't mind.

They do seem to have a trivial bit of unnecessary overhead for 

hwdev == NULL ? NULL : &hwdev->dev

Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:64447 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754570Ab1I1PBC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2011 11:01:02 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 06/24] C6X: early boot code
Date: Wed, 28 Sep 2011 17:00:59 +0200
References: <1317155405-26235-1-git-send-email-msalter@redhat.com> <201109281526.07969.arnd@arndb.de> <1317218820.2580.64.camel@deneb.redhat.com>
In-Reply-To: <1317218820.2580.64.camel@deneb.redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <201109281701.00129.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20110928150059.Bhqo1adXci5PMsMOLJZ2Ery_f-Q3gFADO-nz7sguJC4@z>

On Wednesday 28 September 2011, Mark Salter wrote:
> c6x_silicon_rev is needed by drivers (though none in the current
> patch series) to deal with silicon errata.
> 
> c6x_devstat has pin-strap config info some drivers may need.

Ok, I guess these can be EXPORT_SYMBOL_GPL then, or you could
remove them entirely by evaluating them in the boot loader and
changing the device tree accordingly.

For device drivers, it's usually better to make decisions based
on the revision of the device they talk to, not the revision of
the entire SoC, since that requires knowledge of all SoCs that
contain each version of the hardware macro.

	Arnd

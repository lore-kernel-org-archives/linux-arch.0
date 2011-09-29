From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 00/24] C6X: New architecture
Date: Thu, 29 Sep 2011 15:18:52 +0200
Message-ID: <1480119.xupFVdlN5c@wuerfel>
References: <1317155405-26235-1-git-send-email-msalter@redhat.com> <60327.1317300157@turing-police.cc.vt.edu> <1317301332.2580.108.camel@deneb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:52941 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408Ab1I2NTk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 Sep 2011 09:19:40 -0400
In-Reply-To: <1317301332.2580.108.camel@deneb.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Thursday 29 September 2011 09:02:11 Mark Salter wrote:
> 
> Other models are also possible. For instance, other cores could run
> dedicated DSP applications using some other minimal OS with HW supported
> communication with the Linux OS acting as the overall manager.

Yes, that makes a lot of sense. I guess if you ever want to turn c6x
into something more capable, adding an MMU would be higher on the
priority list than proper SMP, which requires both cache coherency
and atomic operations.

	Arnd

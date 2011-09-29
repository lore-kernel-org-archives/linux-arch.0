From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 00/24] C6X: New architecture
Date: Thu, 29 Sep 2011 12:33:24 +0200
Message-ID: <201109291233.24623.arnd@arndb.de>
References: <1317155405-26235-1-git-send-email-msalter@redhat.com> <22021.1317246541@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:53767 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870Ab1I2Kdk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 Sep 2011 06:33:40 -0400
In-Reply-To: <22021.1317246541@turing-police.cc.vt.edu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Valdis.Kletnieks@vt.edu
Cc: Mark Salter <msalter@redhat.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wednesday 28 September 2011, Valdis.Kletnieks@vt.edu wrote:
>   Show Details
>   On Tue, 27 Sep 2011 16:29:41 EDT, Mark Salter said:
> 
> > This architecture supports members of the Texas Instruments family
> > of C6x single and multicore DSPs. The multicore DSPs do not support
> > cache coherancy, so are not suitable for SMP.
> 
> Is there a usage model for the multicore? I know somebody had some patches for
> "HPC dedicated compute cores" that would just basically run a userspace process
> and that's it - would those be applicable here?

No, that's a different thing. Even with dedicated compute cores, you need
cache coherency.

	Arnd

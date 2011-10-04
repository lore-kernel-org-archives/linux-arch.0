From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 08/24] C6X: memory management and DMA support
Date: Tue, 04 Oct 2011 21:10:10 +0200
Message-ID: <2022911.6LdT5ms78P@wuerfel>
References: <1317746641-26725-1-git-send-email-msalter@redhat.com> <1317746641-26725-9-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:54499 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932820Ab1JDTKW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2011 15:10:22 -0400
In-Reply-To: <1317746641-26725-9-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Aurelien Jacquiot <a-jacquiot@ti.com>

On Tuesday 04 October 2011 12:43:45 Mark Salter wrote:
> From: Aurelien Jacquiot <a-jacquiot@ti.com>
> 
> Original port to early 2.6 kernel using TI COFF toolchain.
> Brought up to date by Mark Salter <msalter@redhat.com>
> 
> The C6X architecture currently lacks an MMU so memory management is relatively
> simple. There is no bus snooping between L2 and main memory but coherent DMA
> memory is supported by making regions of main memory uncached. If such a region
> is desired, it can be specified on the commandline with a "memdma=" argument.
> 
> Signed-off-by: Aurelien Jacquiot <a-jacquiot@ti.com>
> Signed-off-by: Mark Salter <msalter@redhat.com>
> CC: Arnd Bergmann <arnd@arndb.de>


Acked-by: Arnd Bergmann <arnd@arndb.de>

From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 02/24] fixed generic page.h for non-zero PAGE_OFFSET
Date: Tue, 9 Aug 2011 17:11:40 +0200
Message-ID: <201108091711.40499.arnd@arndb.de>
References: <1312839879-13592-1-git-send-email-msalter@redhat.com> <1312839879-13592-3-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:51051 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019Ab1HIPLo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Aug 2011 11:11:44 -0400
In-Reply-To: <1312839879-13592-3-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org

On Monday 08 August 2011, Mark Salter wrote:
> asm-generic/page.h had several problems when used with a non-zero PAGE_OFFSET.
> This patch adds a default ARCH_PFN_OFFSET and fixes the __va, __pa, and
> pfn_valid macros to work with non-zero PAGE_OFFSETs.
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

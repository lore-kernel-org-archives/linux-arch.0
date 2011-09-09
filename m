Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:59558 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758582Ab1IIIRj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Sep 2011 04:17:39 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch v3 22/36] Hexagon: Add locking types and functions
Date: Fri, 09 Sep 2011 10:17:18 +0200
Message-ID: <119603683.IkWCJFkTsl@wuerfel>
In-Reply-To: <20110909010916.801809244@codeaurora.org>
References: <20110909010847.294039464@codeaurora.org> <20110909010916.801809244@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20110909081718.v1TW2mAnlaBw0RpmwfWjd2G2WlCnTDFq7wc8xFjQdIw@z>

On Thursday 08 September 2011 20:09:09 Richard Kuo wrote:
> Moved rwsem to asm-generic.  Will submit a subsequent patch for PPC
> use it from the new location.

Excellent, thanks!
 
> Signed-off-by: Richard Kuo <rkuo@codeaurora.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

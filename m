From: David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 0/4] Use compiler intrinsics for byteswapping
Date: Tue,  4 Dec 2012 10:15:26 +0000
Message-ID: <1354616130-21587-1-git-send-email-dwmw2@infradead.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:43792
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751701Ab2LDKPo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 Dec 2012 05:15:44 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: dwmw2@infradead.org
Cc: x86@kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

This series of patches enables the __builtin_bswapXX() series of functions
that have been supported since GCC 4.4. It allows GCC to emit load-and-swap
or store-and-swap instructions on architectures which support that.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation

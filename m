Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:46212 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbfBMRqk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Feb 2019 12:46:40 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: initramfs tidyups
Date: Wed, 13 Feb 2019 18:46:13 +0100
Message-ID: <20190213174621.29297-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190213174613.OkKElQX8_fgAS4WPEvmv6vI3V8JYjvJszsR1WLutLaY@z>

Hi all,

I've spent some time chasing down behavior in initramfs and found
plenty of opportunity to improve the code.  A first stab on that is
contained in this series.

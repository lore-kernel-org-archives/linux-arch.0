Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:35126 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267AbXIDL4S (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 Sep 2007 07:56:18 -0400
Received: from localhost.localdomain ([127.0.0.1]:28039 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024677AbXIDL4R (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 4 Sep 2007 12:56:17 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l84BuG0a015212
	for <linux-arch@vger.kernel.org>; Tue, 4 Sep 2007 12:56:16 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l84BuGHV015211
	for linux-arch@vger.kernel.org; Tue, 4 Sep 2007 12:56:16 +0100
Date: Tue, 4 Sep 2007 12:56:16 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Removal of dma_cache_* functions?
Message-ID: <20070904115615.GA14986@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Most architectures implement the dma_cache_wback, dma_cache_wback_inv
and dma_cache_wback_inv functions even though there is the more modern
and much better designed DMA API and only two MIPS-specific users (one of
which I just fixed) do remain.  So should we finally start removing it?

  Ralf

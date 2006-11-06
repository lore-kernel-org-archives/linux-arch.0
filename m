Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:55184 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1753283AbWKFQBn
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 6 Nov 2006 11:01:43 -0500
Received: from localhost.localdomain ([127.0.0.1]:32422 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037895AbWKFQBm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 6 Nov 2006 16:01:42 +0000
Date: Mon, 6 Nov 2006 16:02:06 +0000
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Which architectures need 64-bit resources?
Message-ID: <20061106160206.GA10447@linux-mips.org>
References: <20061106122337.GK27140@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061106122337.GK27140@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, Nov 06, 2006 at 05:23:37AM -0700, Matthew Wilcox wrote:

> +       bool "64 bit Memory and IO resources (EXPERIMENTAL)" if (!64BIT && (ARM || X86 || MIPS || PPC) && EXPERIMENTAL)

For MIPS at least it would be needed for a few platforms only, so I'd
like to do "select RESOURCES_64BIT" as suitable for a platform. in the
big machine selection menu in arch/mips/Kconfig.

  Ralf

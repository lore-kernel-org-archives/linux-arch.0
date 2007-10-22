Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:52767 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbXJVPak (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 22 Oct 2007 11:30:40 -0400
Received: from localhost.localdomain ([127.0.0.1]:19620 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024816AbXJVPai (ORCPT <rfc822;linux-arch@vger.kernel.org>
	+ 1 other); Mon, 22 Oct 2007 16:30:38 +0100
Date: Mon, 22 Oct 2007 16:29:12 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/2] irq_flags_t: intro and core annotations
Message-ID: <20071022152912.GA841@linux-mips.org>
References: <20071020235546.GB1825@martell.zuzino.mipt.ru> <20071021005418.GU8181@ftp.linux.org.uk> <20071021093042.GA2144@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071021093042.GA2144@martell.zuzino.mipt.ru>
Sender: linux-arch-owner@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, torvalds@osdl.org, akpm@osdl.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, Oct 21, 2007 at 01:30:42PM +0400, Alexey Dobriyan wrote:

> 			irq_flags_t
> 	
> New type for use with spin_lock_irqsave() and friends.

Talking about it, why did we ever require this to be a long anyway?  I could
get away with a single bit for MIPS; the rest of this variable is pure
bloat.  An abstract datatype could help finally fix this.

  Ralf

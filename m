Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp07.uk.ibm.com ([195.75.94.103]:38663 "EHLO
	e06smtp07.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754633AbcBBL3h (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 2 Feb 2016 06:29:37 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Tue, 2 Feb 2016 11:29:36 -0000
Date: Tue, 2 Feb 2016 12:29:31 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 06/12] s390: move exports to definitions
Message-ID: <20160202112931.GD3990@osiris>
References: <20160129191744.GB17997@ZenIV.linux.org.uk>
 <1454095114-4128-6-git-send-email-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1454095114-4128-6-git-send-email-viro@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20160202112931.nJVAnF8q78SC-hDDXjdnZw2YUmfVDqhjHzq1FhBdAsg@z>

On Fri, Jan 29, 2016 at 07:18:28PM +0000, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  arch/s390/include/asm/Kbuild  |  1 +
>  arch/s390/kernel/Makefile     |  2 +-
>  arch/s390/kernel/entry.S      |  6 ++++++
>  arch/s390/kernel/mcount.S     |  3 +++
>  arch/s390/kernel/s390_ksyms.c | 15 ---------------
>  arch/s390/lib/mem.S           |  3 +++
>  6 files changed, 14 insertions(+), 16 deletions(-)
>  delete mode 100644 arch/s390/kernel/s390_ksyms.c

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>


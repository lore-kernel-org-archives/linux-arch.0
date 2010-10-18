Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:29910 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457Ab0JRUVw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 18 Oct 2010 16:21:52 -0400
Date: Mon, 18 Oct 2010 13:19:31 -0700
From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [PATCH 13/22] ocfs2: use little endian bitops
Message-ID: <20101018201931.GB31479@mail.oracle.com>
References: <1287135981-17604-1-git-send-email-akinobu.mita@gmail.com>
 <1287135981-17604-14-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1287135981-17604-14-git-send-email-akinobu.mita@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Mark Fasheh <mfasheh@suse.com>, ocfs2-devel@oss.oracle.com
Message-ID: <20101018201931.npG0fXNEkAN5j0c7LLf24Jm8VYdFrhSYYchAw_bJDTc@z>

On Fri, Oct 15, 2010 at 06:46:12PM +0900, Akinobu Mita wrote:
> As a preparation for removing ext2 non-atomic bit operations from
> asm/bitops.h. This converts ext2 non-atomic bit operations to
> little endian bit operations.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Mark Fasheh <mfasheh@suse.com>
> Cc: Joel Becker <joel.becker@oracle.com>
> Cc: ocfs2-devel@oss.oracle.com

Acked-by: Joel Becker <joel.becker@oracle.com>


-- 

 There are morethings in heaven and earth, Horatio,
 Than are dreamt of in your philosophy.

Joel Becker
Consulting Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

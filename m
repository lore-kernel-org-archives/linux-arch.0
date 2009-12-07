From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC][PATCHSET] mremap/mmap mess
Date: Mon, 7 Dec 2009 03:58:57 +0000
Message-ID: <20091207035857.GF14381@ZenIV.linux.org.uk>
References: <E1NGzzu-0008RH-T2@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:33856 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933111AbZLGD6v (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 6 Dec 2009 22:58:51 -0500
Content-Disposition: inline
In-Reply-To: <E1NGzzu-0008RH-T2@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-arch@vger.kernel.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org

	Updated series posted, with fixes merged.  It should also cover
the shm bug caught by dwg - in case of hugepage shm we ended up with
oopsen due to b0rken ->get_unmapped_area().

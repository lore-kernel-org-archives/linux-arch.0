Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate7.de.ibm.com ([195.212.29.156]:23106 "EHLO
	mtagate7.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779AbYCaHyG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 31 Mar 2008 03:54:06 -0400
Subject: Re: [PATCH 3/4] s390 renumber TIF_RESTORE_SIGMASK
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20080329001418.D5F3526FA1D@magilla.localdomain>
References: <20080329001230.D013726FA1D@magilla.localdomain>
	 <20080329001418.D5F3526FA1D@magilla.localdomain>
Content-Type: text/plain
Date: Mon, 31 Mar 2008 09:53:26 +0200
Message-ID: <1206950006.26149.0.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Roland McGrath <roland@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-s390@vger.kernel.org, tony.luck@intel.com, linux-ia64@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20080331075326.6D0WKT-ZjTUdHuaJHKezOU3diGeRr7eP3t5fiFU0x60@z>

On Fri, 2008-03-28 at 17:14 -0700, Roland McGrath wrote:
> TIF_RESTORE_SIGMASK no longer needs to be in the _TIF_WORK_* masks.
> Those low bits are scarce, and are all used up now.
> Renumber TIF_RESTORE_SIGMASK to free one up.
> 
> Signed-off-by: Roland McGrath <roland@redhat.com>

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.



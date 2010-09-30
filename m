From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH RESEND v3 03/24] ptrace: change signature of
 arch_ptrace()
Date: Thu, 30 Sep 2010 11:58:28 -0700 (PDT)
Message-ID: <20100930.115828.57462004.davem@davemloft.net>
References: <1285838880-4977-1-git-send-email-namhyung@gmail.com>
	<1285838880-4977-4-git-send-email-namhyung@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:55451
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753384Ab0I3S6H (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 30 Sep 2010 14:58:07 -0400
In-Reply-To: <1285838880-4977-4-git-send-email-namhyung@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: namhyung@gmail.com
Cc: akpm@linux-foundation.org, roland@redhat.com, oleg@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

From: Namhyung Kim <namhyung@gmail.com>
Date: Thu, 30 Sep 2010 18:27:38 +0900

> Fix up the arguments to arch_ptrace() to take account of the fact that
> @addr and @data are now unsigned long rather than long as of a preceding
> patch in this series.
> 
> Signed-off-by: Namhyung Kim <namhyung@gmail.com>
> Cc: linux-arch@vger.kernel.org
> Acked-by: Roland McGrath <roland@redhat.com>
> Acked-by: David Howells <dhowells@redhat.com>

Acked-by: David S. Miller <davem@davemloft.net>

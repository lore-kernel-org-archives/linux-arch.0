From: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v3 11/17] parisc: io: implement dummy relaxed accessor
 macros for writes
Date: Thu, 25 Sep 2014 22:00:06 +0200
Message-ID: <54247446.4030200@gmx.de>
References: <1411579056-16966-1-git-send-email-will.deacon@arm.com> <1411579056-16966-12-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:54476 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752222AbaIYUAQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 25 Sep 2014 16:00:16 -0400
In-Reply-To: <1411579056-16966-12-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux@arm.linux.org.uk

On 09/24/2014 07:17 PM, Will Deacon wrote:
> This patch adds dummy macros for the write accessors to parisc, in the
> same vein as the dummy definitions for the relaxed read accessors.
>
> Cc: Helge Deller <deller@gmx.de>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>   arch/parisc/include/asm/io.h | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)

Acked-by: Helge Deller <deller@gmx.de>

Thanks!
Helge

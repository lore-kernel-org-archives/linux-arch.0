From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH repost 03/16] arm64/uaccess: fix sparse errors
Date: Fri, 23 Jan 2015 15:33:16 +0000
Message-ID: <20150123153316.GB9557@e104818-lin.cambridge.arm.com>
References: <1419499661-8566-1-git-send-email-mst@redhat.com>
 <1419499661-8566-4-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:41947 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbbAWPdm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 23 Jan 2015 10:33:42 -0500
Content-Disposition: inline
In-Reply-To: <1419499661-8566-4-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, Christopher Covington <cov@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Dec 25, 2014 at 09:28:41AM +0000, Michael S. Tsirkin wrote:
> virtio wants to read bitwise types from userspace using get_user.  At the
> moment this triggers sparse errors, since the value is passed through an
> integer.
> 
> Fix that up using __force.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Acked-by: Will Deacon <will.deacon@arm.com>

I'm not sure who's going to merge this series. In the meantime, I
cherry-picked the arm64 patch. Thanks.

-- 
Catalin

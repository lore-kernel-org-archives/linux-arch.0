From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 08/11] sysctl: sparc Use the compat_sys_sysctl
Date: Thu, 05 Nov 2009 17:42:55 -0800 (PST)
Message-ID: <20091105.174255.73080668.davem@davemloft.net>
References: <m1tyx8trik.fsf@fess.ebiederm.org>
	<1257468114-6823-8-git-send-email-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:42184
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757592AbZKFBma (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 5 Nov 2009 20:42:30 -0500
In-Reply-To: <1257468114-6823-8-git-send-email-ebiederm@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: ebiederm@xmission.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Thu,  5 Nov 2009 16:41:51 -0800

> From: Eric W. Biederman <ebiederm@xmission.com>
> 
> Now that we have a generic 32bit compatibility implementation
> there is no need for sparc to implement it's own.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

Acked-by: David S. Miller <davem@davemloft.net>

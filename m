Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:62154 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262051AbUEQVSF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 17 May 2004 17:18:05 -0400
Date: Mon, 17 May 2004 14:16:35 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] Allow arch override for kmem_bufctl_t
Message-Id: <20040517141635.55101363.davem@redhat.com>
In-Reply-To: <40A60984.1070202@colorfullife.com>
References: <40A60984.1070202@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Manfred Spraul <manfred@colorfullife.com>
Cc: akpm@digeo.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sat, 15 May 2004 14:13:56 +0200
Manfred Spraul <manfred@colorfullife.com> wrote:

> The attached patch allows an arch override for this type: Theoretically, 
> unsigned short is sufficient for kmem_bufctl_t and this would reduce the 
> per-object overhead to 2 bytes. But some archs cannot operate on 16-bit 
> values efficiently, thus it's not possible to switch everyone to ushort. 

Just out of curiosity, which arch knowingly has the problem?

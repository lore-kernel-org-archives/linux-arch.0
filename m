Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:11746 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263295AbUCRXIW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 18 Mar 2004 18:08:22 -0500
Date: Thu, 18 Mar 2004 15:08:16 -0800
From: "David S. Miller" <davem@redhat.com>
Subject: Re: compat_sys_sched_setaffinity()
Message-Id: <20040318150816.586b548a.davem@redhat.com>
In-Reply-To: <20040318094624.GJ28212@krispykreme>
References: <20040318010531.1af5b0a9.akpm@osdl.org>
	<20040318011743.475153bf.akpm@osdl.org>
	<20040318094624.GJ28212@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Anton Blanchard <anton@samba.org>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 18 Mar 2004 20:46:24 +1100
Anton Blanchard <anton@samba.org> wrote:

> Remember this patch? :) Dave and you had some concerns that it would
> do bad things on little endian but I cant see why.

I think Anton's patch, or something like it, is definitely the
way to fix this.
